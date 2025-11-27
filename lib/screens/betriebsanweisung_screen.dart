/// Betriebsanweisung detail screen displaying the complete legal template
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/sicherheitsdatenblatt.dart';
import '../services/data_service.dart';
import '../theme/ba_colors.dart';

/// Screen that displays a complete Betriebsanweisung for a specific product
///
/// Features:
/// - Loads product data based on productId route parameter
/// - Displays 7 sections in legal template order
/// - Scrollable layout for full document viewing
/// - Print-friendly design
class BetriebsanweisungScreen extends StatefulWidget {
  final String productId;

  const BetriebsanweisungScreen({
    super.key,
    required this.productId,
  });

  @override
  State<BetriebsanweisungScreen> createState() =>
      _BetriebsanweisungScreenState();
}

class _BetriebsanweisungScreenState extends State<BetriebsanweisungScreen> {
  final DataService _dataService = DataService();
  late Future<Sicherheitsdatenblatt> _sdbFuture;

  @override
  void initState() {
    super.initState();
    _sdbFuture = _loadProduct();
  }

  Future<Sicherheitsdatenblatt> _loadProduct() async {
    // Load product index to find the JSON filename
    final index = await _dataService.loadProductIndex();
    final product = index.findById(widget.productId);

    if (product == null) {
      throw Exception('Produkt mit ID "${widget.productId}" nicht gefunden.');
    }

    // Load and return the actual product data
    return _dataService.loadSicherheitsdatenblatt(product.file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Betriebsanweisung'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: FutureBuilder<Sicherheitsdatenblatt>(
        future: _sdbFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Fehler beim Laden',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.home),
                      label: const Text('Zurück zur Übersicht'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Success state - display the Betriebsanweisung
          final sdb = snapshot.data!;
          return _BetriebsanweisungContent(sdb: sdb);
        },
      ),
    );
  }
}

/// Content widget displaying the complete Betriebsanweisung template
class _BetriebsanweisungContent extends StatelessWidget {
  final Sicherheitsdatenblatt sdb;

  const _BetriebsanweisungContent({required this.sdb});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Section 1: Header
              _PlaceholderSection(
                title: 'Header',
                backgroundColor: baOrange,
                textColor: baTextLight,
                content: 'Nr.: ${sdb.documentNumber}\n'
                    'Betriebsanweisung gem. §14 GefStoffV\n'
                    'Stand: ${sdb.documentDate}\n'
                    'Betrieb: ${sdb.companyName}',
              ),

              // Section 2: Gefahrstoffbezeichnung (Product Section)
              _PlaceholderSection(
                title: 'Gefahrstoffbezeichnung',
                backgroundColor: baContentBg,
                textColor: baTextDark,
                content: 'Produkt: ${sdb.name}\n'
                    'Kategorie: ${sdb.hazardCategory}\n'
                    'Piktogramme: ${sdb.pictograms.join(", ")}',
              ),

              // Section 3: Gefahren für Mensch und Umwelt
              _PlaceholderSection(
                title: 'Gefahren für Mensch und Umwelt',
                backgroundColor: baOrange,
                textColor: baTextLight,
                headerOnly: true,
              ),
              _PlaceholderSection(
                title: '',
                backgroundColor: baContentBg,
                textColor: baTextDark,
                content: sdb.hazardsDescription.isEmpty
                    ? '[Gefahrenbeschreibung wird hier angezeigt]'
                    : sdb.hazardsDescription,
                showBorder: false,
              ),

              // Section 4: Schutzmaßnahmen und Verhaltensregeln
              _PlaceholderSection(
                title: 'Schutzmaßnahmen und Verhaltensregeln',
                backgroundColor: baContentBg,
                textColor: baTextDark,
                content: sdb.protectiveMeasures.isEmpty
                    ? 'Schutzausrüstung: ${sdb.safetyEquipment.join(", ")}\n'
                        '[Schutzmaßnahmen werden hier angezeigt]'
                    : 'Schutzausrüstung: ${sdb.safetyEquipment.join(", ")}\n\n'
                        '${sdb.protectiveMeasures}',
              ),

              // Section 5: Verhalten im Gefahrfall
              _PlaceholderSection(
                title: 'Verhalten im Gefahrfall (Unfalltelefon: ${sdb.emergencyPhoneReference})',
                backgroundColor: baOrange,
                textColor: baTextLight,
                headerOnly: true,
              ),
              _PlaceholderSection(
                title: '',
                backgroundColor: baContentBg,
                textColor: baTextDark,
                content: sdb.emergencyProcedures.isEmpty
                    ? '[Notfallmaßnahmen werden hier angezeigt]'
                    : sdb.emergencyProcedures,
                showBorder: false,
              ),

              // Section 6: Erste Hilfe
              _PlaceholderSection(
                title: 'Erste Hilfe (Ersthelfer: ${sdb.firstAiderReference})',
                backgroundColor: baOrange,
                textColor: baTextLight,
                headerOnly: true,
              ),
              _PlaceholderSection(
                title: '',
                backgroundColor: baContentBg,
                textColor: baTextDark,
                content: _formatFirstAid(sdb.firstAid),
                showBorder: false,
              ),

              // Section 7: Sachgerechte Entsorgung
              _PlaceholderSection(
                title: 'Sachgerechte Entsorgung',
                backgroundColor: baOrange,
                textColor: baTextLight,
                headerOnly: true,
              ),
              _PlaceholderSection(
                title: '',
                backgroundColor: baContentBg,
                textColor: baTextDark,
                content: sdb.disposal.isEmpty
                    ? '[Entsorgungshinweise werden hier angezeigt]'
                    : '${sdb.disposal}\n\n'
                        'Verantwortlich: ${sdb.responsiblePerson.isEmpty ? "_______________" : sdb.responsiblePerson}',
                showBorder: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Formats first aid instructions into readable sections
  String _formatFirstAid(Map<String, String> firstAid) {
    final buffer = StringBuffer();

    if (firstAid['hautkontakt']?.isNotEmpty ?? false) {
      buffer.writeln('Nach Hautkontakt:');
      buffer.writeln(firstAid['hautkontakt']);
      buffer.writeln();
    }

    if (firstAid['augenkontakt']?.isNotEmpty ?? false) {
      buffer.writeln('Nach Augenkontakt:');
      buffer.writeln(firstAid['augenkontakt']);
      buffer.writeln();
    }

    if (firstAid['verschlucken']?.isNotEmpty ?? false) {
      buffer.writeln('Nach Verschlucken:');
      buffer.writeln(firstAid['verschlucken']);
      buffer.writeln();
    }

    if (firstAid['einatmen']?.isNotEmpty ?? false) {
      buffer.writeln('Nach Einatmen:');
      buffer.writeln(firstAid['einatmen']);
    }

    return buffer.toString().trim();
  }
}

/// Placeholder section widget for Phase 3
/// Will be replaced with proper widgets in Phase 4
class _PlaceholderSection extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final String? content;
  final bool headerOnly;
  final bool showBorder;

  const _PlaceholderSection({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    this.content,
    this.headerOnly = false,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: showBorder
            ? Border.all(color: baBorder, width: 2)
            : Border(
                top: BorderSide(color: baBorder, width: 2),
                left: BorderSide(color: baBorder, width: 2),
                right: BorderSide(color: baBorder, width: 2),
                bottom: BorderSide(color: baBorder, width: 2),
              ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: TextStyle(
                fontSize: headerOnly ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          if (content != null && !headerOnly) ...[
            const SizedBox(height: 12),
            Text(
              content!,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
