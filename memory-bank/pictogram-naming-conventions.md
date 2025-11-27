# Pictogram Naming Conventions & File Mapping

## Overview
This document maps the pictogram references used in JSON data files to the actual image files in `/assets/pictograms/`.

---

## Directory Structure

```
/assets/pictograms/
├── Kennzeichnung von Gefahrstoffen/   ← GHS hazard pictograms
├── Gebotszeichen/                     ← Mandatory signs (safety equipment/PPE)
├── Warnzeichen/                       ← Warning signs
├── Rettungszeichen/                   ← Emergency/first aid signs
├── Verbotszeichen/                    ← Prohibition signs
├── Brandschutz/                       ← Fire protection signs
└── Piktogramme-Leitern/               ← Ladder pictograms
```

---

## 1. GHS Hazard Pictograms (Gefahrstoffkennzeichnung)

**Location**: `assets/pictograms/Kennzeichnung von Gefahrstoffen/`

**File Format**: `GHS_##_gr.gif` (uppercase, two digits, .gif format)

### Complete Mapping

| JSON Code | Actual Filename | Description |
|-----------|----------------|-------------|
| `ghs01` | `GHS_01_gr.gif` | Explodierende Bombe (Explosive) |
| `ghs02` | `GHS_02_gr.gif` | Flamme (Flammable) |
| `ghs03` | `GHS_03_gr.gif` | Flamme über Kreis (Oxidizing) |
| `ghs04` | `GHS_04_gr.gif` | Gasflasche (Gas under pressure) |
| `ghs05` | `GHS_05_gr.gif` | Ätzwirkung (Corrosive) |
| `ghs06` | `GHS_06_gr.gif` | Totenkopf (Toxic/Poisonous) |
| `ghs07` | `GHS_07_gr.gif` | Ausrufezeichen (Harmful/Irritant) |
| `ghs08` | `GHS_08_gr.gif` | Gesundheitsgefahr (Health hazard) |
| `ghs09` | `GHS_09_gr.gif` | Umwelt (Environment) |

### Usage in JSON

```json
{
  "pictograms": ["ghs05", "ghs07"]
}
```

### File Path Construction

```dart
// In Flutter code:
final code = "ghs05";  // from JSON
final filename = "GHS_${code.substring(3).padLeft(2, '0')}_gr.gif";
// Result: "GHS_05_gr.gif"

final path = "assets/pictograms/Kennzeichnung von Gefahrstoffen/$filename";
// Result: "assets/pictograms/Kennzeichnung von Gefahrstoffen/GHS_05_gr.gif"
```

---

## 2. Safety Equipment / PPE (Gebotszeichen - Mandatory Signs)

**Location**: `assets/pictograms/Gebotszeichen/`

**File Format**: `M###_Description.jpg` (M + 3 digits, .jpg format)

### Complete Mapping

| JSON Code | Actual Filename | Description |
|-----------|----------------|-------------|
| `goggles` | `M004_Augenschutz-benutzen.jpg` | Eye protection (Augenschutz) |
| `gloves` | `M009_Handschutz_benutzen.jpg` | Hand protection (Handschutz) |
| `protective-clothing` | `M010_Schutzkleidung-benutzen.jpg` | Protective clothing (Schutzkleidung) |
| `respiratory` | `M017_Atemschutz-benutzen.jpg` | Respiratory protection (Atemschutz) |
| `ear-protection` | `M003_Gehoerschutz-benutzen.jpg` | Hearing protection (Gehörschutz) |
| `safety-shoes` | `M008_Fussschutz-benutzen.jpg` | Safety footwear (Fußschutz) |
| `face-shield` | `M013_Gesichtsschutz-benutzen.jpg` | Face shield (Gesichtsschutz) |
| `hard-hat` | `M014_Kopfschutz-benutzen.jpg` | Hard hat (Kopfschutz) |
| `high-vis-vest` | `M015_Warnweste-benutzen.jpg` | High visibility vest (Warnweste) |
| `safety-apron` | `M026_Schutzschuerze-benutzen.jpg` | Safety apron (Schutzschürze) |

### Usage in JSON

```json
{
  "safety_equipment": ["goggles", "gloves", "protective-clothing"]
}
```

### File Path Construction

