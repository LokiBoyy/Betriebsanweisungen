# MVP Implementation Plan
## Betriebsanweisungen Generator

This document provides step-by-step instructions for implementing the MVP. Each step is small, specific, and includes validation tests.

---

## CRITICAL: Legal Template Compliance

This implementation MUST match the official German Betriebsanweisung legal template. A reference image has been provided showing the exact layout, colors, and structure required by law.

### Key Design Requirements:

1. **Color Scheme (from legal template)**:
   - PRIMARY ORANGE: `#FF6B00` - Used for ALL main section headers
   - Content Background: `#FFFBF5` - Off-white/cream for content areas
   - Text: Black on off-white, White on orange
   - Black borders between sections

2. **Layout Pattern**:
   - 7 sections total (not 8 - footer is integrated into disposal section)
   - Sections are edge-to-edge with NO gaps (only black borders separate them)
   - Two-column layouts for pictogram + text sections
   - Alternating orange headers and off-white content areas

3. **Material Design 3**:
   - Use Material Design 3 components throughout
   - Orange as primary color in theme
   - Leverage Material 3 typography and spacing

4. **German Language**:
   - All text must be in German
   - Proper use of special characters: ä, ü, ö, ß
   - UTF-8 encoding throughout

5. **Validation Method**:
   - EVERY widget must be compared side-by-side with the legal template reference image
   - Target: 95%+ visual accuracy match
   - Browser print output must be suitable for workplace posting

**Reference**: See the provided legal template image showing "Ätzende Reiniger" example.

---

## Design Specifications (Industry Standard Best Practices)

### Layout & Dimensions
- **Page Width**: 800px (optimal for A4 print and readability on screens)
- **Mobile Breakpoint**: 600px (below this, switch to single-column layouts)
- **Border Width**: 2px for all section borders (clear visual separation)
- **Padding**: 16px horizontal, 12px vertical (Material Design spacing)

### Typography (Material Design 3)
- **Product Name**: `displaySmall` (36px, bold) - highly prominent
- **Section Headers**: `titleLarge` (22px, bold) - clear hierarchy
- **Section Titles on Orange**: `titleMedium` (16px, medium weight, white)
- **Body Text**: `bodyLarge` (16px) - optimal readability
- **Header Fields**: `bodyMedium` (14px) - subtle but readable

### Pictogram Sizes
- **GHS Pictograms** (product section): 120px × 120px
- **Safety Pictograms** (PPE): 64px × 64px (3-4 displayed horizontally)
- **Warning/First Aid Pictograms**: 80px × 80px

### Color Values (Exact)
- **Primary Orange**: `#FF6B00`
- **Content Background**: `#FFFBF5` (warm off-white, better than pure white for extended reading)
- **Text on Light**: `#1C1B1F` (Material 3 onSurface - slightly softer than pure black)
- **Text on Orange**: `#FFFFFF`
- **Border**: `#1C1B1F`

### Responsive Behavior
- **Desktop (≥800px)**: Two-column layouts, constrained to 800px width, centered
- **Tablet (600-799px)**: Two-column layouts, full width with 16px margins
- **Mobile (<600px)**: Single-column layouts, pictograms stack above text, full width with 12px margins

### Loading & Error States
- **Loading**: Material 3 `CircularProgressIndicator` centered on screen
- **Error**: Material 3 `Card` with error message and "Retry" button
- **Empty State**: Friendly message with icon

### Accessibility
- **Contrast Ratio**: All text meets WCAG AA standard (4.5:1 minimum)
- **Touch Targets**: Minimum 48px × 48px for interactive elements
- **Focus Indicators**: Material 3 default focus rings
- **Screen Reader Support**: Proper semantic HTML structure

---

## Phase 1: Project Setup

### Step 1.1: Initialize Flutter Web Project
**Instructions:**
- Create a new Flutter project with web support enabled
- Set the project name to `betriebsanweisungen`
- Ensure Flutter SDK version supports web builds (3.0.0 or higher)
- Remove all example/demo code from the default project

**Test:**
- Run `flutter doctor` and verify web support is enabled
- Run `flutter run -d chrome` and verify the app launches in browser
- Verify no compilation errors

### Step 1.2: Add Material Design 3 Support
**Instructions:**
- Add `material 3` support in `pubspec.yaml`
- In `main.dart`, set `useMaterial3: true` in ThemeData
- Configure Material 3 color scheme based on orange primary color
- Enable Material 3 typography

**Test:**
- Run the app and verify Material 3 components render
- Check that the theme uses Material 3 design tokens
- Verify typography follows Material 3 specifications

### Step 1.3: Configure Hash-Based Routing
**Instructions:**
- Add `go_router` package to `pubspec.yaml` with hash location strategy
- Configure the router to use hash-based URLs (compatible with GitHub Pages)
- Remove any default routing from `main.dart`

**Test:**
- Build the app and verify URLs use `/#/` format (not `/`)
- Navigate to a test route and verify the browser URL shows the hash symbol

### Step 1.4: Create Base Directory Structure
**Instructions:**
- Create `/assets/pictograms/` directory for GHS images
- Create `/data/sdb/` directory for JSON safety data sheets
- Add these directories to the `assets` section in `pubspec.yaml`
- Create `/docs/` directory at project root (for GitHub Pages output)

**Test:**
- Verify all directories exist in the file system
- Run `flutter build web` and confirm no asset loading errors

---

## Phase 2: Data Layer

