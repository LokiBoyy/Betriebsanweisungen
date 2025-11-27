import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const BetriebsanweisungenApp());
}

class BetriebsanweisungenApp extends StatelessWidget {
  const BetriebsanweisungenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Betriebsanweisungen',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B00),
          primary: const Color(0xFFFF6B00), // Explicitly set primary to exact orange
        ),
      ),
      routerConfig: _router,
    );
  }
}

// Configure GoRouter with hash-based routing for GitHub Pages
// Hash routing is the default for Flutter web
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Fade transition - standard for web, works smoothly in both directions
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/ba/:productId',
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId'] ?? '';
        return CustomTransitionPage(
          key: state.pageKey,
          child: ProductDetailPage(productId: productId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade transition - standard for web, works smoothly in both directions
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
  ],
);

// Placeholder home page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Betriebsanweisungen'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Betriebsanweisungen Generator',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/ba/test');
              },
              child: const Text('Test Navigation'),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder product detail page
class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product: $productId'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Product ID: $productId',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
