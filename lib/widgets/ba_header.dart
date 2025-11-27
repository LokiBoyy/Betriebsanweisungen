import 'package:flutter/material.dart';
import '../theme/ba_colors.dart';

/// Header widget for Betriebsanweisung documents.
///
/// Displays document metadata in a legally compliant orange header bar:
/// - Document number (left)
/// - Title "Betriebsanweisung gem. §14 GefStoffV" (center)
/// - Document date (right)
/// - Company name (bottom row)
///
/// Matches the legal template requirements with exact colors and layout.
class BAHeader extends StatelessWidget {
  /// Document number (e.g., "000 Muster")
  final String documentNumber;

  /// Document date in DD.MM.YYYY format (e.g., "01.01.2015")
  final String documentDate;

  /// Company/facility name (e.g., "Werkstatt, Produktion")
  final String companyName;

  const BAHeader({
    super.key,
    required this.documentNumber,
    required this.documentDate,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: const BoxDecoration(
        color: baOrange,
        border: Border(
          bottom: BorderSide(
            color: baBorder,
            width: 2,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Number | Title | Date
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Document number (flex: 1)
              Expanded(
                flex: 1,
                child: Text(
                  'Nr.: $documentNumber',
                  style: textTheme.bodyMedium?.copyWith(
                    color: baTextLight,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              // Center: Title (flex: 2)
              Expanded(
                flex: 2,
                child: Text(
                  'Betriebsanweisung gem. §14 GefStoffV',
                  style: textTheme.titleMedium?.copyWith(
                    color: baTextLight,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Right: Date (flex: 1)
              Expanded(
                flex: 1,
                child: Text(
                  'Stand: $documentDate',
                  style: textTheme.bodyMedium?.copyWith(
                    color: baTextLight,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Bottom row: Company name
          Text(
            'Betrieb: $companyName',
            style: textTheme.bodyMedium?.copyWith(
              color: baTextLight,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