```dart
// Mapping dictionary
final Map<String, String> safetyEquipmentFiles = {
  'goggles': 'M004_Augenschutz-benutzen.jpg',
  'gloves': 'M009_Handschutz_benutzen.jpg',
  'protective-clothing': 'M010_Schutzkleidung-benutzen.jpg',
  'respiratory': 'M017_Atemschutz-benutzen.jpg',
  'ear-protection': 'M003_Gehoerschutz-benutzen.jpg',
  'safety-shoes': 'M008_Fussschutz-benutzen.jpg',
  'face-shield': 'M013_Gesichtsschutz-benutzen.jpg',
  'hard-hat': 'M014_Kopfschutz-benutzen.jpg',
  'high-vis-vest': 'M015_Warnweste-benutzen.jpg',
  'safety-apron': 'M026_Schutzschuerze-benutzen.jpg',
};

// Usage:
final code = "goggles";  // from JSON
final filename = safetyEquipmentFiles[code];
final path = "assets/pictograms/Gebotszeichen/$filename";
// Result: "assets/pictograms/Gebotszeichen/M004_Augenschutz-benutzen.jpg"
```

---

## 3. Warning Signs (Warnzeichen)

**Location**: `assets/pictograms/Warnzeichen/`

**File Format**: `W###-Description.jpg` (W + 3 digits, .jpg format)

### Key Warning Signs for Betriebsanweisungen

| JSON Code | Actual Filename | Description | Usage |
|-----------|----------------|-------------|-------|
| `warning-general` | `W001-Allgemeines-Warnzeichen.jpg` | General warning (triangle with !) | Emergency section |
| `warning-corrosive` | `W023-Warnung-vor-aetzenden-Stoffen.jpg` | Corrosive materials | Hazards section |
| `warning-toxic` | `W016-Warnung-vor-giftigen-Stoffen.jpg` | Toxic substances | Hazards section |
| `warning-fire` | `W021-Warnung-vor-feuergefaehrlichen.jpg` | Fire hazard | Hazards section |
| `warning-explosive` | `W002 Warnung vor explosionsgefährlichen Stoffen.jpg` | Explosive materials | Hazards section |

### File Path Construction

```dart
final Map<String, String> warningFiles = {
  'warning-general': 'W001-Allgemeines-Warnzeichen.jpg',
  'warning-corrosive': 'W023-Warnung-vor-aetzenden-Stoffen.jpg',
  'warning-toxic': 'W016-Warnung-vor-giftigen-Stoffen.jpg',
  'warning-fire': 'W021-Warnung-vor-feuergefaehrlichen.jpg',
  'warning-explosive': 'W002 Warnung vor explosionsgefährlichen Stoffen.jpg',
};
```

---

## 4. Emergency / First Aid Signs (Rettungszeichen)

**Location**: `assets/pictograms/Rettungszeichen/`

**File Format**: `E###-Description.jpg` (E + 3 digits, .jpg format)

### Key Emergency Signs for Betriebsanweisungen

| JSON Code | Actual Filename | Description | Usage |
|-----------|----------------|-------------|-------|
| `first-aid` | `E003-Erste-Hilfe.jpg` | First aid (green cross) | First aid section |
| `eye-wash` | `E011-Augenspueleinrichtung.jpg` | Eye wash station | First aid section |
| `emergency-shower` | `E012-Notdusche.jpg` | Emergency shower | First aid section |
| `emergency-phone` | `E004-Notruftelefon.jpg` | Emergency telephone | Emergency section |

### File Path Construction

```dart
final Map<String, String> emergencyFiles = {
  'first-aid': 'E003-Erste-Hilfe.jpg',
  'eye-wash': 'E011-Augenspueleinrichtung.jpg',
  'emergency-shower': 'E012-Notdusche.jpg',
  'emergency-phone': 'E004-Notruftelefon.jpg',
};
```

---

## Recommended JSON Data Structure Updates

### Example: Ätzende Reiniger (Corrosive Cleaners)

**Current approach** (needs helper function):
```json
{
  "pictograms": ["ghs05", "ghs07"],
  "safety_equipment": ["goggles", "gloves", "protective-clothing"]
}
```

**Helper functions needed** (to be implemented in Phase 3-4):

