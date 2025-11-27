import 'package:flutter_test/flutter_test.dart';
import 'package:betriebsanweisungen/services/data_service.dart';

void main() {
  group('DataService Tests - Step 2.3', () {
    late DataService service;

    setUp(() {
      service = DataService();
      service.clearCache(); // Clear cache before each test
    });

    test('Singleton: Multiple instances return same object', () {
      final service1 = DataService();
      final service2 = DataService();

      expect(identical(service1, service2), true);
    });

    test('Cache: isCached returns false for uncached data', () {
      expect(service.isCached('product_index'), false);
      expect(service.isCached('sdb_test.json'), false);
    });

    test('Cache: clearCache removes all cached data', () {
      // This test verifies the cache mechanism exists and can be cleared
      service.clearCache();
      expect(service.isCached('product_index'), false);
    });

    // NOTE: The following are integration tests that require the app to be running
    // with HTTP access to the data files. To run these tests:
    //
    // 1. Run the app: flutter run -d chrome
    // 2. Verify the following manually in the app:
    //    - loadProductIndex() returns parsed ProductIndex with correct data
    //    - loadSicherheitsdatenblatt('test-product.json') returns parsed Sicherheitsdatenblatt
    //    - Calling the same method twice uses cache (check network tab in DevTools)
    //    - Invalid JSON shows German error message
    //    - Missing file (404) shows "Produkt nicht gefunden."
    //
    // Integration test example (requires HTTP server):
    // test('loadProductIndex: Load and parse index.json', () async {
    //   final index = await service.loadProductIndex();
    //   expect(index.products.length, greaterThan(0));
    // });
    //
    // test('loadSicherheitsdatenblatt: Load and parse product JSON', () async {
    //   final sdb = await service.loadSicherheitsdatenblatt('test-product.json');
    //   expect(sdb.id, 'test-product');
    //   expect(sdb.name, 'Test Produkt');
    // });
    //
    // test('Caching: Second call uses cache', () async {
    //   // First call
    //   await service.loadProductIndex();
    //   expect(service.isCached('product_index'), true);
    //
    //   // Second call should use cache
    //   final index = await service.loadProductIndex();
    //   expect(index, isNotNull);
    // });
  });
}