### Step 2.1: Define the Sicherheitsdatenblatt Model (Legal Template Compliant)
**Instructions:**
- Create `/lib/models/sicherheitsdatenblatt.dart`
- Define a Dart class with these exact fields to match legal template requirements:
  - `id` (String) - product identifier for URL routing
  - `document_number` (String) - e.g., "000 Muster" displayed in header
  - `document_date` (String) - format "DD.MM.YYYY" for header (stored as string, no date validation)
  - `company_name` (String) - "Betrieb:" field in header
  - `workplace` (String, optional) - specific workplace/area (defaults to empty string)
  - `name` (String) - product name displayed prominently
  - `hazard_category` (String) - e.g., "Ätzend", "Entzündlich" for pictogram label
  - `pictograms` (List of Strings) - GHS codes like ["ghs05", "ghs07"]
  - `safety_equipment` (List of Strings) - PPE pictogram codes like ["goggles", "gloves", "protective-clothing", "respiratory"]
  - `hazards_description` (String) - detailed paragraph text for "Gefahren für Mensch und Umwelt" section
  - `protective_measures` (String) - detailed paragraph text for "Schutzmaßnahmen" section
  - `emergency_procedures` (String) - detailed paragraph text for "Verhalten im Gefahrfall" section
  - `emergency_phone_reference` (String) - e.g., "siehe Aushang" or actual number
  - `first_aid` (Map with keys: hautkontakt, augenkontakt, verschlucken, einatmen) - detailed instructions for each
  - `first_aider_reference` (String) - e.g., "siehe Aushang"
  - `disposal` (String) - detailed disposal instructions
  - `responsible_person` (String, optional) - for signature line (defaults to empty string)
- Implement `fromJson` factory constructor with null safety
- Implement `toJson` method
- Add validation for required fields
- Optional fields should use `?? ''` or `?? []` for defaults

**Test:**
- Create a test JSON object matching the complete schema
- Parse it using `fromJson` and verify all fields are populated correctly
- Test with missing optional fields and verify defaults work
- Convert back to JSON using `toJson` and verify output matches input
- Verify field names match German legal template requirements

### Step 2.2: Create Product Index Model
**Instructions:**
- Create `/lib/models/product_index.dart`
- Define a class for individual product entries with fields: `id`, `name`, `file`
- Define a container class with a `products` list
- Implement `fromJson` for both classes

**Test:**
- Create a sample index JSON with 2 products
- Parse using `fromJson` and verify the products list contains 2 items
- Verify each product has correct id, name, and file fields

### Step 2.3: Implement Data Service
**Instructions:**
- Create `/lib/services/data_service.dart`
- Add `http: ^1.1.0` package to `pubspec.yaml`
- Implement a singleton DataService class
- Implement a method `Future<ProductIndex> loadProductIndex()` that:
  - Loads `data/sdb/index.json` via HTTP GET (relative URL)
  - Parses JSON and returns a `ProductIndex` object
  - Throws descriptive exceptions on failure
- Implement a method `Future<Sicherheitsdatenblatt> loadSicherheitsdatenblatt(String filename)` that:
  - Loads `data/sdb/{filename}` via HTTP GET (relative URL)
  - Parses JSON and returns a `Sicherheitsdatenblatt` object
  - Throws descriptive exceptions on failure
- Use try-catch blocks with specific error messages:
  - Network errors: "Daten konnten nicht geladen werden. Bitte Internetverbindung prüfen."
  - JSON parsing errors: "Datenformat ungültig. Bitte Administrator kontaktieren."
  - File not found: "Produkt nicht gefunden."
- Add optional caching to avoid re-fetching data (use simple Map cache)

**Test:**
- Create a test `index.json` file in `/data/sdb/`
- Call `loadProductIndex()` and verify it returns parsed data
- Create a test product JSON file
- Call `loadSicherheitsdatenblatt()` with the filename and verify parsed data
- Test with invalid JSON and verify error messages are in German
- Test with missing file (404) and verify appropriate error
- Test caching by calling same method twice and verifying only one network request

---

## Phase 3: UI Foundation

### Step 3.1: Define Color Theme Constants (Legal Template Compliant)
**Instructions:**
- Create `/lib/theme/ba_colors.dart`
- Define exact color constants matching the legal Betriebsanweisung template:
  - `baOrange`: `Color(0xFFFF6B00)` - for all section headers/backgrounds
  - `baContentBg`: `Color(0xFFFFFBF5)` - off-white/cream for content areas
  - `baTextDark`: `Color(0xFF1C1B1F)` - Material 3 onSurface color for text
  - `baTextLight`: `Color(0xFFFFFFFF)` - white text on orange backgrounds
  - `baBorder`: `Color(0xFF1C1B1F)` - borders between sections
- Create a `getBAColorScheme()` function that returns Material 3 ColorScheme:
  - `primary`: baOrange
  - `onPrimary`: baTextLight
  - `surface`: baContentBg
  - `onSurface`: baTextDark
  - Use `ColorScheme.fromSeed(seedColor: baOrange)` and override specific colors
- Create a `getBAThemeData()` function that returns complete ThemeData:
  - Set `useMaterial3: true`
  - Apply the custom ColorScheme
  - Set custom text theme with specified font sizes
  - Configure card, button, and other component themes

**Test:**
- Import the colors file in a test widget
- Verify each color constant is accessible
- Create a test container with baOrange background and baTextLight text - verify contrast ratio ≥4.5:1
- Create a test container with baContentBg background and baTextDark text - verify readability
- Compare the orange color against the reference legal template image
- Apply `getBAThemeData()` to MaterialApp and verify all Material 3 components use correct colors
- Verify text scales properly with Material 3 typography

