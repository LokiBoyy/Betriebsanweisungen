import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_index.dart';
import '../models/sicherheitsdatenblatt.dart';

/// Singleton service for loading JSON data via HTTP
///
/// This service handles loading product index and individual safety data sheets
/// from the `/data/sdb/` directory. It includes simple Map-based caching to
/// avoid redundant network requests.
class DataService {
  // Singleton instance
  static final DataService _instance = DataService._internal();

  /// Factory constructor returns the singleton instance
  factory DataService() {
    return _instance;
  }

  /// Private constructor for singleton pattern
  DataService._internal();

  // Simple Map-based cache
  final Map<String, dynamic> _cache = {};

  /// Base path for data files (relative URL)
  static const String _basePath = 'assets/data/sdb';

  /// Load the product index from `/data/sdb/index.json`
  ///
  /// Returns a [ProductIndex] containing the list of all available products.
  /// Results are cached to avoid redundant requests.
  ///
  /// Throws descriptive exceptions on failure:
  /// - Network errors: "Daten konnten nicht geladen werden. Bitte Internetverbindung prüfen."
  /// - JSON parsing errors: "Datenformat ungültig. Bitte Administrator kontaktieren."
  Future<ProductIndex> loadProductIndex() async {
    const cacheKey = 'product_index';

    // Check cache first
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey] as ProductIndex;
    }

    try {
      // Load JSON via HTTP GET (relative URL)
      final url = '$_basePath/index.json';
      final response = await http.get(Uri.parse(url));

      // Check HTTP status
      if (response.statusCode == 404) {
        throw Exception('Produktindex nicht gefunden.');
      }

      if (response.statusCode != 200) {
        throw Exception(
            'Daten konnten nicht geladen werden. Bitte Internetverbindung prüfen.');
      }

      // Parse JSON
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final productIndex = ProductIndex.fromJson(jsonData);

      // Cache the result
      _cache[cacheKey] = productIndex;

      return productIndex;
    } on FormatException catch (e) {
      throw Exception(
          'Datenformat ungültig. Bitte Administrator kontaktieren. Details: ${e.message}');
    } catch (e) {
      // Network or other errors
      if (e.toString().contains('Daten konnten nicht geladen werden') ||
          e.toString().contains('Produktindex nicht gefunden') ||
          e.toString().contains('Datenformat ungültig')) {
        rethrow;
      }
      throw Exception(
          'Daten konnten nicht geladen werden. Bitte Internetverbindung prüfen.');
    }
  }

  /// Load a specific Sicherheitsdatenblatt from `/data/sdb/{filename}`
  ///
  /// Returns a [Sicherheitsdatenblatt] with the product's safety data.
  /// Results are cached to avoid redundant requests.
  ///
  /// Parameters:
  /// - [filename]: The JSON filename (e.g., "aceton.json")
  ///
  /// Throws descriptive exceptions on failure:
  /// - File not found: "Produkt nicht gefunden."
  /// - Network errors: "Daten konnten nicht geladen werden. Bitte Internetverbindung prüfen."
  /// - JSON parsing errors: "Datenformat ungültig. Bitte Administrator kontaktieren."
  Future<Sicherheitsdatenblatt> loadSicherheitsdatenblatt(
      String filename) async {
    final cacheKey = 'sdb_$filename';

    // Check cache first
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey] as Sicherheitsdatenblatt;
    }

    try {
      // Load JSON via HTTP GET (relative URL)
      final url = '$_basePath/$filename';
      final response = await http.get(Uri.parse(url));

      // Check HTTP status
      if (response.statusCode == 404) {
        throw Exception('Produkt nicht gefunden.');
      }

      if (response.statusCode != 200) {
        throw Exception(
            'Daten konnten nicht geladen werden. Bitte Internetverbindung prüfen.');
      }

      // Parse JSON with UTF-8 decoding for German characters
      final jsonData = json.decode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
      final sdb = Sicherheitsdatenblatt.fromJson(jsonData);

      // Cache the result
      _cache[cacheKey] = sdb;

      return sdb;
    } on FormatException catch (e) {
      throw Exception(
          'Datenformat ungültig. Bitte Administrator kontaktieren. Details: ${e.message}');
    } catch (e) {
      // Network or other errors
      if (e.toString().contains('Produkt nicht gefunden') ||
          e.toString().contains('Daten konnten nicht geladen werden') ||
          e.toString().contains('Datenformat ungültig')) {
        rethrow;
      }
      throw Exception(
          'Daten konnten nicht geladen werden. Bitte Internetverbindung prüfen.');
    }
  }

  /// Clear all cached data
  ///
  /// Useful for testing or forcing data refresh
  void clearCache() {
    _cache.clear();
  }

  /// Check if data is cached
  bool isCached(String key) {
    return _cache.containsKey(key);
  }
}
