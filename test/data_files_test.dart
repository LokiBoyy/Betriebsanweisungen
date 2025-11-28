import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:betriebsanweisungen/models/product_index.dart';
import 'package:betriebsanweisungen/models/sicherheitsdatenblatt.dart';
import 'package:betriebsanweisungen/utils/pictogram_paths.dart';

void main() {
  group('Data Files - Product Index', () {
    test('index.json file exists', () {
      final file = File('data/sdb/index.json');
      expect(file.existsSync(), true,
          reason: 'index.json must exist in data/sdb/ directory');
    });

    test('index.json is valid JSON', () {
      final file = File('data/sdb/index.json');
      final content = file.readAsStringSync();

      expect(() => json.decode(content), returnsNormally,
          reason: 'index.json must be valid JSON');
    });

    test('index.json can be parsed as ProductIndex', () {
      final file = File('data/sdb/index.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);

      expect(() => ProductIndex.fromJson(jsonData), returnsNormally,
          reason: 'index.json must match ProductIndex schema');
    });

    test('index.json contains at least one product', () {
      final file = File('data/sdb/index.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final index = ProductIndex.fromJson(jsonData);

      expect(index.products.length, greaterThan(0),
          reason: 'index.json must contain at least one product');
    });

    test('all product entries have required fields', () {
      final file = File('data/sdb/index.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final index = ProductIndex.fromJson(jsonData);

      for (final product in index.products) {
        expect(product.id, isNotEmpty,
            reason: 'Product ID must not be empty');
        expect(product.name, isNotEmpty,
            reason: 'Product name must not be empty');
        expect(product.file, isNotEmpty,
            reason: 'Product file must not be empty');
        expect(product.file.endsWith('.json'), true,
            reason: 'Product file must be a .json file');
      }
    });

    test('all referenced product files exist', () {
      final file = File('data/sdb/index.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final index = ProductIndex.fromJson(jsonData);

      for (final product in index.products) {
        final productFile = File('data/sdb/${product.file}');
        expect(productFile.existsSync(), true,
            reason: 'Product file ${product.file} must exist');
      }
    });
  });

  group('Data Files - Sample Product (aetzende-reiniger)', () {
    test('aetzende-reiniger.json file exists', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      expect(file.existsSync(), true,
          reason: 'aetzende-reiniger.json must exist');
    });

    test('aetzende-reiniger.json is valid JSON', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      final content = file.readAsStringSync();

      expect(() => json.decode(content), returnsNormally,
          reason: 'aetzende-reiniger.json must be valid JSON');
    });

    test('aetzende-reiniger.json can be parsed as Sicherheitsdatenblatt', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);

      expect(() => Sicherheitsdatenblatt.fromJson(jsonData), returnsNormally,
          reason: 'aetzende-reiniger.json must match Sicherheitsdatenblatt schema');
    });

    test('aetzende-reiniger has all required fields', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final sdb = Sicherheitsdatenblatt.fromJson(jsonData);

      // Required fields
      expect(sdb.id, 'aetzende-reiniger');
      expect(sdb.name, isNotEmpty);
      expect(sdb.documentNumber, isNotEmpty);
      expect(sdb.documentDate, isNotEmpty);
      expect(sdb.companyName, isNotEmpty);
    });

    test('aetzende-reiniger has valid German text content', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final sdb = Sicherheitsdatenblatt.fromJson(jsonData);

      // Check German special characters are preserved
      expect(sdb.name, contains('Ä'));
      expect(sdb.hazardCategory, contains('Ätzend'));

      // Check text content is substantial (not placeholder)
      expect(sdb.hazardsDescription.length, greaterThan(50));
      expect(sdb.protectiveMeasures.length, greaterThan(50));
      expect(sdb.emergencyProcedures.length, greaterThan(50));
      expect(sdb.disposal.length, greaterThan(50));
    });

    test('aetzende-reiniger has all first aid scenarios', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final sdb = Sicherheitsdatenblatt.fromJson(jsonData);

      // All 4 first aid scenarios must be present
      expect(sdb.firstAid.containsKey('hautkontakt'), true);
      expect(sdb.firstAid.containsKey('augenkontakt'), true);
      expect(sdb.firstAid.containsKey('verschlucken'), true);
      expect(sdb.firstAid.containsKey('einatmen'), true);

      // All scenarios must have content
      expect(sdb.firstAid['hautkontakt'], isNotEmpty);
      expect(sdb.firstAid['augenkontakt'], isNotEmpty);
      expect(sdb.firstAid['verschlucken'], isNotEmpty);
      expect(sdb.firstAid['einatmen'], isNotEmpty);
    });

    test('aetzende-reiniger pictograms use valid codes', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final sdb = Sicherheitsdatenblatt.fromJson(jsonData);

      for (final code in sdb.pictograms) {
        final path = PictogramPaths.getGHSPath(code);
        expect(path, isNotEmpty,
            reason: 'Pictogram code "$code" must map to a valid path');
      }
    });

    test('aetzende-reiniger safety equipment uses valid codes', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final sdb = Sicherheitsdatenblatt.fromJson(jsonData);

      for (final code in sdb.safetyEquipment) {
        expect(PictogramPaths.isSafetyEquipmentCode(code), true,
            reason: 'Safety equipment code "$code" must be valid');
      }
    });
  });

  group('Data Files - JSON Round-trip', () {
    test('aetzende-reiniger can be serialized back to JSON', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final sdb = Sicherheitsdatenblatt.fromJson(jsonData);

      // Convert back to JSON
      final outputJson = sdb.toJson();

      // Verify all required fields are present in output
      expect(outputJson['id'], isNotEmpty);
      expect(outputJson['name'], isNotEmpty);
      expect(outputJson['document_number'], isNotEmpty);
      expect(outputJson['first_aid'], isA<Map>());
    });

    test('index can be serialized back to JSON', () {
      final file = File('data/sdb/index.json');
      final content = file.readAsStringSync();
      final jsonData = json.decode(content);
      final index = ProductIndex.fromJson(jsonData);

      // Convert back to JSON
      final outputJson = index.toJson();

      // Verify structure
      expect(outputJson['products'], isA<List>());
      expect(outputJson['products'].length, index.products.length);
    });
  });

  group('Data Files - UTF-8 Encoding', () {
    test('index.json contains valid UTF-8 German characters', () {
      final file = File('data/sdb/index.json');
      final content = file.readAsStringSync();

      // Should contain German special characters
      expect(content.contains('Ä') || content.contains('ä'), true,
          reason: 'German product names should include umlauts');
    });

    test('aetzende-reiniger.json preserves all German special characters', () {
      final file = File('data/sdb/aetzende-reiniger.json');
      final bytes = file.readAsBytesSync();
      final content = utf8.decode(bytes);

      // Verify German characters are present in source
      final germanChars = ['ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü', 'ß'];
      final foundChars = germanChars.where((char) => content.contains(char));

      expect(foundChars.length, greaterThan(0),
          reason: 'File should contain German special characters');
    });
  });
}
