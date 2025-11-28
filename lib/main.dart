import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/betriebsanweisung_screen.dart';
import 'theme/ba_colors.dart';

void main() {
  runApp(const BetriebsanweisungenApp());
}

class BetriebsanweisungenApp extends StatelessWidget {
  const BetriebsanweisungenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Betriebsanweisungen',
      theme: getBAThemeData(), // Use the legal template theme
      debugShowCheckedModeBanner: false,
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
        child: const HomeScreen(), // Use actual HomeScreen from screens/
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Fade transition - standard for web, works smoothly in both directions
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/ba/:productId',
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId'] ?? '';
        return CustomTransitionPage(
          key: state.pageKey,
          child: BetriebsanweisungScreen(productId: productId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade transition - standard for web, works smoothly in both directions
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
  ],
);
