# Content Management Guide

## 📝 How to Add New Content

### 1. Create Content File
Create a new JSON file in `content/individual/[content_id].json`:

```json
{
  "id": "shiva_stotram",
  "title": "Shiva Stotram",
  "description": "Lord Shiva's praises and devotional hymns",
  "content": "ॐ नमः शिवाय\n\nShiva Stotram - Hymn to Lord Shiva...",
  "pages": 8,
  "category": "stotram",
  "author": "Adi Shankaracharya",
  "language": "sanskrit",
  "difficulty": "intermediate",
  "duration": 20,
  "tags": ["shiva", "stotram", "devotion", "hymns"],
  "created_at": "2024-01-15T10:30:00Z",
  "updated_at": "2024-01-15T10:30:00Z",
  "version": "1.0.0",
  "is_featured": false,
  "download_count": 0,
  "rating": 0.0,
  "metadata": {
    "original_source": "Adi Shankaracharya's works",
    "transliteration": "Om Namah Shivaya",
    "meaning": "Hymn praising Lord Shiva's divine qualities",
    "benefits": [
      "Removes obstacles",
      "Brings peace and prosperity",
      "Enhances spiritual growth"
    ],
    "when_to_use": [
      "Daily prayers",
      "Mondays (Shiva's special day)",
      "During meditation"
    ],
    "prerequisites": [
      "Basic understanding of Hindu mythology",
      "Respectful attitude"
    ]
  }
}
```

### 2. Add Translations
Create translation files in `translations/[language]/[content_id].json`:

**Hindi Translation:**
```json
{
  "content_id": "shiva_stotram",
  "language": "hindi",
  "title": "शिव स्तोत्र",
  "content": "ॐ नमः शिवाय\n\nशिव स्तोत्र - भगवान शिव की स्तुति...",
  "pages": 8,
  "translator": "Traditional",
  "translation_quality": "verified",
  "created_at": "2024-01-15T10:30:00Z",
  "updated_at": "2024-01-15T10:30:00Z"
}
```

**English Translation:**
```json
{
  "content_id": "shiva_stotram",
  "language": "english",
  "title": "Shiva Stotram",
  "content": "Om Namah Shivaya\n\nShiva Stotram - Hymn to Lord Shiva...",
  "pages": 8,
  "translator": "Traditional",
  "translation_quality": "verified",
  "created_at": "2024-01-15T10:30:00Z",
  "updated_at": "2024-01-15T10:30:00Z"
}
```

### 3. Update Content Index
Add the new content to `content/index.json`:

```json
{
  "content_list": [
    // ... existing content ...
    {
      "id": "shiva_stotram",
      "title": "Shiva Stotram",
      "category": "stotram",
      "author": "Adi Shankaracharya",
      "pages": 8,
      "difficulty": "intermediate",
      "duration": 20,
      "is_featured": false,
      "download_count": 0,
      "rating": 0.0,
      "languages_available": ["sanskrit", "hindi", "english"],
      "file_path": "individual/shiva_stotram.json"
    }
  ]
}
```

## 🔄 Updating Existing Content

### 1. Update Content File
Edit the content file directly:
- Change `updated_at` timestamp
- Increment `version` number
- Update content, metadata, or other fields

### 2. Update Translations
Edit translation files:
- Update `updated_at` timestamp
- Modify translated content
- Update translator information if needed

### 3. Update Index
Update the content index:
- Modify content list entry
- Update `last_updated` timestamp
- Adjust category counts if needed

## 🗂️ Content Categories

### Available Categories
- **mantra**: Sacred chants and mantras
- **chalisa**: Forty-verse devotional hymns
- **stotram**: Praise hymns and devotional songs
- **sahasranama**: Thousand names of deities
- **sloka**: Verses from scriptures
- **bhajan**: Devotional songs
- **aarti**: Ritual worship songs
- **prayer**: General prayers and invocations

### Adding New Categories
1. Add category to `content/index.json`
2. Create category folder: `content/categories/[category_name]/`
3. Update iOS app category list
4. Add category description and guidelines

## 🌐 Language Support

