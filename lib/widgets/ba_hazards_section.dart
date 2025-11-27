import 'package:flutter/material.dart';
import '../theme/ba_colors.dart';

/// Hazards section for Betriebsanweisung.
///
/// Section: "Gefahren für Mensch und Umwelt"
///
/// Layout:
/// - Orange header with white title text
/// - Off-white content area with black text
/// - Detailed hazard description (paragraph format)
/// - Black borders top and bottom
class BAHazardsSection extends StatelessWidget {
  /// Detailed hazard description text.
  ///
  /// Should include specific hazards like:
  /// - Chemical reactions
  /// - Concentration warnings
  /// - Spray/aerosol warnings
  /// - Health effects
  final String hazardsDescription;

  const BAHazardsSection({
    super.key,
    required this.hazardsDescription,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: baBorder, width: 2),
          bottom: BorderSide(color: baBorder, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Orange header
          Container(
            color: baOrange,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Gefahren für Mensch und Umwelt',
              style: textTheme.titleMedium?.copyWith(
                color: baTextLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Off-white content area
          Container(
            color: baContentBg,
            padding: const EdgeInsets.all(16),
            child: Text(
              hazardsDescription,
              style: textTheme.bodyLarge?.copyWith(
                color: baTextDark,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
