import 'package:flutter_test/flutter_test.dart';
import 'package:betriebsanweisungen/models/sicherheitsdatenblatt.dart';

void main() {
  group('Sicherheitsdatenblatt Model Tests - Step 2.1', () {
    test('fromJson: Parse complete JSON with all fields', () {
      // Complete JSON matching the schema
      final json = {
        'id': 'aetzende-reiniger',
        'document_number': '000 Muster',
        'document_date': '01.01.2015',
        'company_name': 'Betrieb: Werkstatt, Produktion',
        'workplace': 'Wasseraufbereitung',
        'name': 'Ätzende Reiniger',
        'hazard_category': 'Ätzend',
        'pictograms': ['ghs05', 'ghs07'],
        'safety_equipment': ['goggles', 'gloves', 'protective-clothing'],
        'hazards_description':
            'Heftiges Erhitzen starker saurer und alkalischer Reiniger...',
        'protective_measures':
            'Schutzhandschuhe, Schutzkleidung und Augenschutz tragen...',
        'emergency_procedures':
            'Bei Leckagen oder Verschütten sofort aufwischen...',
        'emergency_phone_reference': 'siehe Aushang',
        'first_aid': {
          'hautkontakt':
              'sofort zehn Minuten gründlich unter fließendem Wasser abspülen',
          'augenkontakt':
              'sofort bei offenem Lidspalt zehn Minuten unter fließendem Wasser spülen',
          'verschlucken': 'sofort Mund mit Wasser ausspülen',
          'einatmen': 'Frischluft, Arzt konsultieren',
        },
        'first_aider_reference': 'siehe Aushang',
        'disposal': 'Abfälle in gekennzeichneten beständigen Behältern sammeln',
        'responsible_person': 'Max Mustermann',
      };

      final sdb = Sicherheitsdatenblatt.fromJson(json);

      // Verify all fields are populated correctly
      expect(sdb.id, 'aetzende-reiniger');
      expect(sdb.documentNumber, '000 Muster');
      expect(sdb.documentDate, '01.01.2015');
      expect(sdb.companyName, 'Betrieb: Werkstatt, Produktion');
      expect(sdb.workplace, 'Wasseraufbereitung');
      expect(sdb.name, 'Ätzende Reiniger');
      expect(sdb.hazardCategory, 'Ätzend');
      expect(sdb.pictograms, ['ghs05', 'ghs07']);
      expect(
          sdb.safetyEquipment, ['goggles', 'gloves', 'protective-clothing']);
      expect(sdb.hazardsDescription,
          'Heftiges Erhitzen starker saurer und alkalischer Reiniger...');
      expect(sdb.protectiveMeasures,
          'Schutzhandschuhe, Schutzkleidung und Augenschutz tragen...');
      expect(sdb.emergencyProcedures,
          'Bei Leckagen oder Verschütten sofort aufwischen...');
      expect(sdb.emergencyPhoneReference, 'siehe Aushang');
      expect(sdb.firstAid['hautkontakt'],
          'sofort zehn Minuten gründlich unter fließendem Wasser abspülen');
      expect(sdb.firstAid['augenkontakt'],
          'sofort bei offenem Lidspalt zehn Minuten unter fließendem Wasser spülen');
      expect(sdb.firstAid['verschlucken'], 'sofort Mund mit Wasser ausspülen');
      expect(sdb.firstAid['einatmen'], 'Frischluft, Arzt konsultieren');
      expect(sdb.firstAiderReference, 'siehe Aushang');
      expect(sdb.disposal,
          'Abfälle in gekennzeichneten beständigen Behältern sammeln');
      expect(sdb.responsiblePerson, 'Max Mustermann');
    });

    test('fromJson: Parse JSON with missing optional fields (defaults work)',
        () {
      // Minimal JSON with only required fields
      final json = {
        'id': 'test-product',
        'name': 'Test Product',
      };

      final sdb = Sicherheitsdatenblatt.fromJson(json);

      // Verify required fields
      expect(sdb.id, 'test-product');
      expect(sdb.name, 'Test Product');

      // Verify optional fields have defaults
      expect(sdb.documentNumber, '');
      expect(sdb.documentDate, '');
      expect(sdb.companyName, '');
      expect(sdb.workplace, '');
      expect(sdb.hazardCategory, '');
      expect(sdb.pictograms, []);
      expect(sdb.safetyEquipment, []);
      expect(sdb.hazardsDescription, '');
      expect(sdb.protectiveMeasures, '');
      expect(sdb.emergencyProcedures, '');
      expect(sdb.emergencyPhoneReference, 'siehe Aushang');
      expect(sdb.firstAid['hautkontakt'], '');
      expect(sdb.firstAid['augenkontakt'], '');
      expect(sdb.firstAid['verschlucken'], '');
      expect(sdb.firstAid['einatmen'], '');
      expect(sdb.firstAiderReference, 'siehe Aushang');
      expect(sdb.disposal, '');
      expect(sdb.responsiblePerson, '');
    });

    test('toJson: Convert back to JSON and verify output matches input', () {
      final originalJson = {
        'id': 'aceton',
        'document_number': '001',
        'document_date': '15.03.2024',
        'company_name': 'Test Firma GmbH',
        'workplace': 'Labor',
        'name': 'Aceton',
        'hazard_category': 'Entzündlich',
        'pictograms': ['ghs02'],
        'safety_equipment': ['goggles'],
        'hazards_description': 'Leicht entzündlich',
        'protective_measures': 'Von Hitze fernhalten',
        'emergency_procedures': 'Brandbekämpfung',
        'emergency_phone_reference': '112',
        'first_aid': {
          'hautkontakt': 'Mit Wasser abspülen',
          'augenkontakt': 'Augen spülen',
          'verschlucken': 'Arzt konsultieren',
          'einatmen': 'An die frische Luft',
        },
        'first_aider_reference': 'Raum 201',
        'disposal': 'Als Sondermüll entsorgen',
        'responsible_person': 'Dr. Schmidt',
      };

      // Parse from JSON
      final sdb = Sicherheitsdatenblatt.fromJson(originalJson);

      // Convert back to JSON
      final outputJson = sdb.toJson();

      // Verify output matches input
      expect(outputJson['id'], originalJson['id']);
      expect(outputJson['document_number'], originalJson['document_number']);
      expect(outputJson['document_date'], originalJson['document_date']);
      expect(outputJson['company_name'], originalJson['company_name']);
      expect(outputJson['workplace'], originalJson['workplace']);
      expect(outputJson['name'], originalJson['name']);
      expect(outputJson['hazard_category'], originalJson['hazard_category']);
      expect(outputJson['pictograms'], originalJson['pictograms']);
      expect(outputJson['safety_equipment'], originalJson['safety_equipment']);
      expect(outputJson['hazards_description'],
          originalJson['hazards_description']);
      expect(outputJson['protective_measures'],
          originalJson['protective_measures']);
      expect(outputJson['emergency_procedures'],
          originalJson['emergency_procedures']);
      expect(outputJson['emergency_phone_reference'],
          originalJson['emergency_phone_reference']);
      expect(outputJson['first_aid'], originalJson['first_aid']);
      expect(outputJson['first_aider_reference'],
          originalJson['first_aider_reference']);
      expect(outputJson['disposal'], originalJson['disposal']);
      expect(
          outputJson['responsible_person'], originalJson['responsible_person']);
    });

    test('Validation: Throw error when required field "id" is missing', () {
      final json = {
        'name': 'Test Product',
        // 'id' is missing
      };

      expect(
        () => Sicherheitsdatenblatt.fromJson(json),
        throwsA(isA<FormatException>()),
      );
    });

    test('Validation: Throw error when required field "name" is missing', () {
      final json = {
        'id': 'test-product',
        // 'name' is missing
      };

      expect(
        () => Sicherheitsdatenblatt.fromJson(json),
        throwsA(isA<FormatException>()),
      );
    });

    test('German special characters: Verify UTF-8 encoding support', () {
      final json = {
        'id': 'test',
        'name': 'Ätzende Reiniger',
        'hazard_category': 'Ätzend',
        'hazards_description': 'Enthält ätzende Säuren und Laugen (ä, ü, ö, ß)',
        'first_aid': {
          'hautkontakt': 'Gründlich abspülen',
        },
      };

      final sdb = Sicherheitsdatenblatt.fromJson(json);

      // Verify German special characters are preserved
      expect(sdb.name, 'Ätzende Reiniger');
      expect(sdb.hazardCategory, 'Ätzend');
      expect(sdb.hazardsDescription,
          'Enthält ätzende Säuren und Laugen (ä, ü, ö, ß)');
      expect(sdb.firstAid['hautkontakt'], 'Gründlich abspülen');
    });

    test('Field names: Verify they match German legal template requirements',
        () {
      // This test verifies the model has all required fields for legal compliance
      final json = {
        'id': 'test',
        'name': 'Test',
        'document_number': '000',
        'document_date': '01.01.2024',
        'company_name': 'Test GmbH',
        'hazard_category': 'Test',
        'pictograms': ['ghs05'],
        'safety_equipment': ['goggles'],
        'hazards_description': 'Test',
        'protective_measures': 'Test',
        'emergency_procedures': 'Test',
        'emergency_phone_reference': 'Test',
        'first_aid': {
          'hautkontakt': 'Test',
          'augenkontakt': 'Test',
          'verschlucken': 'Test',
          'einatmen': 'Test',
        },
        'first_aider_reference': 'Test',
        'disposal': 'Test',
      };

      final sdb = Sicherheitsdatenblatt.fromJson(json);

      // Verify all legal template fields are accessible
      expect(sdb.documentNumber, isNotNull); // Header section
      expect(sdb.documentDate, isNotNull); // Header section
      expect(sdb.companyName, isNotNull); // Header section
      expect(sdb.name, isNotNull); // Product section
      expect(sdb.hazardCategory, isNotNull); // Product section
      expect(sdb.pictograms, isNotNull); // Hazards section
      expect(sdb.safetyEquipment, isNotNull); // Protective measures
      expect(sdb.hazardsDescription, isNotNull); // Hazards section
      expect(sdb.protectiveMeasures, isNotNull); // Protective measures section
      expect(sdb.emergencyProcedures, isNotNull); // Emergency section
      expect(sdb.emergencyPhoneReference, isNotNull); // Emergency section
      expect(sdb.firstAid, isNotNull); // First aid section
      expect(sdb.firstAid.containsKey('hautkontakt'), true);
      expect(sdb.firstAid.containsKey('augenkontakt'), true);
      expect(sdb.firstAid.containsKey('verschlucken'), true);
      expect(sdb.firstAid.containsKey('einatmen'), true);
      expect(sdb.firstAiderReference, isNotNull); // First aid section
      expect(sdb.disposal, isNotNull); // Disposal section
    });

    test('toString: Verify string representation', () {
      final json = {
        'id': 'test-product',
        'name': 'Test Produkt',
        'hazard_category': 'Ätzend',
      };

      final sdb = Sicherheitsdatenblatt.fromJson(json);
      final str = sdb.toString();

      expect(str, contains('test-product'));
      expect(str, contains('Test Produkt'));
      expect(str, contains('Ätzend'));
    });
  });
}
