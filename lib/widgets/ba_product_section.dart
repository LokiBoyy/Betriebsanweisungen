import 'package:flutter/material.dart';
import '../theme/ba_colors.dart';
import '../utils/pictogram_paths.dart';

/// Product identification section for Betriebsanweisung.
///
/// Displays:
/// - GHS hazard pictogram (120×120px)
/// - Hazard category label below pictogram
/// - Large product name (36px bold)
///
/// Layout: Two-column (20% pictogram / 80% name) on desktop,
/// stacks vertically on mobile (<600px).
class BAProductSection extends StatelessWidget {
  /// Product name (e.g., "Ätzende Reiniger")
  final String productName;

  /// GHS pictogram code (e.g., "ghs05" for corrosive)
  final String pictogramCode;

  /// Hazard category label (e.g., "Ätzend", "Entzündlich")
  final String hazardCategory;

  const BAProductSection({
    super.key,
    required this.productName,
    required this.pictogramCode,
    required this.hazardCategory,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      decoration: BoxDecoration(
        color: baContentBg,
        border: Border.all(
          color: baBorder,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: isMobile
          ? _buildMobileLayout(textTheme)
          : _buildDesktopLayout(textTheme),
    );
  }

  /// Desktop layout: Row with pictogram on left, name on right
  Widget _buildDesktopLayout(TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Pictogram (flex: 1, ~20%)
        Expanded(
          flex: 1,
          child: _buildPictogramColumn(textTheme),
        ),
        const SizedBox(width: 16),
        // Right: Product name (flex: 4, ~80%)
        Expanded(
          flex: 4,
          child: _buildProductName(textTheme),
        ),
      ],
    );
  }

  /// Mobile layout: Column with pictogram on top, name below
  Widget _buildMobileLayout(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPictogramColumn(textTheme),
        const SizedBox(height: 16),
        _buildProductName(textTheme),
      ],
    );
  }

  /// Builds the pictogram with label below it
  Widget _buildPictogramColumn(TextTheme textTheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // GHS Pictogram
        _buildPictogram(),
        const SizedBox(height: 8),
        // Category label
        Text(
          hazardCategory,
          style: textTheme.labelLarge?.copyWith(
            color: baTextDark,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Builds the GHS pictogram image with error handling
  Widget _buildPictogram() {
    final imagePath = PictogramPaths.getGHSPath(pictogramCode);

    return Image.asset(
      imagePath,
      width: 120,
      height: 120,
      errorBuilder: (context, error, stackTrace) {
        // Fallback: Gray placeholder with warning icon
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.grey[400]!, width: 2),
          ),
          child: const Icon(
            Icons.warning_outlined,
            size: 60,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  /// Builds the product name text
  Widget _buildProductName(TextTheme textTheme) {
    return Center(
      child: Text(
        productName,
        style: textTheme.displaySmall?.copyWith(
          color: baTextDark,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