### Step 3.2: Create Home Screen Layout
**Instructions:**
- Create `/lib/screens/home_screen.dart`
- Implement a simple list view that displays product names
- Accept a list of products as a parameter
- Each list item should be a clickable card/tile
- Include a centered app title at the top: "Betriebsanweisungen"
- Use Material Design components (ListView, ListTile or Card)

**Test:**
- Pass a hardcoded list of 3 test products
- Verify all 3 products appear in the list
- Verify the app title displays correctly
- Tap on a list item and verify tap events are detected (can use print statement)

### Step 3.3: Create Betriebsanweisung Screen Layout
**Instructions:**
- Create `/lib/screens/betriebsanweisung_screen.dart`
- Accept a `Sicherheitsdatenblatt` object as parameter
- Create a scrollable layout with placeholder sections for:
  1. Header (product name, CAS number)
  2. Gefahrstoffbezeichnung
  3. Gefahren für Mensch und Umwelt
  4. Schutzmaßnahmen
  5. Verhalten im Gefahrfall
  6. Erste Hilfe
  7. Sachgerechte Entsorgung
  8. Footer
- Use distinct background colors from `ba_colors.dart` for each section
- Use Column with SingleChildScrollView for scrolling

**Test:**
- Pass a test `Sicherheitsdatenblatt` object with sample data
- Verify the screen displays all 8 sections in order
- Verify each section has the correct background color
- Scroll through the entire document and verify all content is accessible

---

## Phase 4: Betriebsanweisung Template

### Step 4.1: Build Header Widget (Legal Template Compliant)
**Instructions:**
- Create `/lib/widgets/ba_header.dart`
- Accept parameters: `documentNumber`, `documentDate`, `companyName`
- Container with `baOrange` background
- Padding: 16px horizontal, 12px vertical
- Top row using `Row` with `MainAxisAlignment.spaceBetween`:
  - Left (flex: 1): "Nr.: {documentNumber}" - `bodyMedium`, white
  - Center (flex: 2): "Betriebsanweisung gem. §14 GefStoffV" - `titleMedium`, white, bold, centered
  - Right (flex: 1): "Stand: {documentDate}" - `bodyMedium`, white, right-aligned
- Bottom row: "Betrieb: {companyName}" - `bodyMedium`, white, left-aligned
- Add 2px black border at bottom (`Border(bottom: BorderSide(color: baBorder, width: 2))`)
- All text color: `baTextLight` (white)

**Test:**
- Render the widget with test data: documentNumber="000 Muster", documentDate="01.01.2015", companyName="Werkstatt, Produktion"
- Verify orange background matches reference template
- Verify three-column layout with correct flex ratios (1:2:1)
- Verify all text is white and readable (contrast ≥4.5:1)
- Verify "Betriebsanweisung gem. §14 GefStoffV" is centered and prominent
- Verify 2px black border at bottom
- Take screenshot and compare to legal template header

### Step 4.2: Build Product Name Section with Pictogram
**Instructions:**
- Create `/lib/widgets/ba_product_section.dart`
- Accept parameters: `productName`, `pictogramCode`, `hazardCategory`
- Container with `baContentBg` background
- Padding: 16px
- Add 2px black border on all sides (`Border.all(color: baBorder, width: 2)`)
- Layout: `Row` with two children:
  - Left (flex: 1, ~20%): `Column` with:
    - GHS pictogram image: `Image.asset('assets/pictograms/{pictogramCode}.png', width: 120, height: 120)`
    - Label text: "{hazardCategory}" - `labelLarge`, centered, `baTextDark`
    - If pictogram fails to load, show gray placeholder box with "?" icon
  - Right (flex: 4, ~80%): Product name
    - Text: "{productName}" - `displaySmall` (36px), bold, `baTextDark`
    - Centered vertically using `Center` widget
- Responsive: On mobile (<600px), stack vertically (Column instead of Row)

**Test:**
- Pass test data: productName="Ätzende Reiniger", pictogramCode="ghs05", hazardCategory="Ätzend"
- Verify two-column layout with 1:4 flex ratio (≈20%:80%)
- Verify pictogram loads at 120×120px
- Verify "Ätzend" label appears below pictogram
- Verify product name uses displaySmall typography (36px, bold)
- Verify 2px black border on all sides
- Verify baContentBg background
- Test with invalid pictogram code and verify placeholder shows
- Resize browser to <600px and verify layout stacks vertically
- Compare proportions to legal template reference image

### Step 4.3: Build Hazards Section (Gefahren für Mensch und Umwelt)
**Instructions:**
- Create `/lib/widgets/ba_hazards_section.dart`
- Apply PRIMARY ORANGE background to section header
- Section header: "Gefahren für Mensch und Umwelt" in WHITE text, bold
- Content area uses OFF-WHITE background
- Display detailed hazard description text (from data model)
- Text should be BLACK, well-formatted, paragraph style
- Include specific hazards like:
  - "Heftiges Erhitzen starker saurer und alkalischer Reiniger..."
  - Chemical reaction warnings
  - Concentration warnings
  - Spray warnings
- Do NOT display H/P codes as simple lists - use full descriptive text
- Add padding: 16px in content area
- Add black borders (top and bottom)

**Test:**
- Pass test hazard description text
- Verify ORANGE header with white "Gefahren für Mensch und Umwelt" title
- Verify OFF-WHITE content area with black text
- Verify text is readable and well-formatted
- Verify black borders separate this section from others
- Compare layout to legal template reference image

