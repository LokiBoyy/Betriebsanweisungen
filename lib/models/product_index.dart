/// Model for the product registry/index
///
/// The ProductIndex represents the `/data/sdb/index.json` file which lists
/// all available products and their corresponding JSON data files.
class ProductIndex {
  /// List of all available products
  final List<ProductEntry> products;

  /// Constructor
  ProductIndex({required this.products});

  /// Create instance from JSON
  factory ProductIndex.fromJson(Map<String, dynamic> json) {
    final productsList = json['products'] as List<dynamic>?;

    if (productsList == null) {
      throw FormatException('Field "products" is required in index.json');
    }

    final products = productsList
        .map((item) => ProductEntry.fromJson(item as Map<String, dynamic>))
        .toList();

    return ProductIndex(products: products);
  }

  /// Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'products': products.map((p) => p.toJson()).toList(),
    };
  }

  /// Find a product by ID
  ProductEntry? findById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    return 'ProductIndex{products: ${products.length} items}';
  }
}

/// Individual product entry in the index
///
/// Each entry contains the product identifier, display name,
/// and the filename of the corresponding JSON data file.
class ProductEntry {
  /// URL-safe product identifier (used in routing)
  final String id;

  /// Display name for the product
  final String name;

  /// JSON filename (relative to /data/sdb/ directory)
  final String file;

  /// Constructor
  ProductEntry({
    required this.id,
    required this.name,
    required this.file,
  });

  /// Create instance from JSON
  factory ProductEntry.fromJson(Map<String, dynamic> json) {
    // Validate required fields
    if (json['id'] == null || json['id'].toString().isEmpty) {
      throw FormatException('Field "id" is required in product entry');
    }
    if (json['name'] == null || json['name'].toString().isEmpty) {
      throw FormatException('Field "name" is required in product entry');
    }
    if (json['file'] == null || json['file'].toString().isEmpty) {
      throw FormatException('Field "file" is required in product entry');
    }

    return ProductEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      file: json['file'] as String,
    );
  }

  /// Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'file': file,
    };
  }

  @override
  String toString() {
    return 'ProductEntry{id: $id, name: $name, file: $file}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductEntry && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
