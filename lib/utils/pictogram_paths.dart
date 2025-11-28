/// Helper class for mapping pictogram codes to actual asset file paths.
///
/// This class provides static methods to convert simple pictogram codes
/// (used in JSON data files) to the actual file paths in the assets directory.
///
/// Example:
/// ```dart
/// final path = PictogramPaths.getGHSPath('ghs05');
/// // Returns: 'pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_05_gr.gif'
/// ```
class PictogramPaths {
  /// Converts a GHS pictogram code to its file path.
  ///
  /// Input: 'ghs05' (lowercase, from JSON)
  /// Output: 'pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_05_gr.gif'
  ///
  /// All GHS pictograms are .gif files with format: GHS_##_gr.gif
  /// Returns empty string if code is invalid.
  static String getGHSPath(String code) {
    // Validate code format and range
    if (!code.startsWith('ghs') || code.length < 5) return '';

    try {
      final number = int.parse(code.substring(3));
      if (number < 1 || number > 9) return '';

      final paddedNumber = number.toString().padLeft(2, '0');
      return 'assets/pictograms/Kennzeichnung-von-Gefahrstoffen/GHS_${paddedNumber}_gr.gif';
    } catch (e) {
      return '';
    }
  }

  /// Mapping of safety equipment codes to their actual filenames.
  ///
  /// These are Gebotszeichen (mandatory signs) for personal protective equipment (PPE).
  /// All files are .jpg format with pattern: M###_Description.jpg
  static final Map<String, String> _safetyEquipment = {
    'goggles': 'M004_Augenschutz-benutzen.jpg',
    'gloves': 'M009_Handschutz_benutzen.jpg',
    'protective-clothing': 'M010_Schutzkleidung-benutzen.jpg',
    'respiratory': 'M017_Atemschutz-benutzen.jpg',
    'ear-protection': 'M003_Gehoerschutz-benutzen.jpg',
    'safety-shoes': 'M008_Fussschutz-benutzen.jpg',
    'face-shield': 'M013_Gesichtsschutz-benutzen.jpg',
    'hard-hat': 'M014_Kopfschutz-benutzen.jpg',
    'high-vis-vest': 'M015_Warnweste-benutzen.jpg',
    'safety-apron': 'M026_Schutzschuerze-benutzen.jpg',
  };

  /// Converts a safety equipment code to its file path.
  ///
  /// Input: 'goggles' (from JSON)
  /// Output: 'assets/pictograms/Gebotszeichen/M004_Augenschutz-benutzen.jpg'
  ///
  /// Returns empty string if code is not found.
  static String getSafetyEquipmentPath(String code) {
    final filename = _safetyEquipment[code];
    if (filename == null) return '';
    return 'assets/pictograms/Gebotszeichen/$filename';
  }

  /// Mapping of warning sign codes to their actual filenames.
  ///
  /// These are Warnzeichen (warning signs) for hazards.
  /// All files are .jpg format with pattern: W###-Description.jpg
  static final Map<String, String> _warnings = {
    'warning-general': 'W001-Allgemeines-Warnzeichen.jpg',
    'warning-corrosive': 'W023-Warnung-vor-aetzenden-Stoffen.jpg',
    'warning-toxic': 'W016-Warnung-vor-giftigen-Stoffen.jpg',
    'warning-fire': 'W021-Warnung-vor-feuergefaehrlichen.jpg',
    'warning-explosive': 'W002 Warnung vor explosionsgefährlichen Stoffen.jpg',
  };

  /// Converts a warning sign code to its file path.
  ///
  /// Input: 'warning-general' (from JSON)
  /// Output: 'assets/pictograms/Warnzeichen/W001-Allgemeines-Warnzeichen.jpg'
  ///
  /// Returns empty string if code is not found.
  static String getWarningPath(String code) {
    final filename = _warnings[code];
    if (filename == null) return '';
    return 'assets/pictograms/Warnzeichen/$filename';
  }

  /// Mapping of emergency sign codes to their actual filenames.
  ///
  /// These are Rettungszeichen (emergency/rescue signs).
  /// All files are .jpg format with pattern: E###-Description.jpg
  static final Map<String, String> _emergency = {
    'first-aid': 'E003-Erste-Hilfe.jpg',
    'eye-wash': 'E011-Augenspueleinrichtung.jpg',
    'emergency-shower': 'E012-Notdusche.jpg',
    'emergency-phone': 'E004-Notruftelefon.jpg',
  };

  /// Converts an emergency sign code to its file path.
  ///
  /// Input: 'first-aid' (from JSON)
  /// Output: 'assets/pictograms/Rettungszeichen/E003-Erste-Hilfe.jpg'
  ///
  /// Returns empty string if code is not found.
  static String getEmergencyPath(String code) {
    final filename = _emergency[code];
    if (filename == null) return '';
    return 'assets/pictograms/Rettungszeichen/$filename';
  }

  /// Checks if a safety equipment code is valid.
  static bool isSafetyEquipmentCode(String code) {
    return _safetyEquipment.containsKey(code);
  }

  /// Checks if a warning sign code is valid.
  static bool isWarningCode(String code) {
    return _warnings.containsKey(code);
  }

  /// Checks if an emergency sign code is valid.
  static bool isEmergencyCode(String code) {
    return _emergency.containsKey(code);
  }

  /// Gets all available GHS pictogram codes.
  static List<String> get availableGHSCodes =>
      ['ghs01', 'ghs02', 'ghs03', 'ghs04', 'ghs05', 'ghs06', 'ghs07', 'ghs08', 'ghs09'];

  /// Gets all available safety equipment codes.
  static List<String> get availableSafetyEquipmentCodes =>
      _safetyEquipment.keys.toList();

  /// Gets all available warning codes.
  static List<String> get availableWarningCodes => _warnings.keys.toList();

  /// Gets all available emergency codes.
  static List<String> get availableEmergencyCodes => _emergency.keys.toList();
}
