# Betriebsanweisungen Generator

A Flutter web application that generates legally compliant German **Betriebsanweisungen** (Operating Instructions) from **Sicherheitsdatenblätter** (Safety Data Sheets).

**Live Application**: [https://lokiboyy.github.io/Betriebsanweisungen/](https://lokiboyy.github.io/Betriebsanweisungen/)

---

## Features

- **Legal Compliance**: Matches German legal Betriebsanweisung template requirements
- **Web-Based**: Accessible from any device with a web browser
- **Shareable Links**: Direct URLs to specific products for easy distribution
- **Print-Friendly**: Browser print creates workplace-ready PDF documents
- **Responsive Design**: Works on desktop, tablet, and mobile devices
- **Static Hosting**: No backend server required, hosted on GitHub Pages

---

## Shareable Link Format

Each Betriebsanweisung has a unique, shareable URL:

```
https://lokiboyy.github.io/Betriebsanweisungen/#/ba/{product-id}
```

### Example Links

| Product | Direct Link |
|---------|-------------|
| Ätzende Reiniger | [https://lokiboyy.github.io/Betriebsanweisungen/#/ba/aetzende-reiniger](https://lokiboyy.github.io/Betriebsanweisungen/#/ba/aetzende-reiniger) |

### How to Use Shareable Links

1. **Bookmarking**: Save the URL for quick access
2. **Email/Chat**: Copy and paste the link to share with colleagues
3. **QR Codes**: Generate QR codes for workplace posting
4. **Documentation**: Reference in safety manuals and training materials

---

## Adding New Products

### Step 1: Create Product JSON File

Create a new JSON file in `/data/sdb/` with the product data:

```bash
touch data/sdb/your-product-id.json
```

**Required structure** (all fields):

```json
{
  "id": "your-product-id",
  "documentNumber": "001",
  "documentDate": "28.11.2024",
  "companyName": "Your Company Name",
  "workplace": "Specific Area (optional)",
  "name": "Product Display Name",
  "hazardCategory": "Ätzend",
  "pictograms": ["ghs05", "ghs07"],
  "safetyEquipment": ["goggles", "gloves", "protective-clothing"],
  "hazardsDescription": "Detailed German text describing hazards...",
  "protectiveMeasures": "Detailed German text for protective measures...",
  "emergencyProcedures": "Detailed German text for emergency procedures...",
  "emergencyPhoneReference": "siehe Aushang",
  "firstAid": {
    "hautkontakt": "Maßnahmen bei Hautkontakt...",
    "augenkontakt": "Maßnahmen bei Augenkontakt...",
    "verschlucken": "Maßnahmen bei Verschlucken...",
    "einatmen": "Maßnahmen bei Einatmen..."
  },
  "firstAiderReference": "siehe Aushang",
  "disposal": "Entsorgungsanweisungen...",
  "responsiblePerson": "Name (optional)"
}
```

**Important**:
- Use UTF-8 encoding for German characters (ä, ü, ö, ß)
- Product ID must be URL-safe (lowercase, hyphens, no spaces)
- All text fields use German language

### Step 2: Update Product Index

Add an entry to `/data/sdb/index.json`:

```json
{
  "products": [
    {
      "id": "your-product-id",
      "name": "Product Display Name",
      "file": "your-product-id.json"
    }
  ]
}
```

**Ensure**:
- `id` matches the product JSON's `id` field
- `file` matches the JSON filename exactly

### Step 3: Rebuild and Deploy

```bash
# Build for production
flutter build web --base-href "/Betriebsanweisungen/"

# Copy to docs folder
cp -r build/web/* docs/

# Commit and push
git add data/ docs/
git commit -m "Add new product: Your Product Name"
git push
```

GitHub Pages will automatically deploy the changes within 1-2 minutes.

### Step 4: Verify

Visit your new product URL:
```
https://lokiboyy.github.io/Betriebsanweisungen/#/ba/your-product-id
```

---

## Pictogram Codes

### GHS Hazard Pictograms

| Code | Description |
|------|-------------|
| `ghs01` | Explodierende Bombe (Explosive) |
| `ghs02` | Flamme (Flammable) |
| `ghs03` | Flamme über Kreis (Oxidizing) |
| `ghs04` | Gasflasche (Gas under pressure) |
| `ghs05` | Ätzwirkung (Corrosive) |
| `ghs06` | Totenkopf (Toxic) |
| `ghs07` | Ausrufezeichen (Harmful/Irritant) |
| `ghs08` | Gesundheitsgefahr (Health hazard) |
| `ghs09` | Umwelt (Environment) |

### Safety Equipment Codes

| Code | Description |
|------|-------------|
| `goggles` | Augenschutz (Eye protection) |
| `gloves` | Handschutz (Hand protection) |
| `protective-clothing` | Schutzkleidung (Protective clothing) |
| `respiratory` | Atemschutz (Respiratory protection) |
| `ear-protection` | Gehörschutz (Hearing protection) |
| `safety-shoes` | Fußschutz (Safety footwear) |
| `face-shield` | Gesichtsschutz (Face shield) |
| `hard-hat` | Kopfschutz (Hard hat) |

---

## Development

### Prerequisites

- Flutter SDK 3.10.0+ (with web support enabled)
- Dart 3.0.0+
- Git

### Setup

```bash
# Clone repository
git clone https://github.com/lokiboyy/Betriebsanweisungen.git
cd Betriebsanweisungen

# Install dependencies
flutter pub get

# Run in development mode
flutter run -d chrome
```

### Project Structure

```
/Betriebsanweisungen
├── /assets/pictograms/     # GHS and safety pictograms
├── /data/sdb/              # Product data (JSON files)
│   ├── index.json          # Product registry
│   └── *.json              # Individual product files
├── /docs/                  # GitHub Pages output (git-tracked)
├── /lib/                   # Flutter application source
│   ├── /models/            # Data models
│   ├── /screens/           # Screen widgets
│   ├── /services/          # Business logic
│   ├── /theme/             # Color and typography
│   ├── /utils/             # Helper functions
│   └── /widgets/           # Reusable UI components
├── /memory-bank/           # Planning and documentation
├── /test/                  # Unit and widget tests
└── /web/                   # Web configuration
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/data_service_test.dart

# Run with coverage
flutter test --coverage
```

**Current test status**: 111/111 tests passing ✅

### Local Testing

```bash
# Build for local testing (no base-href)
flutter build web

# Copy to docs
cp -r build/web/* docs/

# Serve locally
python3 -m http.server --directory docs 8000

# Open browser
open http://localhost:8000/
```

### Production Build

```bash
# Build with GitHub Pages base-href
flutter build web --base-href "/Betriebsanweisungen/"

# Copy to deployment folder
cp -r build/web/* docs/

# Deploy
git add docs/
git commit -m "Deploy: [description]"
git push
```

---

## Technical Details

### Tech Stack

| Component | Technology |
|-----------|-----------|
| Framework | Flutter Web 3.35.7+ |
| Language | Dart 3.9.2+ |
| Routing | go_router 13.0.0 (hash-based) |
| Data Format | JSON |
| HTTP Client | http 1.1.0 |
| Hosting | GitHub Pages |
| Design System | Material Design 3 |

### Architecture

- **Single-page application** with hash-based routing
- **No backend** - all data in JSON files
- **Static hosting** - served from `/docs` folder
- **Client-side rendering** - Flutter CanvasKit
- **Responsive design** - 800px max width on desktop, full-width mobile
- **Caching** - Simple Map-based cache in DataService

### Browser Compatibility

- ✅ Chrome/Chromium/Edge
- ✅ Firefox
- ✅ Safari
- ✅ Mobile browsers (Chrome, Safari iOS, Firefox Mobile)

**Requirements**: Modern browser with ES6 support and Canvas API

---

## Legal Compliance

This application generates Betriebsanweisungen that comply with German workplace safety regulations:

- **§14 GefStoffV** (Gefahrstoffverordnung)
- **Standard color scheme**: Orange (#FF6B00) for headers, off-white (#FFFBF5) for content
- **GHS pictograms**: Official hazard symbols
- **Fixed structure**: 7 legally required sections
- **Print output**: Suitable for workplace posting

**Note**: Content accuracy is the responsibility of the data entry person. Always verify safety information with official Sicherheitsdatenblätter.

---

## License

This project is for internal company use. All GHS pictograms are from public domain sources (UNECE).

---

## Documentation

For detailed documentation, see:

- [CLAUDE.md](CLAUDE.md) - Project instructions for AI assistance
- [memory-bank/architecture.md](memory-bank/architecture.md) - Technical architecture
- [memory-bank/mvp-implementation-plan.md](memory-bank/mvp-implementation-plan.md) - Implementation plan
- [memory-bank/progress.md](memory-bank/progress.md) - Development progress
- [memory-bank/pictogram-naming-conventions.md](memory-bank/pictogram-naming-conventions.md) - Pictogram file mappings

---

## Support

For issues or questions:

1. Check existing documentation in `/memory-bank/`
2. Review test files in `/test/` for usage examples
3. Consult [Flutter documentation](https://docs.flutter.dev/)

---

## Version

**Current Version**: 0.7.0 (Phase 7 Complete)

**Deployment Status**: ✅ Live on GitHub Pages

**Last Updated**: 2024-11-28