```dart
// Helper class for pictogram paths
class PictogramPaths {
  // GHS pictograms
  static String getGHSPath(String code) {
    final number = code.substring(3).padLeft(2, '0');
    return 'assets/pictograms/Kennzeichnung von Gefahrstoffen/GHS_${number}_gr.gif';
  }

  // Safety equipment mapping
  static final Map<String, String> _safetyEquipment = {
    'goggles': 'M004_Augenschutz-benutzen.jpg',
    'gloves': 'M009_Handschutz_benutzen.jpg',
    'protective-clothing': 'M010_Schutzkleidung-benutzen.jpg',
    'respiratory': 'M017_Atemschutz-benutzen.jpg',
  };

  static String getSafetyEquipmentPath(String code) {
    final filename = _safetyEquipment[code];
    if (filename == null) return '';
    return 'assets/pictograms/Gebotszeichen/$filename';
  }

  // Warning signs mapping
  static final Map<String, String> _warnings = {
    'warning-general': 'W001-Allgemeines-Warnzeichen.jpg',
    'warning-corrosive': 'W023-Warnung-vor-aetzenden-Stoffen.jpg',
  };

  static String getWarningPath(String code) {
    final filename = _warnings[code];
    if (filename == null) return '';
    return 'assets/pictograms/Warnzeichen/$filename';
  }

  // Emergency signs mapping
  static final Map<String, String> _emergency = {
    'first-aid': 'E003-Erste-Hilfe.jpg',
    'eye-wash': 'E011-Augenspueleinrichtung.jpg',
  };

  static String getEmergencyPath(String code) {
    final filename = _emergency[code];
    if (filename == null) return '';
    return 'assets/pictograms/Rettungszeichen/$filename';
  }
}
```

---

## Usage Examples in Widget Code

### Display GHS Pictogram

```dart
// From JSON: "pictograms": ["ghs05"]
final ghsCode = sdb.pictograms[0];  // "ghs05"
final imagePath = PictogramPaths.getGHSPath(ghsCode);
// Result: "assets/pictograms/Kennzeichnung von Gefahrstoffen/GHS_05_gr.gif"

Image.asset(
  imagePath,
  width: 120,
  height: 120,
  errorBuilder: (context, error, stackTrace) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.grey[300],
      child: Icon(Icons.warning, size: 60),
    );
  },
);
```

### Display Safety Equipment

```dart
// From JSON: "safety_equipment": ["goggles", "gloves"]
final equipment = sdb.safetyEquipment;
Row(
  children: equipment.map((code) {
    final imagePath = PictogramPaths.getSafetyEquipmentPath(code);
    return Padding(
      padding: EdgeInsets.all(4),
      child: Image.asset(imagePath, width: 64, height: 64),
    );
  }).toList(),
);
```

---

## Asset Configuration in pubspec.yaml

**Current configuration**:
```yaml
flutter:
  assets:
    - assets/pictograms/
    - data/sdb/
```

This automatically includes all subdirectories and files, so the current configuration is correct.

---

## File Format Summary

| Category | Location | File Pattern | Format |
|----------|----------|--------------|--------|
| GHS Hazards | `Kennzeichnung von Gefahrstoffen/` | `GHS_##_gr.gif` | .gif |
| Safety Equipment | `Gebotszeichen/` | `M###_Description.jpg` | .jpg |
| Warning Signs | `Warnzeichen/` | `W###-Description.jpg` | .jpg |
| Emergency Signs | `Rettungszeichen/` | `E###-Description.jpg` | .jpg |
| Prohibition Signs | `Verbotszeichen/` | `P###-Description.jpg` | .jpg |
| Fire Protection | `Brandschutz/` | `F###-Description.jpg` | .jpg |

---

## Action Items for Phase 3-4

1. ✅ **Phase 2 (Complete)**: JSON structure uses simple codes (`ghs05`, `goggles`)
2. ⏳ **Phase 3-4 (To Do)**: Create `PictogramPaths` helper class
3. ⏳ **Phase 3-4 (To Do)**: Use helper in all widget implementations
4. ⏳ **Phase 3-4 (To Do)**: Add error handling for missing images

---

## Notes

- **File formats**: GHS are .gif, all others are .jpg
- **Case sensitivity**: Actual files use mixed case (e.g., `GHS_05_gr.gif`)
- **Spaces in filenames**: Some files have spaces (e.g., `W002 Warnung vor...`)
- **Consistency**: Use the JSON codes in data files, convert to actual paths in code
- **Fallback**: Always provide error builders for missing images