### Step 4.4: Build Protective Measures Section (Schutzmaßnahmen)
**Instructions:**
- Create `/lib/widgets/ba_protective_measures_section.dart`
- Accept parameters: `protectiveMeasures` (String), `safetyEquipment` (List<String>)
- Container with `baContentBg` background
- Add 2px black borders top and bottom
- Padding: 16px
- Section title row with OFF-WHITE background (NOT orange for this section):
  - Text: "Schutzmaßnahmen und Verhaltensregeln" - `titleLarge` (22px), bold, `baTextDark`
  - Padding: 12px vertical, 16px horizontal
- Content layout: `Row` (desktop) / `Column` (mobile)
  - Left (flex: 1, ~25%): Safety pictograms
    - Display pictograms from `safetyEquipment` list (e.g., ["goggles", "gloves", "protective-clothing"])
    - Wrap pictograms horizontally using `Wrap` widget with 8px spacing
    - Each pictogram: `Image.asset('assets/pictograms/safety-{code}.png', width: 64, height: 64)`
    - Show up to 4 pictograms; if list is empty, show generic safety icon
  - Right (flex: 3, ~75%): Measures text
    - Display `protectiveMeasures` using `Text` with `bodyLarge`, `baTextDark`
    - Use `textAlign: TextAlign.justify` for better readability
- Responsive: On mobile, pictograms appear above text in single column

**Test:**
- Pass test data: safetyEquipment=["goggles", "gloves", "protective-clothing"], protectiveMeasures="[German text...]"
- Verify OFF-WHITE background (no orange header bar like other sections)
- Verify title "Schutzmaßnahmen und Verhaltensregeln" is prominent
- Verify 3 safety pictograms display on left at 64×64px each
- Verify pictograms have blue circular backgrounds
- Verify measures text displays on right with justified alignment
- Verify 2px black borders top and bottom
- Test responsive: resize to <600px and verify pictograms stack above text
- Compare to legal template reference image

### Step 4.5: Build Emergency Procedures Section (Verhalten im Gefahrfall)
**Instructions:**
- Create `/lib/widgets/ba_emergency_section.dart`
- Apply PRIMARY ORANGE background to section header
- Section header: "Verhalten im Gefahrfall (Unfalltelefon: siehe Aushang)" in WHITE text
- Include emergency phone reference in header
- Content area uses OFF-WHITE background
- Layout: Two columns
  - Left: Warning pictogram (yellow triangle with exclamation or hazard symbol)
  - Right: Detailed emergency procedures from data model
- Include specific instructions:
  - Immediate response to spills/leaks
  - Evacuation procedures
  - Ventilation requirements
  - Fire extinguishing method reference
  - Escape route reference
- Use BLACK text in content area
- Add black borders

**Test:**
- Pass test emergency procedures text
- Verify ORANGE header with white title text
- Verify emergency phone reference in header
- Verify OFF-WHITE content area with warning pictogram on left
- Verify procedures text on right
- Verify black text is readable
- Compare to legal template reference image

### Step 4.6: Build First Aid Section (Erste Hilfe)
**Instructions:**
- Create `/lib/widgets/ba_first_aid_section.dart`
- Apply PRIMARY ORANGE background to section header
- Section header: "Erste Hilfe (Ersthelfer: siehe Aushang)" in WHITE text
- Include first aider reference in header
- Content area uses OFF-WHITE background
- Layout: Two columns
  - Left: First aid pictogram (green with white cross)
  - Right: First aid instructions organized by exposure type
- Display 4 subsections with labels:
  - "Nach Hautkontakt:" - skin contact instructions
  - "Nach Augenkontakt:" - eye contact instructions (bold, prominent)
  - "Nach Verschlucken:" - ingestion instructions
  - "Nach Einatmen:" - inhalation instructions
- Each instruction should include specific actions from data model
- Bold important warnings like "Arzt konsultieren!"
- Use BLACK text in content area
- Add black borders

**Test:**
- Pass test first_aid data with all 4 scenarios populated
- Verify ORANGE header with white title text
- Verify first aider reference in header
- Verify OFF-WHITE content area with first aid pictogram on left
- Verify all 4 subsections appear with correct labels
- Verify each subsection shows detailed instructions
- Verify important warnings are bold/prominent
- Compare to legal template reference image

### Step 4.7: Build Disposal Section (Sachgerechte Entsorgung)
**Instructions:**
- Create `/lib/widgets/ba_disposal_section.dart`
- Apply PRIMARY ORANGE background to section header
- Section header: "Sachgerechte Entsorgung" in WHITE text
- Content area uses OFF-WHITE background
- Display disposal instructions from data model:
  - Container collection in designated containers
  - Regular removal from workplace
  - Prohibition against mixing waste
- Include placeholder for responsible person signature
- Format: "Abfälle in gekennzeichneten beständigen Behältern (...) sammeln..."
- Use BLACK text in content area
- Add black borders
- Include date and signature line at bottom

**Test:**
- Pass test disposal text
- Verify ORANGE header with white title text
- Verify OFF-WHITE content area
- Verify disposal instructions display correctly
- Verify signature line present
- Verify black text is readable
- Compare to legal template reference image

### Step 4.8: Footer Not Required
**Instructions:**
- The legal template shows the footer (date/signature) is integrated into the Disposal section
- No separate footer widget is needed
- Skip this step

**Test:**
- N/A