### Supported Languages
- **sanskrit**: Original language (संस्कृत)
- **hindi**: Hindi (हिंदी)
- **english**: English
- **gujarati**: Gujarati (ગુજરાતી)
- **tamil**: Tamil (தமிழ்)
- **telugu**: Telugu (తెలుగు)
- **bengali**: Bengali (বাংলা)

### Adding New Languages
1. Create language folder: `translations/[language_code]/`
2. Add language to `content/index.json` languages array
3. Update iOS app language enum
4. Add language display name and description

## 📊 Content Statistics

### Tracking Metrics
- **download_count**: Number of downloads
- **rating**: User rating (1-5 stars)
- **is_featured**: Featured content flag
- **created_at**: Creation timestamp
- **updated_at**: Last update timestamp

### Popularity Indicators
- **featured**: Manually curated featured content
- **popular**: Based on download count and rating
- **recent**: Recently added content
- **trending**: Content gaining popularity

## 🔍 Search and Discovery

### Search Fields
Content is searchable by:
- **title**: Content title
- **description**: Brief description
- **content**: Main content text
- **author**: Author name
- **category**: Content category
- **tags**: Keywords and tags
- **metadata**: Benefits, meaning, etc.

### Search Optimization
- Use relevant keywords in titles
- Write descriptive descriptions
- Add comprehensive tags
- Include transliteration for Sanskrit content
- Add meaning and benefits in metadata

## 📱 Mobile App Integration

### Content Loading
The iOS app loads content in this order:
1. **Index**: Load content index for discovery
2. **Search**: Search through content list
3. **Content**: Load individual content files
4. **Translations**: Load translations as needed

### Caching Strategy
- **Index Caching**: Cache content index for faster loading
- **Content Caching**: Cache individual content items
- **Translation Caching**: Cache translations separately
- **Offline Support**: Store downloaded content locally

## 🎯 Content Quality Guidelines

### Content Standards
1. **Accuracy**: Ensure content is accurate and authentic
2. **Completeness**: Include all required fields
3. **Consistency**: Follow naming conventions and formats
4. **Quality**: Use high-quality translations
5. **Relevance**: Ensure content is spiritually meaningful

### Translation Quality
- **verified**: Verified by experts
- **community**: Community translations
- **ai**: AI-generated translations
- **draft**: Work in progress

### Content Validation
Before publishing:
1. Validate JSON syntax
2. Check against schema
3. Verify translations
4. Test with iOS app
5. Review content accuracy

## 🚀 Scaling Your Content

### Content Growth Strategy
1. **Start Small**: Begin with essential content
2. **User Feedback**: Gather user preferences
3. **Community Contributions**: Allow user submissions
4. **Expert Review**: Have content reviewed by experts
5. **Regular Updates**: Keep content fresh and relevant

### Content Organization
- **Hierarchical**: Organize by category and subcategory
- **Tagging**: Use comprehensive tagging system
- **Search**: Implement advanced search features
- **Recommendations**: Suggest related content
- **Collections**: Create content collections

## 📈 Analytics and Insights

### Content Analytics
Track these metrics:
- **Download Count**: Most popular content
- **User Ratings**: Quality indicators
- **Search Queries**: Popular search terms
- **Language Preferences**: Most used languages
- **Category Distribution**: Popular categories

### Content Optimization
Based on analytics:
- **Promote Popular Content**: Feature highly-rated content
- **Improve Discoverability**: Optimize titles and descriptions
- **Add Missing Translations**: Based on user demand
- **Create Related Content**: Based on search patterns
- **Update Outdated Content**: Keep content current

## 🔧 Technical Implementation

### File Naming Conventions
- **Content Files**: `[content_id].json`
- **Translation Files**: `[content_id].json`
- **Category Folders**: `[category_name]/`
- **Language Folders**: `[language_code]/`

### JSON Schema Validation
Use the schema in `content_schema.json` to validate:
- Content structure
- Required fields
- Data types
- Format consistency

### Version Control
- **Content Versions**: Track content changes
- **Translation Versions**: Track translation updates
- **Schema Versions**: Track schema changes
- **App Compatibility**: Ensure backward compatibility

This comprehensive content management system allows you to easily add, update, and organize your spiritual content while maintaining quality and consistency across all languages and platforms.
