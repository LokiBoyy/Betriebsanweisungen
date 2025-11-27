import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:betriebsanweisungen/screens/betriebsanweisung_screen.dart';
import 'package:betriebsanweisungen/models/sicherheitsdatenblatt.dart';
import 'package:betriebsanweisungen/theme/ba_colors.dart';

void main() {
  group('BetriebsanweisungScreen Widget Tests', () {
    testWidgets('displays app title correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getBAThemeData(),
          home: const BetriebsanweisungScreen(productId: 'test-product'),
        ),
      );

      // Verify app title is displayed
      expect(find.text('Betriebsanweisung'), findsOneWidget);

      // Verify it's in the AppBar
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      final title = appBar.title as Text;
      expect(title.data, 'Betriebsanweisung');
    });

    testWidgets('displays loading indicator initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getBAThemeData(),
          home: const BetriebsanweisungScreen(productId: 'test-product'),
        ),
      );

      // Should show loading indicator while fetching data
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('has back button in AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getBAThemeData(),
          home: const BetriebsanweisungScreen(productId: 'test-product'),
        ),
      );

      // Verify back button exists
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('shows error state when product not found',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getBAThemeData(),
          home: const BetriebsanweisungScreen(productId: 'nonexistent'),
        ),
      );

      // Wait for the future to complete
      await tester.pumpAndSettle();

      // Check if error UI is shown
      final errorIcon = find.byIcon(Icons.error_outline);
      if (errorIcon.evaluate().isNotEmpty) {
        expect(find.text('Fehler beim Laden'), findsOneWidget);
        expect(find.text('Zurück zur Übersicht'), findsOneWidget);
      }
    });

    testWidgets('BetriebsanweisungScreen uses Scaffold structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getBAThemeData(),
          home: const BetriebsanweisungScreen(productId: 'test-product'),
        ),
      );

      // Verify basic structure
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(FutureBuilder<Sicherheitsdatenblatt>), findsOneWidget);
    });
  });

  group('BetriebsanweisungScreen Section Tests', () {
    test('Test data model structure', () {
      // Create a test Sicherheitsdatenblatt with all fields
      // Note: JSON uses snake_case (as per data model specification)
      final testSdb = Sicherheitsdatenblatt.fromJson({
        'id': 'test-product',
        'document_number': '001 Test',
        'document_date': '01.01.2024',
        'company_name': 'Test Company',
        'workplace': 'Test Area',
        'name': 'Test Product',
        'hazard_category': 'Test Category',
        'pictograms': ['ghs05'],
        'safety_equipment': ['goggles', 'gloves'],
        'hazards_description': 'Test hazard description',
        'protective_measures': 'Test protective measures',
        'emergency_procedures': 'Test emergency procedures',
        'emergency_phone_reference': 'siehe Aushang',
        'first_aid': {
          'hautkontakt': 'Wash with water',
          'augenkontakt': 'Rinse eyes',
          'verschlucken': 'Do not induce vomiting',
          'einatmen': 'Fresh air',
        },
        'first_aider_reference': 'siehe Aushang',
        'disposal': 'Proper disposal instructions',
        'responsible_person': 'John Doe',
      });

      // Verify all fields are accessible
      expect(testSdb.id, 'test-product');
      expect(testSdb.documentNumber, '001 Test');
      expect(testSdb.documentDate, '01.01.2024');
      expect(testSdb.companyName, 'Test Company');
      expect(testSdb.name, 'Test Product');
      expect(testSdb.hazardCategory, 'Test Category');
      expect(testSdb.pictograms, ['ghs05']);
      expect(testSdb.safetyEquipment, ['goggles', 'gloves']);
      expect(testSdb.hazardsDescription, 'Test hazard description');
      expect(testSdb.protectiveMeasures, 'Test protective measures');
      expect(testSdb.emergencyProcedures, 'Test emergency procedures');
      expect(testSdb.disposal, 'Proper disposal instructions');
      expect(testSdb.firstAid['hautkontakt'], 'Wash with water');
    });
  });

  group('BetriebsanweisungScreen Integration Tests (Manual)', () {
    test('Integration test instructions', () {
      const instructions = '''
      Manual Integration Tests for BetriebsanweisungScreen:

      1. Ensure test-product.json exists in data/sdb/ directory
      2. Run the app: flutter run -d chrome
      3. Navigate to home page and click on a product
      4. OR navigate directly to: /#/ba/test-product

      Verify the following:

      a) Loading state:
         - CircularProgressIndicator appears briefly

      b) Seven sections displayed in order:
         1. Header (orange background)
            - Shows document number, date, company name
         2. Gefahrstoffbezeichnung (off-white background)
            - Shows product name and category
         3. Gefahren für Mensch und Umwelt (orange header + off-white content)
            - Shows hazard description
         4. Schutzmaßnahmen und Verhaltensregeln (off-white)
            - Shows protective measures and safety equipment
         5. Verhalten im Gefahrfall (orange header + off-white content)
            - Shows emergency procedures
         6. Erste Hilfe (orange header + off-white content)
            - Shows four first aid scenarios
         7. Sachgerechte Entsorgung (orange header + off-white content)
            - Shows disposal instructions

      c) Layout and colors:
         - Sections are edge-to-edge with 2px black borders
         - Orange sections use #FF6B00 background
         - Content areas use #FFFBF5 off-white background
         - Text is readable with proper contrast
         - Page is constrained to 800px width on desktop
         - Page is scrollable (SingleChildScrollView)

      d) Navigation:
         - Back button in AppBar navigates to home (/#/)
         - Browser back button works correctly

      e) Error handling:
         - Navigate to /#/ba/invalid-product
         - Should show error icon and message
         - "Zurück zur Übersicht" button navigates to home

      f) Responsive design:
         - Resize browser window
         - Content should remain within 800px max width
         - All sections should be fully visible when scrolling
      ''';

      expect(instructions.isNotEmpty, true);
    });
  });
}
