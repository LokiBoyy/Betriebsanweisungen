# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Flutter web application that generates legally compliant German **Betriebsanweisungen** (Operating Instructions) from **Sicherheitsdatenblätter** (Safety Data Sheets). The app is designed to be hosted on GitHub Pages as a static site.

## Project Status

This is a greenfield project in planning stage. See `memory-bank/` for planning documents.

## Tech Stack

- **Frontend**: Flutter Web
- **Data Format**: JSON (not Markdown)
- **Routing**: Flutter hash-based routing (for GitHub Pages compatibility)
- **Hosting**: GitHub Pages (serves from `/docs` folder)
- **Deployment**: Manual build + commit

## Architecture

```
/assets/pictograms/       → GHS hazard pictograms (.png)
/data/sdb/                → Sicherheitsdatenblätter (JSON files)
/data/sdb/index.json      → Product registry/index
/lib/                     → Flutter app source code
/docs/                    → Build output (served by GitHub Pages)
```

### Planned Flutter App Structure

```
/lib
├── main.dart                          # Entry point, routing
├── /models
│   └── sicherheitsdatenblatt.dart     # Data model (fromJson)
├── /services
│   └── data_service.dart              # Load JSON via HTTP
├── /screens
│   ├── home_screen.dart               # Product list
│   └── betriebsanweisung_screen.dart  # Single BA view
├── /widgets
│   └── ba_template.dart               # Fixed layout widget
└── /theme
    └── ba_colors.dart                 # Legal color constants
```

## Data Structure

### Product Index (`/data/sdb/index.json`)
```json
{
  "products": [
    { "id": "aceton", "name": "Aceton", "file": "aceton.json" }
  ]
}
```

### Individual SDB (`/data/sdb/aceton.json`)
```json
{
  "id": "aceton",
  "name": "Aceton",
  "cas_number": "67-64-1",
  "pictograms": ["ghs02", "ghs07"],
  "hazard_statements": ["H225", "H319", "H336"],
  "precautionary_statements": ["P210", "P261", "P305+P351+P338"],
  "first_aid": {
    "inhalation": "...",
    "skin_contact": "...",
    "eye_contact": "...",
    "ingestion": "..."
  },
  "fire_fighting": "...",
  "disposal": "...",
  "emergency_phone": "+49 123 456789"
}
```

## Routing

Hash-based URLs (GitHub Pages compatible):
- `/#/` → Home (product list)
- `/#/ba/aceton` → Betriebsanweisung for Aceton
- `/#/ba/ethanol` → Betriebsanweisung for Ethanol

## Build & Deploy

```bash
# Build for production
flutter build web --base-href "/betriebsanweisungen/"

# Copy build output to docs folder
cp -r build/web/* docs/

# Deploy via git
git add docs/
git commit -m "Deploy build"
git push
```

**GitHub Pages Configuration**: Set source to `/docs` folder on `main` branch.

## Betriebsanweisung Standard Sections

1. **Header** — Company name, product name, workplace/area
2. **Gefahrstoffbezeichnung** — Substance identification
3. **Gefahren für Mensch und Umwelt** — Hazards (with pictograms)
4. **Schutzmaßnahmen und Verhaltensregeln** — Protective measures
5. **Verhalten im Gefahrfall** — Emergency procedures
6. **Erste Hilfe** — First aid measures
7. **Sachgerechte Entsorgung** — Proper disposal
8. **Footer** — Date, signature, revision info

## Key Constraints

- **Fixed Layout**: Betriebsanweisungen follow legally defined structure
- **Fixed Colors**: Specific color coding for sections (blue header, red for hazards)
- **Fixed Pictograms**: Standard GHS symbols in `/assets/pictograms/`
- **Static Hosting**: No backend server required
- **No Database**: All data in JSON files

# IMPORTANT:
- # Always read memory-bank/@architecture.md before writing any code. Include entire database schema.
- # Always read memory-bank/@Betriebsanweisungen-plan-document.md before writing any code.
- # After adding a major feature or completing a milestone, update memory-bank/@architecture.md.

## Known Limitations

- No search functionality (browse by list only)
- Manual data entry (JSON files edited by hand)
- Manual deployment process
- No PDF export (browser print only)
