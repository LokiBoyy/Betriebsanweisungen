# Required Pictogram Files - Phase 6

## Overview
The app currently uses placeholder images for all pictograms. To complete Phase 6, add the following image files to `/assets/pictograms/`.

## Directory Structure
```
/assets/pictograms/
├── Kennzeichnung von Gefahrstoffen/   (GHS hazard pictograms)
├── Gebotszeichen/                     (Safety equipment/PPE)
├── Warnzeichen/                       (Warning signs)
└── Rettungszeichen/                   (Emergency signs)
```

## 1. GHS Hazard Pictograms (9 files)
**Location**: `assets/pictograms/Kennzeichnung von Gefahrstoffen/`
**Format**: `.gif` files
**Source**: [UNECE GHS Pictograms](https://unece.org/transport/standards/transport/dangerous-goods/ghs-pictograms)

| File Name | Description |
|-----------|-------------|
| `GHS_01_gr.gif` | Explosive |
| `GHS_02_gr.gif` | Flammable |
| `GHS_03_gr.gif` | Oxidizing |
| `GHS_04_gr.gif` | Gas under pressure |
| `GHS_05_gr.gif` | Corrosive ⭐ (used in sample) |
| `GHS_06_gr.gif` | Toxic |
| `GHS_07_gr.gif` | Harmful/Irritant |
| `GHS_08_gr.gif` | Health hazard |
| `GHS_09_gr.gif` | Environment |

⭐ = Required for current sample data

## 2. Safety Equipment (4 files minimum)
**Location**: `assets/pictograms/Gebotszeichen/`
**Format**: `.jpg` files
**Standard**: ISO 7010

| File Name | Description |
|-----------|-------------|
| `M004_Augenschutz-benutzen.jpg` | Eye protection ⭐ |
| `M009_Handschutz_benutzen.jpg` | Hand protection ⭐ |
| `M010_Schutzkleidung-benutzen.jpg` | Protective clothing ⭐ |
| `M017_Atemschutz-benutzen.jpg` | Respiratory protection |

⭐ = Required for current sample data

## 3. Warning Signs (1 file minimum)
**Location**: `assets/pictograms/Warnzeichen/`
**Format**: `.jpg` files

| File Name | Description |
|-----------|-------------|
| `W001-Allgemeines-Warnzeichen.jpg` | General warning ⭐ |
| `W023-Warnung-vor-aetzenden-Stoffen.jpg` | Corrosive materials |

⭐ = Required for current sample data

## 4. Emergency Signs (1 file minimum)
**Location**: `assets/pictograms/Rettungszeichen/`
**Format**: `.jpg` files

| File Name | Description |
|-----------|-------------|
| `E003-Erste-Hilfe.jpg` | First aid ⭐ |
| `E011-Augenspueleinrichtung.jpg` | Eye wash station |

⭐ = Required for current sample data

## Minimum Files Needed (7 total)
To run the sample "Ätzende Reiniger" with actual images:
1. `GHS_05_gr.gif` (Corrosive)
2. `M004_Augenschutz-benutzen.jpg` (Eye protection)
3. `M009_Handschutz_benutzen.jpg` (Gloves)
4. `M010_Schutzkleidung-benutzen.jpg` (Protective clothing)
5. `W001-Allgemeines-Warnzeichen.jpg` (General warning)
6. `E003-Erste-Hilfe.jpg` (First aid)
7. All 9 GHS files recommended for future products

## File Requirements
- **Size**: Optimize for web (<50KB each)
- **GHS Dimensions**: 150×150px minimum
- **Safety/Warning/Emergency**: 100×100px minimum
- **Format**: Exact filename match (case-sensitive)
- **Source**: Public domain or properly licensed

## Fallback Behavior
The app currently shows colored placeholders when images are missing:
- **GHS**: Gray box with warning icon
- **Safety**: Blue circle with security icon
- **Warning**: Yellow triangle with exclamation mark
- **Emergency**: Green square with cross icon

## Testing
After adding files, run:
```bash
flutter test
flutter run -d chrome
```

Verify images load correctly in all 7 sections of the Betriebsanweisung.
