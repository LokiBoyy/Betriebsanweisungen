import 'package:flutter_test/flutter_test.dart';
import 'package:betriebsanweisungen/models/product_index.dart';

void main() {
  group('ProductIndex Model Tests - Step 2.2', () {
    test('fromJson: Parse index with 2 products', () {
      // Sample index JSON with 2 products
      final json = {
        'products': [
          {
            'id': 'aceton',
            'name': 'Aceton',
            'file': 'aceton.json',
          },
          {
            'id': 'aetzende-reiniger',
            'name': 'Ätzende Reiniger',
            'file': 'aetzende-reiniger.json',
          },
        ],
      };

      final index = ProductIndex.fromJson(json);

      // Verify the products list contains 2 items
      expect(index.products.length, 2);

      // Verify first product has correct fields
      expect(index.products[0].id, 'aceton');
      expect(index.products[0].name, 'Aceton');
      expect(index.products[0].file, 'aceton.json');

      // Verify second product has correct fields
      expect(index.products[1].id, 'aetzende-reiniger');
      expect(index.products[1].name, 'Ätzende Reiniger');
      expect(index.products[1].file, 'aetzende-reiniger.json');
    });

    test('fromJson: Parse empty index', () {
      final json = {
        'products': [],
      };

      final index = ProductIndex.fromJson(json);

      expect(index.products.length, 0);
      expect(index.products, isEmpty);
    });

    test('toJson: Convert back to JSON and verify output', () {
      final originalJson = {
        'products': [
          {
            'id': 'test1',
            'name': 'Test Product 1',
            'file': 'test1.json',
          },
          {
            'id': 'test2',
            'name': 'Test Product 2',
            'file': 'test2.json',
          },
        ],
      };

      // Parse from JSON
      final index = ProductIndex.fromJson(originalJson);

      // Convert back to JSON
      final outputJson = index.toJson();

      // Verify structure
      expect(outputJson['products'], isList);
      expect((outputJson['products'] as List).length, 2);

      // Verify first product
      final product1 = (outputJson['products'] as List)[0] as Map<String, dynamic>;
      expect(product1['id'], 'test1');
      expect(product1['name'], 'Test Product 1');
      expect(product1['file'], 'test1.json');

      // Verify second product
      final product2 = (outputJson['products'] as List)[1] as Map<String, dynamic>;
      expect(product2['id'], 'test2');
      expect(product2['name'], 'Test Product 2');
      expect(product2['file'], 'test2.json');
    });

    test('Validation: Throw error when "products" field is missing', () {
      final Map<String, dynamic> json = {
        // 'products' is missing
      };

      expect(
        () => ProductIndex.fromJson(json),
        throwsA(isA<FormatException>()),
      );
    });

    test('findById: Find existing product', () {
      final json = {
        'products': [
          {'id': 'aceton', 'name': 'Aceton', 'file': 'aceton.json'},
          {
            'id': 'ethanol',
            'name': 'Ethanol',
            'file': 'ethanol.json',
          },
        ],
      };

      final index = ProductIndex.fromJson(json);
      final found = index.findById('ethanol');

      expect(found, isNotNull);
      expect(found?.id, 'ethanol');
      expect(found?.name, 'Ethanol');
      expect(found?.file, 'ethanol.json');
    });

    test('findById: Return null when product not found', () {
      final json = {
        'products': [
          {'id': 'aceton', 'name': 'Aceton', 'file': 'aceton.json'},
        ],
      };

      final index = ProductIndex.fromJson(json);
      final found = index.findById('nonexistent');

      expect(found, isNull);
    });

    test('toString: Verify string representation', () {
      final json = {
        'products': [
          {'id': 'test1', 'name': 'Test 1', 'file': 'test1.json'},
          {'id': 'test2', 'name': 'Test 2', 'file': 'test2.json'},
        ],
      };

      final index = ProductIndex.fromJson(json);
      final str = index.toString();

      expect(str, contains('ProductIndex'));
      expect(str, contains('2 items'));
    });
  });

  group('ProductEntry Model Tests - Step 2.2', () {
    test('fromJson: Parse product entry', () {
      final json = {
        'id': 'aceton',
        'name': 'Aceton',
        'file': 'aceton.json',
      };

      final entry = ProductEntry.fromJson(json);

      expect(entry.id, 'aceton');
      expect(entry.name, 'Aceton');
      expect(entry.file, 'aceton.json');
    });

    test('toJson: Convert product entry to JSON', () {
      final entry = ProductEntry(
        id: 'test',
        name: 'Test Product',
        file: 'test.json',
      );

      final json = entry.toJson();

      expect(json['id'], 'test');
      expect(json['name'], 'Test Product');
      expect(json['file'], 'test.json');
    });

    test('Validation: Throw error when "id" is missing', () {
      final json = {
        'name': 'Test',
        'file': 'test.json',
        // 'id' is missing
      };

      expect(
        () => ProductEntry.fromJson(json),
        throwsA(isA<FormatException>()),
      );
    });

    test('Validation: Throw error when "name" is missing', () {
      final json = {
        'id': 'test',
        'file': 'test.json',
        // 'name' is missing
      };

      expect(
        () => ProductEntry.fromJson(json),
        throwsA(isA<FormatException>()),
      );
    });

    test('Validation: Throw error when "file" is missing', () {
      final json = {
        'id': 'test',
        'name': 'Test',
        // 'file' is missing
      };

      expect(
        () => ProductEntry.fromJson(json),
        throwsA(isA<FormatException>()),
      );
    });

    test('German special characters: Verify UTF-8 encoding support', () {
      final json = {
        'id': 'aetzende-reiniger',
        'name': 'Ätzende Reiniger',
        'file': 'aetzende-reiniger.json',
      };

      final entry = ProductEntry.fromJson(json);

      expect(entry.name, 'Ätzende Reiniger');
    });

    test('Equality: Two entries with same ID are equal', () {
      final entry1 = ProductEntry(
        id: 'test',
        name: 'Test 1',
        file: 'test1.json',
      );
      final entry2 = ProductEntry(
        id: 'test',
        name: 'Test 2',
        file: 'test2.json',
      );

      expect(entry1, equals(entry2));
      expect(entry1.hashCode, equals(entry2.hashCode));
    });

    test('Equality: Two entries with different IDs are not equal', () {
      final entry1 = ProductEntry(
        id: 'test1',
        name: 'Test',
        file: 'test.json',
      );
      final entry2 = ProductEntry(
        id: 'test2',
        name: 'Test',
        file: 'test.json',
      );

      expect(entry1, isNot(equals(entry2)));
    });

    test('toString: Verify string representation', () {
      final entry = ProductEntry(
        id: 'aceton',
        name: 'Aceton',
        file: 'aceton.json',
      );

      final str = entry.toString();

      expect(str, contains('ProductEntry'));
      expect(str, contains('aceton'));
      expect(str, contains('Aceton'));
      expect(str, contains('aceton.json'));
    });
  });
}
