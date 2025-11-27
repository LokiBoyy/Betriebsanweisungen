# Betriebsanweisungen Generator - Tech Stack

## Constraints

- **Framework**: Flutter (Web)
- **Hosting**: GitHub Pages (free, static)
- **Goal**: Simplest yet robust solution

---

## Proposed Architecture

```
┌─────────────────────────────────────────────────────┐
│                   GitHub Repository                  │
├─────────────────────────────────────────────────────┤
│                                                      │
│  /assets/pictograms/       → GHS images (.png)      │
│  /data/sdb/                → Sicherheitsdatenblätter │
│  /data/sdb/index.json      → Product registry       │
│  /lib/                     → Flutter app code       │
│  /docs/                    → Built web app (output) │
│                                                      │
└─────────────────────────────────────────────────────┘
                          ↓
                   GitHub Pages
                   (serves /docs)
                          ↓
            https://yourname.github.io/betriebsanweisungen/#/product-id
```

---

## Stack Decision

| Layer | Choice | Why |
|-------|--------|-----|
| **Frontend** | Flutter Web | Your requirement, single codebase |
| **Data Format** | JSON (not Markdown) | Easier parsing in Dart, structured fields |
| **Routing** | Flutter hash routing | Works with GitHub Pages (no server rewrites) |
| **Hosting** | GitHub Pages `/docs` | Zero cost, automatic deploys |
| **Build** | `flutter build web` | Output to `/docs` folder |

---

## Why JSON over Markdown?

| Markdown | JSON |
|----------|------|
| Requires parsing library | Native Dart support |
| Unstructured, error-prone | Strict schema, validated |
| Good for prose | Good for structured data |

**Sicherheitsdatenblätter are structured data** — JSON is the simpler choice.

---

## Data Structure

### `/data/sdb/index.json`
```json
{
  "products": [
    { "id": "aceton", "name": "Aceton", "file": "aceton.json" },
    { "id": "ethanol", "name": "Ethanol", "file": "ethanol.json" }
  ]
}
```

### `/data/sdb/aceton.json`
```json
{
  "id": "aceton",
  "name": "Aceton",
  "cas_number": "67-64-1",
  "pictograms": ["ghs02", "ghs07"],
  "hazard_statements": ["H225", "H319", "H336"],
  "precautionary_statements": ["P210", "P261", "P305+P351+P338"],
  "first_aid": {
    "inhalation": "Move to fresh air...",
    "skin_contact": "Wash with soap and water...",
    "eye_contact": "Rinse immediately...",
    "ingestion": "Do not induce vomiting..."
  },
  "fire_fighting": "Use CO2, foam, or dry powder...",
  "disposal": "Dispose according to local regulations...",
  "emergency_phone": "+49 123 456789"
}
```

---

## Flutter App Structure

```
/lib
├── main.dart                  # Entry point, routing
├── /models
│   └── sicherheitsdatenblatt.dart   # Data model (fromJson)
├── /services
│   └── data_service.dart      # Load JSON via HTTP
├── /screens
│   ├── home_screen.dart       # Product list
│   └── betriebsanweisung_screen.dart  # Single BA view
├── /widgets
│   └── ba_template.dart       # Fixed layout widget
└── /theme
    └── ba_colors.dart         # Legal color constants
```

---

## Routing

```dart
// Hash-based URLs (GitHub Pages compatible)
/#/                     → Home (product list)
/#/ba/aceton            → Betriebsanweisung for Aceton
/#/ba/ethanol           → Betriebsanweisung for Ethanol
```

**Shareable link example:**
```
https://yourcompany.github.io/betriebsanweisungen/#/ba/aceton
```

---

## Build & Deploy

```bash
# Build
flutter build web --base-href "/betriebsanweisungen/"

# Copy to docs (for GitHub Pages)
cp -r build/web/* docs/

# Commit & push
git add docs/
git commit -m "Deploy"
git push
```

GitHub Pages setting: **Source → `/docs` folder on `main` branch**

---

## What This Stack Avoids

| Avoided | Why |
|---------|-----|
| Backend server | Not needed — static JSON |
| Database | Not needed — JSON files |
| Markdown parsing | JSON is simpler in Dart |
| Complex CI/CD | Manual build is sufficient |
| Firebase/Supabase | Overkill for static content |

---

## Limitations (Accepted Trade-offs)

1. **No search** — Browse by list only (add later if needed)
2. **Manual data entry** — JSON files edited by hand
3. **Manual deploy** — Run build command, push to GitHub
4. **No PDF export** — View/print from browser only

---

## Next Steps

1. Set up Flutter project with routing
2. Define complete JSON schema for Sicherheitsdatenblatt
3. Build the Betriebsanweisung template widget
4. Add one sample product end-to-end
5. Deploy to GitHub Pages
