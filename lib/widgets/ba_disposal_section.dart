import 'package:flutter/material.dart';
import '../theme/ba_colors.dart';

/// Disposal section for Betriebsanweisung.
///
/// Section: "Sachgerechte Entsorgung"
///
/// Layout:
/// - Orange header with white title
/// - Off-white content area
/// - Disposal instructions (paragraph)
/// - Date and signature line at bottom (integrated footer)
/// - Black borders top and bottom
///
/// Note: The footer (date/signature) is integrated into this section
/// per the legal template. No separate footer widget is needed.
class BADisposalSection extends StatelessWidget {
  /// Detailed disposal instructions
  final String disposal;

  /// Responsible person name for signature line (optional)
  final String responsiblePerson;

  const BADisposalSection({
    super.key,
    required this.disposal,
    this.responsiblePerson = '',
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
              'Sachgerechte Entsorgung',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Disposal instructions
                Text(
                  disposal,
                  style: textTheme.bodyLarge?.copyWith(
                    color: baTextDark,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),
                // Integrated footer: Date and signature line
                _buildFooter(textTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the integrated footer with date and signature line
  Widget _buildFooter(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date line
        Row(
          children: [
            Text(
              'Datum: ',
              style: textTheme.bodyMedium?.copyWith(
                color: baTextDark,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: baTextDark, width: 1),
                  ),
                ),
                child: const SizedBox(height: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Signature line
        Row(
          children: [
            Text(
              'Unterschrift: ',
              style: textTheme.bodyMedium?.copyWith(
                color: baTextDark,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: baTextDark, width: 1),
                  ),
                ),
                child: responsiblePerson.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          responsiblePerson,
                          style: textTheme.bodyMedium?.copyWith(
                            color: baTextDark,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    : const SizedBox(height: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