### Step 4.9: Assemble Complete Template
**Instructions:**
- Update `/lib/screens/betriebsanweisung_screen.dart`
- Replace placeholder sections with the actual widgets created in 4.1-4.7
- Assemble sections in EXACT order per legal template:
  1. Header (ba_header.dart) - orange background
  2. Product section with pictogram (ba_product_section.dart) - off-white
  3. Hazards section (ba_hazards_section.dart) - orange header
  4. Protective measures section (ba_protective_measures_section.dart) - off-white
  5. Emergency procedures section (ba_emergency_section.dart) - orange header
  6. First aid section (ba_first_aid_section.dart) - orange header
  7. Disposal section (ba_disposal_section.dart) - orange header, includes footer
- Use Column with SingleChildScrollView for scrolling
- NO spacing between sections - they should be edge-to-edge with only black borders separating them
- Set page background to white
- Constrain width for desktop viewing (max 800-1000px, centered)
- Pass appropriate data from `Sicherheitsdatenblatt` object to each widget

**Test:**
- Pass a complete test `Sicherheitsdatenblatt` object
- Verify all 7 sections render in exact order
- Verify sections are edge-to-edge (no gaps)
- Verify only black borders separate sections
- Verify orange sections use correct orange color
- Verify off-white sections use correct off-white color
- Verify page is constrained width on desktop and centered
- Scroll through entire document and verify no layout issues
- Take full-page screenshot and compare side-by-side to legal template reference image
- Verify the alternating pattern of orange/off-white matches template

---

## Phase 5: Routing & Navigation

### Step 5.1: Configure Application Routes
**Instructions:**
- In `main.dart`, configure `GoRouter` with two routes:
  - `/#/` → HomeScreen
  - `/#/ba/:productId` → BetriebsanweisungScreen
- The `productId` parameter should be extracted from the URL
- Implement route parameter validation

**Test:**
- Navigate to `/#/` and verify HomeScreen displays
- Navigate to `/#/ba/test` and verify the productId "test" is accessible
- Navigate to an invalid route and verify error handling

### Step 5.2: Implement Product List Loading
**Instructions:**
- In `HomeScreen`, use `data_service.dart` to load the product index on initialization
- Display a loading indicator while data is being fetched
- Display the product list once loaded
- Display an error message if loading fails
- Use FutureBuilder or similar pattern for async data loading

**Test:**
- Launch the app at `/#/`
- Verify loading indicator appears briefly
- Verify product list appears after loading
- Temporarily break the JSON file and verify error message displays
- Fix the JSON and verify list loads correctly again

### Step 5.3: Implement Navigation to Detail View
**Instructions:**
- In `HomeScreen`, make each product list item tappable
- On tap, navigate to `/#/ba/{productId}` using the router
- Pass the product ID as a route parameter

**Test:**
- Tap on a product in the list
- Verify the URL changes to `/#/ba/{productId}`
- Verify the product ID in the URL matches the tapped product
- Use browser back button and verify navigation back to home works

### Step 5.4: Implement Product Detail Loading
**Instructions:**
- In `BetriebsanweisungScreen`, extract the `productId` from route parameters
- Load the product index to find the corresponding JSON filename
- Use `data_service.dart` to load the specific product's JSON file
- Display a loading indicator while fetching
- Display the Betriebsanweisung template once loaded
- Display error if product ID not found or loading fails

**Test:**
- Navigate to `/#/ba/aceton` (if aceton is in your index)
- Verify loading indicator appears
- Verify the correct product data loads and displays
- Navigate to `/#/ba/invalid` and verify error handling
- Verify the correct product name appears in the header

---

## Phase 6: Sample Data & Assets

### Step 6.1: Add All Required Pictogram and Safety Symbol Images
**Instructions:**
- Download GHS pictograms from official sources:
  - **Recommended source**: UNECE official GHS pictograms (public domain)
  - **URL**: https://unece.org/transport/standards/transport/dangerous-goods/ghs-pictograms
  - Required files: ghs02.png, ghs05.png, ghs06.png, ghs07.png, ghs08.png, ghs09.png
  - Save at 150×150px PNG with transparent or white backgrounds
  - Rename files to match codes exactly: `ghs02.png`, `ghs05.png`, etc. (lowercase)
