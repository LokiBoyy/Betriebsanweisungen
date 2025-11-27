import 'package:flutter/material.dart';
import '../theme/ba_colors.dart';
import '../utils/pictogram_paths.dart';

/// Protective measures section for Betriebsanweisung.
///
/// Section: "Schutzmaßnahmen und Verhaltensregeln"
///
/// Layout:
/// - Off-white background (NO orange header)
/// - Section title in black, bold, 22px
/// - Two-column layout (25% pictograms / 75% text) on desktop
/// - Safety equipment pictograms (64×64px) on left
/// - Protective measures text on right
/// - Stacks vertically on mobile
class BAProtectiveMeasuresSection extends StatelessWidget {
  /// Detailed protective measures text
  final String protectiveMeasures;

  /// List of safety equipment pictogram codes
  ///
  /// Examples: ["goggles", "gloves", "protective-clothing", "respiratory"]
  final List<String> safetyEquipment;

  const BAProtectiveMeasuresSection({
    super.key,
    required this.protectiveMeasures,
    required this.safetyEquipment,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      decoration: const BoxDecoration(
        color: baContentBg,
        border: Border(
          top: BorderSide(color: baBorder, width: 2),
          bottom: BorderSide(color: baBorder, width: 2),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section title (NO orange header for this section)
          Text(
            'Schutzmaßnahmen und Verhaltensregeln',
            style: textTheme.titleLarge?.copyWith(
              color: baTextDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // Content layout
          isMobile
              ? _buildMobileLayout(textTheme)
              : _buildDesktopLayout(textTheme),
        ],
      ),
    );
  }

  /// Desktop layout: Row with pictograms on left, text on right
  Widget _buildDesktopLayout(TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Safety pictograms (flex: 1, ~25%)
        Expanded(
          flex: 1,
          child: _buildSafetyPictograms(),
        ),
        const SizedBox(width: 16),
        // Right: Measures text (flex: 3, ~75%)
        Expanded(
          flex: 3,
          child: _buildMeasuresText(textTheme),
        ),
      ],
    );
  }

  /// Mobile layout: Column with pictograms on top, text below
  Widget _buildMobileLayout(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSafetyPictograms(),
        const SizedBox(height: 16),
        _buildMeasuresText(textTheme),
      ],
    );
  }

  /// Builds the safety equipment pictograms
  Widget _buildSafetyPictograms() {
    if (safetyEquipment.isEmpty) {
      // Show generic safety icon if no equipment specified
      return const Icon(
        Icons.health_and_safety,
        size: 64,
        color: Colors.blue,
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: safetyEquipment.map((code) {
        final imagePath = PictogramPaths.getSafetyEquipmentPath(code);

        if (imagePath.isEmpty) {
          // Invalid code, skip
          return const SizedBox.shrink();
        }

        return Image.asset(
          imagePath,
          width: 64,
          height: 64,
          errorBuilder: (context, error, stackTrace) {
            // Fallback: Blue circle with safety icon
            return Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.blue[700],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.security,
                color: Colors.white,
                size: 32,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  /// Builds the protective measures text
  Widget _buildMeasuresText(TextTheme textTheme) {
    return Text(
      protectiveMeasures,
      style: textTheme.bodyLarge?.copyWith(
        color: baTextDark,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
