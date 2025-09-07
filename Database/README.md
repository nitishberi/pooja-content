# Pooja Grantha Content Database

This repository contains all the sacred texts, prayers, and spiritual content for the Pooja Grantha iOS app.

## Repository Structure

```
Database/
├── content/
│   ├── index.json                 # Master index of all content
│   ├── categories/
│   │   ├── mantras/
│   │   ├── stotrams/
│   │   ├── chalisa/
│   │   └── sahasranama/
│   └── individual/
│       ├── hanuman_chalisa.json
│       ├── gayatri_mantra.json
│       └── shiva_stotram.json
├── translations/
│   ├── hindi/
│   ├── english/
│   ├── sanskrit/
│   ├── gujarati/
│   ├── tamil/
│   ├── telugu/
│   └── bengali/
└── metadata/
    ├── authors.json
    ├── categories.json
    └── themes.json
```

## How to Use

1. **Add New Content**: Create a new JSON file in the appropriate category folder
2. **Add Translations**: Add translation files in the corresponding language folder
3. **Update Index**: Update the `index.json` file to include new content
4. **Commit Changes**: Push changes to GitHub to make them available to the app

## Content Format

Each content file should follow the schema defined in `content_schema.json`.

## API Endpoints

The app fetches content from these GitHub raw URLs:
- Content Index: `https://raw.githubusercontent.com/[username]/[repo]/main/content/index.json`
- Individual Content: `https://raw.githubusercontent.com/[username]/[repo]/main/content/individual/[filename].json`
- Translations: `https://raw.githubusercontent.com/[username]/[repo]/main/translations/[language]/[filename].json`