- Download or create safety/PPE pictograms (ISO 7010 standard symbols):
  - **Option 1**: Use royalty-free ISO 7010 pictogram sets from public sources
  - **Option 2**: Create simple versions following ISO 7010 guidelines (blue circle, white symbol)
  - Required files:
    - safety-goggles.png (M004 - Eye protection)
    - safety-gloves.png (M009 - Hand protection)
    - safety-protective-clothing.png (M010 - Protective clothing)
    - safety-respiratory.png (M017 - Respiratory protection)
  - Save at 100×100px PNG with blue circular backgrounds (#0033A0)
  - Ensure images are named exactly with hyphens (lowercase)
- Download or create instruction pictograms:
  - warning-triangle.png: Yellow triangle (#FFD100) with black border and exclamation mark
  - first-aid.png: Green square/circle (#006F3C) with white cross
  - Save at 100×100px PNG
- Save all images to `/assets/pictograms/`
- Ensure all PNGs are optimized for web (compressed, <50KB each)

**Test:**
- Verify all 12 PNG files exist in `/assets/pictograms/` directory
- Open each image in an image viewer and verify:
  - GHS symbols (6 files) have correct symbols and white/transparent backgrounds
  - Safety symbols (4 files) have blue circular backgrounds (#0033A0 or similar)
  - Warning triangle has yellow background (#FFD100 or similar)
  - First aid has green background (#006F3C or similar)
- Verify file names match exactly (lowercase, hyphens where specified)
- Check file sizes are reasonable (<50KB each)
- Run the app and verify images load correctly in their respective sections
- Verify images maintain quality at specified sizes (120px for GHS, 64px for safety, 80px for warning/first-aid)

### Step 6.2: Create Product Index JSON
**Instructions:**
- Create `/data/sdb/index.json`
- Add one product entry for testing (matching the legal template example):
  - id: "aetzende-reiniger"
  - name: "Ätzende Reiniger"
  - file: "aetzende-reiniger.json"
- Ensure valid JSON syntax (use a JSON validator)
- Ensure UTF-8 encoding for German characters

**Test:**
- Validate JSON using an online JSON validator
- Place the file in `/data/sdb/` directory
- Run the app and verify the index loads without errors
- Verify "Ätzende Reiniger" appears in the product list on home screen with correct German characters

### Step 6.3: Create Sample Product JSON (Legal Template Compliant)
**Instructions:**
- Create `/data/sdb/aetzende-reiniger.json` (use the actual example from legal template)
- **IMPORTANT**: User will provide the exact German text from the reference document
- Include all fields matching the updated data model:
  - id: "aetzende-reiniger"
  - document_number: "000 Muster"
  - document_date: "01.01.2015"
  - company_name: "Betrieb: Werkstatt, Produktion, Wasseraufbereitung"
  - workplace: "" (optional, can be empty)
  - name: "Ätzende Reiniger"
  - hazard_category: "Ätzend"
  - pictograms: ["ghs05"] (corrosive symbol)
  - safety_equipment: ["goggles", "gloves", "protective-clothing"] (from reference image - shows 3 PPE icons)
  - hazards_description: "[User will provide exact German text from reference document]"
  - protective_measures: "[User will provide exact German text from reference document]"
  - emergency_procedures: "[User will provide exact German text from reference document]"
  - emergency_phone_reference: "siehe Aushang"
  - first_aid: Object with German text for all 4 scenarios:
    - hautkontakt: "sofort zehn Minuten gründlich unter fließendem Wasser abspülen, getränkte Kleidung zuvor ausziehen. Arzt konsultieren."
    - augenkontakt: "sofort bei offenem Lidspalt und zum äußeren Lidspalt hin zehn Minuten unter fließendem Wasser spülen. Augendusche bzw. Augenspülflasche verwenden. Augenarzt konsultieren!"
    - verschlucken: "sofort Mund mit Wasser ausspülen, Wasser in kleinen Schlucken trinken lassen, Erbrechen nicht anregen. Arzt konsultieren."
    - einatmen: "Frischluft, Arzt konsultieren."
  - first_aider_reference: "siehe Aushang"
  - disposal: "Abfälle in gekennzeichneten beständigen Behältern (...........) sammeln; Abfallbehälter und leere Behälter geschlossen halten; regelmäßig aus dem Arbeitsbereich entfernen. Abfälle nicht vermischen!"
  - responsible_person: "" (optional)
- Use proper German text with special characters (ä, ü, ö, ß)
- Ensure valid JSON syntax with proper UTF-8 encoding
- Format JSON with proper indentation for readability
- Save file with UTF-8 encoding (no BOM)

**Test:**
- Validate JSON using an online JSON validator (e.g., jsonlint.com)
- Verify UTF-8 encoding is correct (German special characters display properly)
- Load the app and navigate to `/#/ba/aetzende-reiniger`
- Verify all sections populate with the correct German text
- Verify pictogram ghs05 displays at 120×120px
- Verify 3 safety pictograms (goggles, gloves, protective-clothing) display at 64×64px
- Verify hazards section shows complete paragraph (not bullet points)
- Verify all first aid scenarios show the correct German instructions
- Verify text matches the legal template reference image character-for-character
- Compare the rendered output side-by-side with the legal template image
- Print to PDF and verify all German characters render correctly

---

## Phase 7: Build & Deployment

### Step 7.1: Configure Build for GitHub Pages
**Instructions:**
- Identify your GitHub Pages URL structure (will be `/{repository-name}/`)
- Update the build command to include base-href parameter
- The command should be: `flutter build web --base-href "/betriebsanweisungen/"`
- Create a `.gitignore` entry for `build/` directory
- Ensure `docs/` directory is NOT in `.gitignore`

**Test:**
- Run the build command
- Verify the build completes successfully with no errors
- Check `build/web/index.html` and verify the base href tag is present
- Verify asset paths in the built files use relative paths

### Step 7.2: Copy Build Output to Docs
**Instructions:**
- After successful build, copy all contents from `build/web/` to `docs/`
- Ensure all subdirectories are copied (assets, canvaskit, etc.)
- Do not modify any files during copy
- Can be done manually or with a script/command

**Test:**
- Verify `docs/` directory contains `index.html`
- Verify `docs/assets/` contains the pictograms and data files
- Verify `docs/` structure matches `build/web/` exactly
- Count files in both directories and verify they match

### Step 7.3: Test Local Build
**Instructions:**
- Serve the `docs/` directory using a local HTTP server
- Use Python's http.server or similar: `python3 -m http.server --directory docs 8000`
- Access the app at `http://localhost:8000/`
- Test all functionality in the built version

**Test:**
- Navigate to home page and verify product list loads
- Click on the product and verify detail page loads
- Verify all images and assets load correctly
- Use browser DevTools to check for 404 errors
- Test routing using browser back/forward buttons

### Step 7.4: Create GitHub Repository
**Instructions:**
- Initialize git repository if not already done: `git init`
- Create a `.gitignore` file excluding: `build/`, `.dart_tool/`, `.idea/`
- Do NOT exclude `docs/` directory
- Create initial commit with all source files and docs
- Create GitHub repository (name: betriebsanweisungen)
- Push to GitHub

**Test:**
- Verify `git status` shows docs directory is tracked
- Verify build directory is ignored
- Verify all source files are committed
- Verify repository is pushed to GitHub successfully
- View the repository on GitHub and verify all files are present

### Step 7.5: Enable GitHub Pages
**Instructions:**
- Go to repository Settings on GitHub
- Navigate to Pages section
- Set Source to "Deploy from a branch"
- Set Branch to "main" or your default branch
- Set Folder to "/docs"
- Save the configuration
- Wait for GitHub to deploy (may take 1-5 minutes)

**Test:**
- Wait for GitHub Actions deployment to complete
- Navigate to the provided GitHub Pages URL
- Verify the app loads in browser
- Test navigation between home and detail views
- Verify all assets and images load correctly
- Copy the URL for a specific product and verify it works as a shareable link

---

## Phase 8: Final Validation

### Step 8.1: End-to-End User Flow Test
**Instructions:**
- Test the complete user journey from a fresh browser session:
  1. Visit the GitHub Pages URL
  2. View the product list
  3. Click on a product
  4. Review the complete Betriebsanweisung
  5. Use browser back button
  6. Copy the product URL
  7. Open in new browser tab
  8. Verify it loads the correct product directly

**Test:**
- Complete all 8 steps above without errors
- Verify each step works as expected
- Verify no console errors in DevTools
- Test on at least 2 different browsers (Chrome, Firefox, or Safari)
- Test on mobile browser (responsive check)

### Step 8.2: Verify Legal Template Compliance (CRITICAL)
**Instructions:**
- Open the Betriebsanweisung for "Ätzende Reiniger" in browser
- Place the legal template reference image side-by-side with the rendered output
- Perform pixel-level comparison of layout and colors:
  - Verify PRIMARY ORANGE color (#FF6B00) matches reference exactly
  - Verify all section headers use orange where shown in template
  - Verify content areas use off-white background
  - Verify section order matches exactly (7 sections total)
  - Verify two-column layouts (pictogram + text) match proportions
  - Verify text formatting and German special characters render correctly
  - Verify all pictograms (GHS, safety, warning, first aid) display with correct colors
  - Verify black borders separate sections
  - Verify no spacing/gaps between sections
- Print or generate PDF from browser
- Verify PDF output preserves colors and layout
- Verify PDF is suitable for workplace posting

**Test:**
- Side-by-side visual comparison passes with 95%+ accuracy
- Print to PDF from browser - all colors and images preserved
- PDF is readable when printed on A4 paper
- All German text (ä, ü, ö, ß) renders correctly in PDF
- No console errors during rendering
- Page width constraint works properly on desktop
- Orange sections clearly stand out visually
- Compare to the provided legal template reference image

### Step 8.3: Validate German Text Content Quality
**Instructions:**
- Review the sample aetzende-reiniger.json data
- Verify all German text is grammatically correct
- Verify all technical safety information is realistic and appropriate
- Verify German workplace safety terminology is used correctly
- Ensure no English placeholder text remains
- Verify special characters (ä, ü, ö, ß) are used correctly throughout
- Cross-reference text content with legal template reference image

**Test:**
- All text is in proper German (no English placeholders)
- German special characters display correctly in all sections
- Safety instructions are clear, realistic, and appropriate
- First aid instructions follow German workplace safety standards
- Text matches the content style from legal template reference
- No "Lorem ipsum" or obvious placeholder text

### Step 8.4: Document Shareable Link Format
**Instructions:**
- Create a simple README.md in the project root
- Document the URL format: `https://{username}.github.io/betriebsanweisungen/#/ba/{productId}`
- Provide example links
- Document how to add new products (create JSON file, add to index)

**Test:**
- Verify README.md exists and is readable
- Verify example URLs work when clicked
- Verify documentation is clear and complete

---

## Success Criteria

The MVP is complete when:

1. ✅ Material Design 3 is properly integrated with Flutter Web
2. ✅ A user can visit the GitHub Pages URL and see a list of products
3. ✅ Clicking a product loads a legally compliant Betriebsanweisung
4. ✅ The Betriebsanweisung layout matches the legal template reference image with 95%+ accuracy
5. ✅ PRIMARY ORANGE color (#FF6B00) is used for all section headers per template
6. ✅ All 7 sections are present in exact order with correct color scheme (orange/off-white alternating pattern)
7. ✅ GHS and safety pictograms display correctly with proper colors
8. ✅ German text renders correctly with all special characters (ä, ü, ö, ß)
9. ✅ Product data loads from JSON files with UTF-8 encoding
10. ✅ URLs are shareable (can bookmark/copy a specific product)
11. ✅ The app works on GitHub Pages with hash-based routing
12. ✅ At least one complete sample product ("Ätzende Reiniger") is included with realistic German safety text
13. ✅ Browser print/PDF output preserves layout and colors for workplace posting
14. ✅ No console errors in production build
15. ✅ Side-by-side comparison with legal template reference image validates compliance

---

## Known Limitations (Accepted for MVP)

- Only one sample product (additional products added manually later)
- No search functionality (browse by list only)
- No PDF export button (use browser print)
- No editing interface (JSON files edited manually)
- No user authentication
- Manual build and deploy process

---

## Post-MVP Enhancements (Out of Scope)

- Add 5-10 more products
- Implement search/filter on home screen
- Add "Export to PDF" button
- Create JSON editing UI
- Implement CI/CD for automatic deployment
- Add version control for Betriebsanweisungen
- Multi-language support

---

## Implementation Clarifications & Decisions

This section documents all clarifications and best-practice decisions made for the implementation.

### Design Specifications
| Aspect | Specification | Rationale |
|--------|--------------|-----------|
| Page Width | 800px fixed, centered | Optimal for A4 print and screen readability |
| Border Width | 2px all borders | Clear visual separation, prints well |
| Mobile Breakpoint | 600px | Material Design standard breakpoint |
| Orange Color | #FF6B00 | From legal template |
| Content Background | #FFFBF5 | Warm off-white, reduces eye strain |
| Text Color (dark) | #1C1B1F | Material 3 onSurface, softer than pure black |

### Typography Scale (Material Design 3)
| Element | Typography Style | Size | Weight |
|---------|-----------------|------|--------|
| Product Name | displaySmall | 36px | Bold |
| Section Headers | titleLarge | 22px | Bold |
| Orange Header Titles | titleMedium | 16px | Medium |
| Body Text | bodyLarge | 16px | Regular |
| Header Fields | bodyMedium | 14px | Regular |
| Pictogram Labels | labelLarge | 14px | Medium |

### Pictogram Specifications
| Type | Size | Location | Source |
|------|------|----------|--------|
| GHS Pictograms | 120×120px | Product section | UNECE official (public domain) |
| Safety/PPE | 64×64px | Protective measures | ISO 7010 standard |
| Warning Symbol | 80×80px | Emergency section | ISO 7010 or custom |
| First Aid Symbol | 80×80px | First aid section | ISO 7010 or custom |

### Responsive Behavior
| Screen Size | Layout | Column Behavior |
|-------------|--------|-----------------|
| ≥800px (Desktop) | Fixed 800px width, centered | Two-column layouts maintained |
| 600-799px (Tablet) | Full width with 16px margins | Two-column layouts maintained |
| <600px (Mobile) | Full width with 12px margins | Switch to single-column, stack vertically |

### Data Model Additions
- **safety_equipment** (List<String>): Controls which PPE pictograms display in protective measures section
- Values: `["goggles", "gloves", "protective-clothing", "respiratory"]`
- Empty list shows generic safety icon

### Technical Decisions
| Decision | Choice | Reason |
|----------|--------|--------|
| HTTP Loading | `http` package with relative URLs | Works for GitHub Pages deployment |
| Caching | Simple Map-based cache | Reduces redundant network requests |
| Error Messages | German language | Matches user-facing content |
| Image Fallback | Gray placeholder with "?" | Graceful degradation |
| Date Format | String (DD.MM.YYYY) | No validation, display as-is |
| Optional Fields | Default to empty string/array | Simplifies null checking |

### Flutter Packages Required
```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^13.0.0        # Hash-based routing
  http: ^1.1.0              # Data loading
```

### Asset Sources
- **GHS Pictograms**: https://unece.org/transport/standards/transport/dangerous-goods/ghs-pictograms
- **Safety Symbols**: ISO 7010 royalty-free sources or custom creation
- **All assets**: Must be optimized for web (<50KB each)

### Print/PDF Considerations
- Page constrained to 800px for A4 compatibility
- All colors preserved in print CSS
- No background graphics that waste toner
- Sufficient contrast for black & white printing (all text/borders are dark)

### Accessibility Features
- WCAG AA contrast ratios (4.5:1 minimum)
- Semantic HTML structure
- 48px minimum touch targets
- Material 3 focus indicators
- Screen reader friendly

### German Language Notes
- All UI text in German
- Error messages in German
- Proper special characters: ä, ü, ö, ß
- UTF-8 encoding (no BOM) for all JSON files
- Text alignment: Justify for long paragraphs, left for short text

### Flutter SDK Requirements
- **Minimum**: Flutter 3.10.0 (for stable Material 3 support)
- **Recommended**: Flutter 3.16.0+ (latest stable with web improvements)
- **Dart**: 3.0.0+

---

## Quick Reference Checklist

Before implementation, ensure you have:
- [ ] Flutter SDK 3.10.0 or higher installed
- [ ] Web development enabled (`flutter config --enable-web`)
- [ ] All 12 pictogram PNG files downloaded and properly named
- [ ] Legal template reference image accessible for comparison
- [ ] German text content from user for sample product
- [ ] Understanding of Material Design 3 components

During implementation, validate:
- [ ] All colors match specification exactly (#FF6B00, #FFFBF5, #1C1B1F)
- [ ] Typography uses Material 3 text styles (no hard-coded font sizes)
- [ ] Borders are exactly 2px throughout
- [ ] Page width is 800px centered on desktop
- [ ] Responsive breakpoint works at 600px
- [ ] All German text renders with correct special characters
- [ ] Side-by-side comparison with legal template shows 95%+ match
- [ ] Print to PDF preserves all formatting

After implementation, test:
- [ ] Load time <2 seconds on average connection
- [ ] No console errors in production build
- [ ] Works in Chrome, Firefox, Safari
- [ ] Responsive layout works on mobile
- [ ] All pictograms load correctly
- [ ] German characters display in all browsers
- [ ] Print output is suitable for workplace posting
- [ ] Shareable URLs work when copied/pasted
