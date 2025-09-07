import Foundation
import SwiftUI

// MARK: - Data Models
struct ContentIndex: Codable {
    let version: String
    let lastUpdated: String
    let totalContent: Int
    let categories: [String: CategoryInfo]
    let featured: [String]
    let recent: [String]
    let popular: [String]
    let languages: [String]
    let authors: [String]
    let contentList: [ContentListItem]
    
    enum CodingKeys: String, CodingKey {
        case version
        case lastUpdated = "last_updated"
        case totalContent = "total_content"
        case categories
        case featured
        case recent
        case popular
        case languages
        case authors
        case contentList = "content_list"
    }
}

struct CategoryInfo: Codable {
    let count: Int
    let items: [String]
}

struct ContentListItem: Codable, Identifiable {
    let id: String
    let title: String
    let category: String
    let author: String
    let pages: Int
    let difficulty: String
    let duration: Int
    let isFeatured: Bool
    let downloadCount: Int
    let rating: Double
    let languagesAvailable: [String]
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, category, author, pages, difficulty, duration
        case isFeatured = "is_featured"
        case downloadCount = "download_count"
        case rating
        case languagesAvailable = "languages_available"
        case filePath = "file_path"
    }
}

struct ContentItem: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let content: String
    let pages: Int
    let category: String
    let author: String
    let language: String
    let difficulty: String
    let duration: Int
    let tags: [String]
    let createdAt: String
    let updatedAt: String
    let version: String
    let isFeatured: Bool
    let downloadCount: Int
    let rating: Double
    let metadata: ContentMetadata
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, content, pages, category, author, language, difficulty, duration, tags, version
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isFeatured = "is_featured"
        case downloadCount = "download_count"
        case rating, metadata
    }
}

struct ContentMetadata: Codable {
    let originalSource: String
    let transliteration: String
    let meaning: String
    let benefits: [String]
    let whenToUse: [String]
    let prerequisites: [String]
    
    enum CodingKeys: String, CodingKey {
        case originalSource = "original_source"
        case transliteration, meaning, benefits
        case whenToUse = "when_to_use"
        case prerequisites
    }
}

struct ContentTranslation: Codable {
    let contentId: String
    let language: String
    let title: String
    let content: String
    let pages: Int
    let translator: String
    let translationQuality: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case contentId = "content_id"
        case language, title, content, pages, translator
        case translationQuality = "translation_quality"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - API Service
class ContentAPIService: ObservableObject {
    static let shared = ContentAPIService()
    
    // Replace with your actual GitHub repository details
    private let baseURL = "https://raw.githubusercontent.com/[YOUR_USERNAME]/[YOUR_REPO_NAME]/main"
    private let contentIndexURL: String
    private let contentBaseURL: String
    private let translationsBaseURL: String
    
    @Published var contentIndex: ContentIndex?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private init() {
        self.contentIndexURL = "\(baseURL)/content/index.json"
        self.contentBaseURL = "\(baseURL)/content"
        self.translationsBaseURL = "\(baseURL)/translations"
    }
    
    // MARK: - Public Methods
    
    /// Load the content index from GitHub
    func loadContentIndex() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let index = try await fetchContentIndex()
            await MainActor.run {
                self.contentIndex = index
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to load content index: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    /// Fetch a specific content item by ID
    func fetchContent(id: String) async throws -> ContentItem {
        guard let contentIndex = contentIndex else {
            throw APIError.noContentIndex
        }
        
        guard let contentItem = contentIndex.contentList.first(where: { $0.id == id }) else {
            throw APIError.contentNotFound
        }
        
        let url = "\(contentBaseURL)/\(contentItem.filePath)"
        return try await fetchData(from: url, type: ContentItem.self)
    }
    
    /// Fetch translation for a specific content item and language
    func fetchTranslation(contentId: String, language: String) async throws -> ContentTranslation {
        let url = "\(translationsBaseURL)/\(language)/\(contentId).json"
        return try await fetchData(from: url, type: ContentTranslation.self)
    }
    
    /// Search content based on query
    func searchContent(query: String) -> [ContentListItem] {
        guard let index = contentIndex else { return [] }
        
        let lowercaseQuery = query.lowercased()
        return index.contentList.filter { content in
            content.title.lowercased().contains(lowercaseQuery) ||
            content.author.lowercased().contains(lowercaseQuery) ||
            content.category.lowercased().contains(lowercaseQuery)
        }
    }
    
    /// Get content by category
    func getContentByCategory(_ category: String) -> [ContentListItem] {
        guard let index = contentIndex else { return [] }
        return index.contentList.filter { $0.category == category }
    }
    
    /// Get featured content
    func getFeaturedContent() -> [ContentListItem] {
        guard let index = contentIndex else { return [] }
        return index.contentList.filter { $0.isFeatured }
    }
    
    /// Get popular content
    func getPopularContent() -> [ContentListItem] {
        guard let index = contentIndex else { return [] }
        return index.contentList.filter { index.popular.contains($0.id) }
    }
    
    /// Get recent content
    func getRecentContent() -> [ContentListItem] {
        guard let index = contentIndex else { return [] }
        return index.contentList.filter { index.recent.contains($0.id) }
    }
    
    // MARK: - Private Methods
    
    private func fetchContentIndex() async throws -> ContentIndex {
        return try await fetchData(from: contentIndexURL, type: ContentIndex.self)
    }
    
    private func fetchData<T: Codable>(from urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}

// MARK: - Error Handling
enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case noContentIndex
    case contentNotFound
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        case .noContentIndex:
            return "Content index not loaded"
        case .contentNotFound:
            return "Content not found"
        }
    }
}

// MARK: - Usage Examples
extension ContentAPIService {
    
    /// Example: Load all content and display in a list
    func loadAllContent() async -> [ContentListItem] {
        await loadContentIndex()
        return contentIndex?.contentList ?? []
    }
    
    /// Example: Get content with translations
    func getContentWithTranslations(id: String) async -> (content: ContentItem, translations: [String: ContentTranslation])? {
        do {
            let content = try await fetchContent(id: id)
            var translations: [String: ContentTranslation] = [:]
            
            // Fetch available translations
            for language in contentIndex?.languages ?? [] {
                do {
                    let translation = try await fetchTranslation(contentId: id, language: language)
                    translations[language] = translation
                } catch {
                    // Translation not available for this language
                    continue
                }
            }
            
            return (content, translations)
        } catch {
            return nil
        }
    }
}
