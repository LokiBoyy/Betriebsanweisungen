/// Home screen displaying a list of available Betriebsanweisungen
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/product_index.dart';
import '../services/data_service.dart';

/// Home screen that displays a list of all available products
///
/// Features:
/// - Loads product index from DataService
/// - Displays loading indicator while fetching
/// - Shows error message if loading fails
/// - Navigates to detail view when a product is tapped
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataService _dataService = DataService();
  late Future<ProductIndex> _productIndexFuture;

  @override
  void initState() {
    super.initState();
    _productIndexFuture = _dataService.loadProductIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Betriebsanweisungen'),
        centerTitle: true,
      ),
      body: FutureBuilder<ProductIndex>(
        future: _productIndexFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Fehler beim Laden der Produktliste',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _dataService.clearCache();
                          _productIndexFuture = _dataService.loadProductIndex();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Erneut versuchen'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Success state - display product list
          final productIndex = snapshot.data!;

          if (productIndex.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Keine Produkte gefunden',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: productIndex.products.length,
            itemBuilder: (context, index) {
              final product = productIndex.products[index];
              return _ProductListItem(
                product: product,
                onTap: () {
                  context.go('/ba/${product.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}

/// Individual product list item widget
class _ProductListItem extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const _ProductListItem({
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        title: Text(
          product.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          'ID: ${product.id}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
