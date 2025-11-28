import 'package:flutter/material.dart';
import '../theme/ba_colors.dart';
import '../utils/pictogram_paths.dart';

/// Product identification section for Betriebsanweisung.
///
/// Displays:
/// - GHS hazard pictograms (120×120px each)
/// - Hazard category label below pictograms
/// - Large product name (36px bold)
///
/// Layout: Two-column (30% pictograms / 70% name) on desktop,
/// stacks vertically on mobile (<600px).
class BAProductSection extends StatelessWidget {
  /// Product name (e.g., "Ätzende Reiniger")
  final String productName;

  /// GHS pictogram codes (e.g., ["ghs05", "ghs07", "ghs09"])
  final List<String> pictogramCodes;

  /// Hazard category label (e.g., "Ätzend", "Entzündlich")
  final String hazardCategory;

  const BAProductSection({
    super.key,
    required this.productName,
    required this.pictogramCodes,
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

  /// Desktop layout: Row with pictograms on left, name on right
  Widget _buildDesktopLayout(TextTheme textTheme) {
    // Adjust flex based on number of pictograms
    final pictogramFlex = pictogramCodes.length > 1 ? 2 : 1;
    final nameFlex = pictogramCodes.length > 1 ? 3 : 4;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Pictograms (flex: 1-2, ~20-40%)
        Expanded(
          flex: pictogramFlex,
          child: _buildPictogramColumn(textTheme),
        ),
        const SizedBox(width: 16),
        // Right: Product name (flex: 3-4, ~60-80%)
        Expanded(
          flex: nameFlex,
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

  /// Builds the pictograms with label below them
  Widget _buildPictogramColumn(TextTheme textTheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // GHS Pictograms in a row
        _buildPictograms(),
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

  /// Builds all GHS pictogram images with error handling
  Widget _buildPictograms() {
    if (pictogramCodes.isEmpty) {
      return const SizedBox.shrink();
    }

    // If only one pictogram, display it at full size
    if (pictogramCodes.length == 1) {
      return _buildSinglePictogram(pictogramCodes.first, 120);
    }

    // For multiple pictograms, display them in a horizontal wrap
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: pictogramCodes.map((code) {
        return _buildSinglePictogram(code, 90);
      }).toList(),
    );
  }

  /// Builds a single pictogram with consistent styling
  Widget _buildSinglePictogram(String code, double size) {
    final imagePath = PictogramPaths.getGHSPath(code);

    return Image.asset(
      imagePath,
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        // Fallback: Gray placeholder with warning icon
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.grey[400]!, width: 2),
          ),
          child: Icon(
            Icons.warning_outlined,
            size: size * 0.5,
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
