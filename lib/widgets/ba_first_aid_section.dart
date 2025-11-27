import 'package:flutter/material.dart';
import '../theme/ba_colors.dart';
import '../utils/pictogram_paths.dart';

/// First aid section for Betriebsanweisung.
///
/// Section: "Erste Hilfe"
///
/// Layout:
/// - Orange header with white title and first aider reference
/// - Off-white content area
/// - First aid pictogram (green cross, 80×80px) on left
/// - Four subsections with labels on right:
///   - "Nach Hautkontakt:" - Skin contact
///   - "Nach Augenkontakt:" - Eye contact (bold/prominent)
///   - "Nach Verschlucken:" - Ingestion
///   - "Nach Einatmen:" - Inhalation
/// - Black borders top and bottom
class BAFirstAidSection extends StatelessWidget {
  /// First aid instructions organized by exposure type
  ///
  /// Keys: hautkontakt, augenkontakt, verschlucken, einatmen
  final Map<String, String> firstAid;

  /// First aider reference (e.g., "siehe Aushang")
  final String firstAiderReference;

  const BAFirstAidSection({
    super.key,
    required this.firstAid,
    required this.firstAiderReference,
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
          // Orange header with first aider reference
          Container(
            color: baOrange,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Erste Hilfe (Ersthelfer: $firstAiderReference)',
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

  /// Desktop layout: Row with pictogram on left, instructions on right
  Widget _buildDesktopLayout(TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: First aid pictogram
        _buildFirstAidPictogram(),
        const SizedBox(width: 16),
        // Right: First aid instructions
        Expanded(
          child: _buildFirstAidInstructions(textTheme),
        ),
      ],
    );
  }

  /// Mobile layout: Column with pictogram on top, instructions below
  Widget _buildMobileLayout(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFirstAidPictogram(),
        const SizedBox(height: 16),
        _buildFirstAidInstructions(textTheme),
      ],
    );
  }

  /// Builds the first aid pictogram (green cross)
  Widget _buildFirstAidPictogram() {
    final imagePath = PictogramPaths.getEmergencyPath('first-aid');

    return Image.asset(
      imagePath,
      width: 80,
      height: 80,
      errorBuilder: (context, error, stackTrace) {
        // Fallback: Green square with white cross
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green[700],
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          ),
        );
      },
    );
  }

  /// Builds the four first aid instruction subsections
  Widget _buildFirstAidInstructions(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Skin contact
        _buildInstruction(
          'Nach Hautkontakt:',
          firstAid['hautkontakt'] ?? '',
          textTheme,
        ),
        const SizedBox(height: 12),
        // Eye contact (bold/prominent - most critical)
        _buildInstruction(
          'Nach Augenkontakt:',
          firstAid['augenkontakt'] ?? '',
          textTheme,
          isImportant: true,
        ),
        const SizedBox(height: 12),
        // Ingestion
        _buildInstruction(
          'Nach Verschlucken:',
          firstAid['verschlucken'] ?? '',
          textTheme,
        ),
        const SizedBox(height: 12),
        // Inhalation
        _buildInstruction(
          'Nach Einatmen:',
          firstAid['einatmen'] ?? '',
          textTheme,
        ),
      ],
    );
  }

  /// Builds a single instruction subsection
  Widget _buildInstruction(
    String label,
    String instruction,
    TextTheme textTheme, {
    bool isImportant = false,
  }) {
    return RichText(
      text: TextSpan(
        style: textTheme.bodyLarge?.copyWith(color: baTextDark),
        children: [
          TextSpan(
            text: '$label ',
            style: TextStyle(
              fontWeight: isImportant ? FontWeight.bold : FontWeight.w600,
              fontSize: isImportant ? 17 : null,
            ),
          ),
          TextSpan(
            text: instruction,
          ),
        ],
      ),
    );
  }
}
