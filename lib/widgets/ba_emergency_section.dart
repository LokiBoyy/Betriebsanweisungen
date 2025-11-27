import 'package:flutter/material.dart';
import '../theme/ba_colors.dart';
import '../utils/pictogram_paths.dart';

/// Emergency procedures section for Betriebsanweisung.
///
/// Section: "Verhalten im Gefahrfall"
///
/// Layout:
/// - Orange header with white title and emergency phone reference
/// - Off-white content area
/// - Warning pictogram (80×80px) on left
/// - Emergency procedures text on right
/// - Black borders top and bottom
class BAEmergencySection extends StatelessWidget {
  /// Detailed emergency procedures text
  final String emergencyProcedures;

  /// Emergency phone reference (e.g., "siehe Aushang", or actual number)
  final String emergencyPhoneReference;

  const BAEmergencySection({
    super.key,
    required this.emergencyProcedures,
    required this.emergencyPhoneReference,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

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
          // Orange header with phone reference
          Container(
            color: baOrange,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Verhalten im Gefahrfall (Unfalltelefon: $emergencyPhoneReference)',
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
            child: isMobile
                ? _buildMobileLayout(textTheme)
                : _buildDesktopLayout(textTheme),
          ),
        ],
      ),
    );
  }

  /// Desktop layout: Row with warning icon on left, text on right
  Widget _buildDesktopLayout(TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Warning pictogram
        _buildWarningPictogram(),
        const SizedBox(width: 16),
        // Right: Emergency procedures text
        Expanded(
          child: _buildProceduresText(textTheme),
        ),
      ],
    );
  }

  /// Mobile layout: Column with icon on top, text below
  Widget _buildMobileLayout(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWarningPictogram(),
        const SizedBox(height: 16),
        _buildProceduresText(textTheme),
      ],
    );
  }

  /// Builds the warning pictogram
  Widget _buildWarningPictogram() {
    final imagePath = PictogramPaths.getWarningPath('warning-general');

    return Image.asset(
      imagePath,
      width: 80,
      height: 80,
      errorBuilder: (context, error, stackTrace) {
        // Fallback: Yellow triangle with exclamation mark
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.yellow[700],
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: const Icon(
            Icons.warning,
            color: Colors.black,
            size: 50,
          ),
        );
      },
    );
  }

  /// Builds the emergency procedures text
  Widget _buildProceduresText(TextTheme textTheme) {
    return Text(
      emergencyProcedures,
      style: textTheme.bodyLarge?.copyWith(
        color: baTextDark,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
