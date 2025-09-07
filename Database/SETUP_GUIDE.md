# Pooja Grantha Database Setup Guide

## 🚀 Quick Setup (5 minutes)

### Step 1: Create GitHub Repository
1. Go to [GitHub.com](https://github.com) and sign in
2. Click "New repository" (green button)
3. Repository name: `pooja-grantha-content` (or any name you prefer)
4. Description: "Sacred texts and spiritual content for Pooja Grantha app"
5. Make it **Public** (required for free raw file access)
6. Don't initialize with README (we'll upload our files)
7. Click "Create repository"

### Step 2: Upload Content Files
1. In your new repository, click "uploading an existing file"
2. Drag and drop the entire `Database` folder from this project
3. Or upload files one by one:
   - `content/index.json`
   - `content/individual/hanuman_chalisa.json`
   - `content/individual/gayatri_mantra.json`
   - `translations/hindi/hanuman_chalisa.json`
   - `translations/english/hanuman_chalisa.json`
   - `translations/hindi/gayatri_mantra.json`
   - `translations/english/gayatri_mantra.json`
4. Add commit message: "Initial content upload"
5. Click "Commit changes"

### Step 3: Update iOS App Configuration
1. Open `ContentAPIService.swift` in your iOS project
2. Replace `[YOUR_USERNAME]` with your GitHub username
3. Replace `[YOUR_REPO_NAME]` with your repository name
4. Example: `https://raw.githubusercontent.com/johnsmith/pooja-grantha-content/main`

### Step 4: Test the Setup
1. Build and run your iOS app
2. The app should now fetch content from GitHub instead of using mock data

## 📁 Repository Structure

Your GitHub repository should look like this:
```
pooja-grantha-content/
├── content/
│   ├── index.json
│   └── individual/
│       ├── hanuman_chalisa.json
│       ├── gayatri_mantra.json
│       └── [other content files]
├── translations/
│   ├── hindi/
│   │   ├── hanuman_chalisa.json
│   │   └── gayatri_mantra.json
│   ├── english/
│   │   ├── hanuman_chalisa.json
│   │   └── gayatri_mantra.json
│   └── [other languages]
└── README.md
```

## 🔧 Adding New Content

### Method 1: Using GitHub Web Interface
1. Go to your repository on GitHub
2. Navigate to the appropriate folder (`content/individual/` for new content)
3. Click "Add file" → "Create new file"
4. Name the file: `[content_id].json`
5. Copy and paste the content JSON
6. Commit changes

### Method 2: Using Git Commands
```bash
# Clone your repository
git clone https://github.com/[username]/[repo-name].git
cd [repo-name]

# Add new content file
cp /path/to/new_content.json content/individual/new_content.json

# Add and commit
git add content/individual/new_content.json
git commit -m "Add new content: [content name]"
git push origin main
```

## 🌐 Adding Translations

### For each new translation:
1. Create a new file: `translations/[language]/[content_id].json`
2. Use the translation schema from `content_schema.json`
3. Update the main content file's `languages_available` array
4. Update `content/index.json` to reflect new language availability

## 📊 Content Management

### Updating Content Index
When you add new content, update `content/index.json`:
1. Add the new content to `content_list` array
2. Update category counts
3. Add to `featured`, `recent`, or `popular` arrays as needed
4. Update `total_content` count
5. Update `last_updated` timestamp

### Content Statistics
Track these metrics in your content files:
- `download_count`: Number of times downloaded
- `rating`: User rating (1-5)
- `is_featured`: Featured content flag
- `created_at`: Creation date
- `updated_at`: Last update date

## 🔍 Search and Discovery

### Content Discovery Methods
1. **Category-based**: Browse by mantra, chalisa, stotram, etc.
2. **Author-based**: Filter by Tulsidas, Vedic, etc.
3. **Language-based**: Show content available in specific languages
4. **Featured content**: Highlighted content
5. **Search**: Text search across titles, descriptions, and content

### Search Implementation
The `ContentAPIService` provides these search methods:
- `searchContent(query:)`: Text-based search
- `getContentByCategory(_:)`: Category filtering
- `getFeaturedContent()`: Featured items
- `getPopularContent()`: Most downloaded
- `getRecentContent()`: Recently added

## 🚀 Performance Optimization

### Caching Strategy
1. **Index Caching**: Cache the content index for faster loading
2. **Content Caching**: Cache individual content items
3. **Translation Caching**: Cache translations separately
4. **Offline Support**: Store downloaded content locally

### CDN Integration (Optional)
For better performance, consider:
1. **GitHub Pages**: Enable for faster content delivery
2. **Cloudflare**: Free CDN for GitHub repositories
3. **jsDelivr**: Alternative CDN for GitHub content

## 🔒 Security and Backup

### Repository Security
1. **Public Repository**: Required for free raw file access
2. **Content Validation**: Validate JSON before committing
3. **Backup Strategy**: Regular repository backups
4. **Version Control**: Use Git tags for content versions

### Content Validation
Before uploading, validate your JSON:
1. Use online JSON validators
2. Check against the schema in `content_schema.json`
3. Test with the iOS app before publishing

## 📱 iOS Integration

### Using the API Service
```swift
// Initialize the service
let apiService = ContentAPIService.shared

// Load content index
await apiService.loadContentIndex()

// Search content
let results = apiService.searchContent(query: "hanuman")

// Fetch specific content
let content = try await apiService.fetchContent(id: "hanuman_chalisa")

// Fetch translation
let translation = try await apiService.fetchTranslation(
    contentId: "hanuman_chalisa", 
    language: "hindi"
)
```

### Error Handling
The service provides comprehensive error handling:
- Network errors
- JSON parsing errors
- Content not found errors
- Invalid URL errors

## 🎯 Best Practices

### Content Guidelines
1. **Consistent Naming**: Use snake_case for file names
2. **Unique IDs**: Ensure content IDs are unique
3. **Complete Metadata**: Fill all required fields
4. **Quality Translations**: Use verified translations when possible
5. **Regular Updates**: Keep content fresh and relevant

### File Organization
1. **Logical Structure**: Organize by category and language
2. **Clear Naming**: Use descriptive file names
3. **Version Control**: Track changes with meaningful commit messages
4. **Documentation**: Keep README files updated

## 🆘 Troubleshooting

### Common Issues
1. **404 Errors**: Check file paths and repository name
2. **JSON Parsing Errors**: Validate JSON syntax
3. **Slow Loading**: Consider caching strategies
4. **Missing Translations**: Check file paths and language codes

### Debug Steps
1. Test URLs directly in browser
2. Check GitHub repository structure
3. Validate JSON files
4. Test with iOS app debugger
5. Check network connectivity

## 📈 Scaling Your Content

### As Your Content Grows
1. **Pagination**: Implement pagination for large content lists
2. **Search Optimization**: Add search indexing
3. **Content Categories**: Expand category system
4. **User Contributions**: Allow community translations
5. **Analytics**: Track content usage and popularity

### Advanced Features
1. **Content Recommendations**: Suggest related content
2. **User Favorites**: Allow users to bookmark content
3. **Offline Sync**: Download content for offline use
4. **Content Updates**: Push updates to users
5. **Multi-language UI**: Support app UI in multiple languages

This setup gives you a completely free, scalable content management system using GitHub as your database!
