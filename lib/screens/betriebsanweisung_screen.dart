/// Betriebsanweisung detail screen displaying the complete legal template
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/sicherheitsdatenblatt.dart';
import '../services/data_service.dart';
import '../widgets/ba_header.dart';
import '../widgets/ba_product_section.dart';
import '../widgets/ba_hazards_section.dart';
import '../widgets/ba_protective_measures_section.dart';
import '../widgets/ba_emergency_section.dart';
import '../widgets/ba_first_aid_section.dart';
import '../widgets/ba_disposal_section.dart';

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
              BAHeader(
                documentNumber: sdb.documentNumber,
                documentDate: sdb.documentDate,
                companyName: sdb.companyName,
              ),

              // Section 2: Gefahrstoffbezeichnung (Product Section)
              BAProductSection(
                productName: sdb.name,
                pictogramCodes: sdb.pictograms.isNotEmpty
                    ? sdb.pictograms
                    : ['ghs07'], // Default to general hazard if no pictograms
                hazardCategory: sdb.hazardCategory,
              ),

              // Section 3: Gefahren für Mensch und Umwelt
              BAHazardsSection(
                hazardsDescription: sdb.hazardsDescription.isEmpty
                    ? '[Gefahrenbeschreibung wird hier angezeigt]'
                    : sdb.hazardsDescription,
              ),

              // Section 4: Schutzmaßnahmen und Verhaltensregeln
              BAProtectiveMeasuresSection(
                protectiveMeasures: sdb.protectiveMeasures.isEmpty
                    ? '[Schutzmaßnahmen werden hier angezeigt]'
                    : sdb.protectiveMeasures,
                safetyEquipment: sdb.safetyEquipment,
              ),

              // Section 5: Verhalten im Gefahrfall
              BAEmergencySection(
                emergencyProcedures: sdb.emergencyProcedures.isEmpty
                    ? '[Notfallmaßnahmen werden hier angezeigt]'
                    : sdb.emergencyProcedures,
                emergencyPhoneReference: sdb.emergencyPhoneReference,
              ),

              // Section 6: Erste Hilfe
              BAFirstAidSection(
                firstAid: sdb.firstAid,
                firstAiderReference: sdb.firstAiderReference,
              ),

              // Section 7: Sachgerechte Entsorgung (includes integrated footer)
              BADisposalSection(
                disposal: sdb.disposal.isEmpty
                    ? '[Entsorgungshinweise werden hier angezeigt]'
                    : sdb.disposal,
                responsiblePerson: sdb.responsiblePerson,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
