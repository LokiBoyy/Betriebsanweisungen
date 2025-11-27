/// Model for Sicherheitsdatenblatt (Safety Data Sheet)
///
/// This model represents the structured data required to generate a legally
/// compliant German Betriebsanweisung (Operating Instruction) according to
/// §14 GefStoffV (German Hazardous Substances Ordinance).
class Sicherheitsdatenblatt {
  /// Product identifier (URL-safe, used for routing)
  final String id;

  /// Document number displayed in header (e.g., "000 Muster")
  final String documentNumber;

  /// Document date in format DD.MM.YYYY (stored as string, no validation)
  final String documentDate;

  /// Company/facility name displayed in header
  final String companyName;

  /// Specific workplace or area (optional, defaults to empty string)
  final String workplace;

  /// Product name (displayed prominently in template)
  final String name;

  /// Hazard category for pictogram label (e.g., "Ätzend", "Entzündlich")
  final String hazardCategory;

  /// List of GHS pictogram codes (e.g., ["ghs05", "ghs07"])
  final List<String> pictograms;

  /// List of safety equipment/PPE codes (e.g., ["goggles", "gloves", "protective-clothing"])
  final List<String> safetyEquipment;

  /// Detailed paragraph text for "Gefahren für Mensch und Umwelt" section
  final String hazardsDescription;

  /// Detailed paragraph text for "Schutzmaßnahmen und Verhaltensregeln" section
  final String protectiveMeasures;

  /// Detailed paragraph text for "Verhalten im Gefahrfall" section
  final String emergencyProcedures;

  /// Emergency phone reference (e.g., "siehe Aushang" or actual number)
  final String emergencyPhoneReference;

  /// First aid instructions for four scenarios:
  /// - hautkontakt: After skin contact
  /// - augenkontakt: After eye contact
  /// - verschlucken: After ingestion
  /// - einatmen: After inhalation
  final Map<String, String> firstAid;

  /// First aider reference (e.g., "siehe Aushang")
  final String firstAiderReference;

  /// Detailed disposal instructions for "Sachgerechte Entsorgung" section
  final String disposal;

  /// Responsible person for signature line (optional, defaults to empty string)
  final String responsiblePerson;

  /// Constructor with required and optional parameters
  Sicherheitsdatenblatt({
    required this.id,
    required this.documentNumber,
    required this.documentDate,
    required this.companyName,
    this.workplace = '',
    required this.name,
    required this.hazardCategory,
    required this.pictograms,
    required this.safetyEquipment,
    required this.hazardsDescription,
    required this.protectiveMeasures,
    required this.emergencyProcedures,
    required this.emergencyPhoneReference,
    required this.firstAid,
    required this.firstAiderReference,
    required this.disposal,
    this.responsiblePerson = '',
  });

  /// Create instance from JSON with null safety and defaults
  factory Sicherheitsdatenblatt.fromJson(Map<String, dynamic> json) {
    // Validate required fields
    if (json['id'] == null || json['id'].toString().isEmpty) {
      throw FormatException('Field "id" is required and cannot be empty');
    }
    if (json['name'] == null || json['name'].toString().isEmpty) {
      throw FormatException('Field "name" is required and cannot be empty');
    }

    return Sicherheitsdatenblatt(
      id: json['id'] as String,
      documentNumber: json['document_number'] as String? ?? '',
      documentDate: json['document_date'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      workplace: json['workplace'] as String? ?? '',
      name: json['name'] as String,
      hazardCategory: json['hazard_category'] as String? ?? '',
      pictograms: (json['pictograms'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      safetyEquipment: (json['safety_equipment'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      hazardsDescription: json['hazards_description'] as String? ?? '',
      protectiveMeasures: json['protective_measures'] as String? ?? '',
      emergencyProcedures: json['emergency_procedures'] as String? ?? '',
      emergencyPhoneReference:
          json['emergency_phone_reference'] as String? ?? 'siehe Aushang',
      firstAid: _parseFirstAid(json['first_aid']),
      firstAiderReference:
          json['first_aider_reference'] as String? ?? 'siehe Aushang',
      disposal: json['disposal'] as String? ?? '',
      responsiblePerson: json['responsible_person'] as String? ?? '',
    );
  }

  /// Parse first_aid map with default values for all four scenarios
  static Map<String, String> _parseFirstAid(dynamic firstAidData) {
    if (firstAidData is Map) {
      return {
        'hautkontakt': firstAidData['hautkontakt']?.toString() ?? '',
        'augenkontakt': firstAidData['augenkontakt']?.toString() ?? '',
        'verschlucken': firstAidData['verschlucken']?.toString() ?? '',
        'einatmen': firstAidData['einatmen']?.toString() ?? '',
      };
    }
    // Return empty map with all keys if first_aid is missing or invalid
    return {
      'hautkontakt': '',
      'augenkontakt': '',
      'verschlucken': '',
      'einatmen': '',
    };
  }

  /// Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'document_number': documentNumber,
      'document_date': documentDate,
      'company_name': companyName,
      'workplace': workplace,
      'name': name,
      'hazard_category': hazardCategory,
      'pictograms': pictograms,
      'safety_equipment': safetyEquipment,
      'hazards_description': hazardsDescription,
      'protective_measures': protectiveMeasures,
      'emergency_procedures': emergencyProcedures,
      'emergency_phone_reference': emergencyPhoneReference,
      'first_aid': firstAid,
      'first_aider_reference': firstAiderReference,
      'disposal': disposal,
      'responsible_person': responsiblePerson,
    };
  }

  @override
  String toString() {
    return 'Sicherheitsdatenblatt{id: $id, name: $name, hazardCategory: $hazardCategory}';
  }
}
