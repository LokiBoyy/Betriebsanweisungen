import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:betriebsanweisungen/theme/ba_colors.dart';

void main() {
  group('Color Constants', () {
    test('baOrange has correct hex value', () {
      expect(baOrange, const Color(0xFFFF6B00));
    });

    test('baContentBg has correct hex value', () {
      expect(baContentBg, const Color(0xFFFFFBF5));
    });

    test('baTextDark has correct hex value', () {
      expect(baTextDark, const Color(0xFF1C1B1F));
    });

    test('baTextLight has correct hex value', () {
      expect(baTextLight, const Color(0xFFFFFFFF));
    });

    test('baBorder has correct hex value', () {
      expect(baBorder, const Color(0xFF1C1B1F));
    });

    test('all color constants are accessible', () {
      expect(baOrange, isA<Color>());
      expect(baContentBg, isA<Color>());
      expect(baTextDark, isA<Color>());
      expect(baTextLight, isA<Color>());
      expect(baBorder, isA<Color>());
    });
  });

  group('Contrast Ratios (Documentation)', () {
    test('baOrange and baTextLight contrast ratio is documented', () {
      final ratio = _calculateContrastRatio(baOrange, baTextLight);
      // Note: The legal template color (#FF6B00) with white text has a
      // contrast ratio of ~2.85:1, which is below WCAG AA (4.5:1).
      // However, this is the legally required color from the official template.
      // Large text (18px+ bold or 24px+) only requires 3:1 ratio.
      expect(ratio, greaterThan(2.5),
          reason: 'Orange/white contrast should be measured and documented');
    });

    test('baContentBg and baTextDark have sufficient contrast (≥4.5:1)', () {
      final ratio = _calculateContrastRatio(baContentBg, baTextDark);
      expect(ratio, greaterThanOrEqualTo(4.5),
          reason: 'Off-white background with dark text must meet WCAG AA (4.5:1)');
    });

  });

  group('ColorScheme Configuration', () {
    test('getBAColorScheme returns valid ColorScheme', () {
      final scheme = getBAColorScheme();
      expect(scheme, isA<ColorScheme>());
      expect(scheme.brightness, Brightness.light);
    });

    test('getBAColorScheme has correct primary color', () {
      final scheme = getBAColorScheme();
      expect(scheme.primary, baOrange);
      expect(scheme.primary, const Color(0xFFFF6B00));
    });

    test('getBAColorScheme has correct onPrimary color', () {
      final scheme = getBAColorScheme();
      expect(scheme.onPrimary, baTextLight);
    });

    test('getBAColorScheme has correct surface color', () {
      final scheme = getBAColorScheme();
      expect(scheme.surface, baContentBg);
    });

    test('getBAColorScheme has correct onSurface color', () {
      final scheme = getBAColorScheme();
      expect(scheme.onSurface, baTextDark);
    });
  });

  group('ThemeData Configuration', () {
    test('getBAThemeData returns valid ThemeData', () {
      final theme = getBAThemeData();
      expect(theme, isA<ThemeData>());
      expect(theme.useMaterial3, true);
    });

    test('getBAThemeData has correct color scheme', () {
      final theme = getBAThemeData();
      expect(theme.colorScheme.primary, baOrange);
      expect(theme.colorScheme.onPrimary, baTextLight);
      expect(theme.colorScheme.surface, baContentBg);
      expect(theme.colorScheme.onSurface, baTextDark);
    });

    test('getBAThemeData has correct typography sizes', () {
      final theme = getBAThemeData();
      final textTheme = theme.textTheme;

      // Product name: 36px, bold
      expect(textTheme.displaySmall?.fontSize, 36);
      expect(textTheme.displaySmall?.fontWeight, FontWeight.bold);

      // Section headers: 22px, bold
      expect(textTheme.titleLarge?.fontSize, 22);
      expect(textTheme.titleLarge?.fontWeight, FontWeight.bold);

      // Orange header titles: 16px, medium weight
      expect(textTheme.titleMedium?.fontSize, 16);
      expect(textTheme.titleMedium?.fontWeight, FontWeight.w500);

      // Body text: 16px, regular
      expect(textTheme.bodyLarge?.fontSize, 16);
      expect(textTheme.bodyLarge?.fontWeight, FontWeight.normal);

      // Header fields: 14px, regular
      expect(textTheme.bodyMedium?.fontSize, 14);
      expect(textTheme.bodyMedium?.fontWeight, FontWeight.normal);

      // Pictogram labels: 14px, medium
      expect(textTheme.labelLarge?.fontSize, 14);
      expect(textTheme.labelLarge?.fontWeight, FontWeight.w500);
    });

    test('getBAThemeData has AppBar theme configured', () {
      final theme = getBAThemeData();
      expect(theme.appBarTheme.backgroundColor, baOrange);
      expect(theme.appBarTheme.foregroundColor, baTextLight);
      expect(theme.appBarTheme.elevation, 0);
      expect(theme.appBarTheme.centerTitle, true);
    });

    test('getBAThemeData has white scaffold background', () {
      final theme = getBAThemeData();
      expect(theme.scaffoldBackgroundColor, Colors.white);
    });

    test('getBAThemeData has card theme configured', () {
      final theme = getBAThemeData();
      expect(theme.cardTheme.elevation, 2);
      expect(theme.cardTheme.shape, isA<RoundedRectangleBorder>());
    });
  });

  group('Widget Tests', () {
    testWidgets('Container with baOrange background renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              color: baOrange,
              child: const Text(
                'Test',
                style: TextStyle(color: baTextLight),
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.color, baOrange);

      final text = tester.widget<Text>(find.text('Test'));
      expect(text.style?.color, baTextLight);
    });

    testWidgets('Container with baContentBg background renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              color: baContentBg,
              child: const Text(
                'Test',
                style: TextStyle(color: baTextDark),
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.color, baContentBg);

      final text = tester.widget<Text>(find.text('Test'));
      expect(text.style?.color, baTextDark);
    });

    testWidgets('MaterialApp with getBAThemeData applies theme correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getBAThemeData(),
          home: Scaffold(
            appBar: AppBar(title: const Text('Test')),
            body: const Text('Content'),
          ),
        ),
      );

      // Verify theme is applied
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, true);
      expect(materialApp.theme?.colorScheme.primary, baOrange);
    });
  });
}

/// Calculates the contrast ratio between two colors
/// Formula: (L1 + 0.05) / (L2 + 0.05)
/// where L1 is the lighter color's relative luminance
/// and L2 is the darker color's relative luminance
///
/// WCAG AA requires a minimum ratio of 4.5:1 for normal text
/// WCAG AAA requires a minimum ratio of 7:1 for normal text
double _calculateContrastRatio(Color color1, Color color2) {
  final lum1 = color1.computeLuminance();
  final lum2 = color2.computeLuminance();

  final lighter = lum1 > lum2 ? lum1 : lum2;
  final darker = lum1 > lum2 ? lum2 : lum1;

  return (lighter + 0.05) / (darker + 0.05);
}
