import 'package:flutter_test/flutter_test.dart';
import 'package:betriebsanweisungen/utils/pictogram_paths.dart';

void main() {
  group('PictogramPaths - GHS Pictograms', () {
    test('getGHSPath returns correct path for ghs01', () {
      expect(
        PictogramPaths.getGHSPath('ghs01'),
        'assets/pictograms/Kennzeichnung von Gefahrstoffen/GHS_01_gr.gif',
      );
    });

    test('getGHSPath returns correct path for ghs05', () {
      expect(
        PictogramPaths.getGHSPath('ghs05'),
        'assets/pictograms/Kennzeichnung von Gefahrstoffen/GHS_05_gr.gif',
      );
    });

    test('getGHSPath returns correct path for ghs09', () {
      expect(
        PictogramPaths.getGHSPath('ghs09'),
        'assets/pictograms/Kennzeichnung von Gefahrstoffen/GHS_09_gr.gif',
      );
    });

    test('getGHSPath returns empty string for invalid code', () {
      expect(PictogramPaths.getGHSPath('invalid'), '');
    });

    test('getGHSPath returns empty string for empty code', () {
      expect(PictogramPaths.getGHSPath(''), '');
    });

    test('availableGHSCodes returns all 9 codes', () {
      final codes = PictogramPaths.availableGHSCodes;
      expect(codes.length, 9);
      expect(codes, contains('ghs01'));
      expect(codes, contains('ghs09'));
    });
  });

  group('PictogramPaths - Safety Equipment', () {
    test('getSafetyEquipmentPath returns correct path for goggles', () {
      expect(
        PictogramPaths.getSafetyEquipmentPath('goggles'),
        'assets/pictograms/Gebotszeichen/M004_Augenschutz-benutzen.jpg',
      );
    });

    test('getSafetyEquipmentPath returns correct path for gloves', () {
      expect(
        PictogramPaths.getSafetyEquipmentPath('gloves'),
        'assets/pictograms/Gebotszeichen/M009_Handschutz_benutzen.jpg',
      );
    });

    test('getSafetyEquipmentPath returns correct path for protective-clothing', () {
      expect(
        PictogramPaths.getSafetyEquipmentPath('protective-clothing'),
        'assets/pictograms/Gebotszeichen/M010_Schutzkleidung-benutzen.jpg',
      );
    });

    test('getSafetyEquipmentPath returns correct path for respiratory', () {
      expect(
        PictogramPaths.getSafetyEquipmentPath('respiratory'),
        'assets/pictograms/Gebotszeichen/M017_Atemschutz-benutzen.jpg',
      );
    });

    test('getSafetyEquipmentPath returns empty string for invalid code', () {
      expect(PictogramPaths.getSafetyEquipmentPath('invalid'), '');
    });

    test('isSafetyEquipmentCode returns true for valid codes', () {
      expect(PictogramPaths.isSafetyEquipmentCode('goggles'), true);
      expect(PictogramPaths.isSafetyEquipmentCode('gloves'), true);
      expect(PictogramPaths.isSafetyEquipmentCode('respiratory'), true);
    });

    test('isSafetyEquipmentCode returns false for invalid codes', () {
      expect(PictogramPaths.isSafetyEquipmentCode('invalid'), false);
      expect(PictogramPaths.isSafetyEquipmentCode('ghs05'), false);
    });

    test('availableSafetyEquipmentCodes returns all codes', () {
      final codes = PictogramPaths.availableSafetyEquipmentCodes;
      expect(codes.length, greaterThanOrEqualTo(4));
      expect(codes, contains('goggles'));
      expect(codes, contains('gloves'));
      expect(codes, contains('protective-clothing'));
      expect(codes, contains('respiratory'));
    });
  });

  group('PictogramPaths - Warning Signs', () {
    test('getWarningPath returns correct path for warning-general', () {
      expect(
        PictogramPaths.getWarningPath('warning-general'),
        'assets/pictograms/Warnzeichen/W001-Allgemeines-Warnzeichen.jpg',
      );
    });

    test('getWarningPath returns correct path for warning-corrosive', () {
      expect(
        PictogramPaths.getWarningPath('warning-corrosive'),
        'assets/pictograms/Warnzeichen/W023-Warnung-vor-aetzenden-Stoffen.jpg',
      );
    });

    test('getWarningPath returns empty string for invalid code', () {
      expect(PictogramPaths.getWarningPath('invalid'), '');
    });

    test('isWarningCode returns true for valid codes', () {
      expect(PictogramPaths.isWarningCode('warning-general'), true);
      expect(PictogramPaths.isWarningCode('warning-corrosive'), true);
    });

    test('isWarningCode returns false for invalid codes', () {
      expect(PictogramPaths.isWarningCode('invalid'), false);
    });

    test('availableWarningCodes returns all codes', () {
      final codes = PictogramPaths.availableWarningCodes;
      expect(codes, contains('warning-general'));
      expect(codes, contains('warning-corrosive'));
    });
  });

  group('PictogramPaths - Emergency Signs', () {
    test('getEmergencyPath returns correct path for first-aid', () {
      expect(
        PictogramPaths.getEmergencyPath('first-aid'),
        'assets/pictograms/Rettungszeichen/E003-Erste-Hilfe.jpg',
      );
    });

    test('getEmergencyPath returns correct path for eye-wash', () {
      expect(
        PictogramPaths.getEmergencyPath('eye-wash'),
        'assets/pictograms/Rettungszeichen/E011-Augenspueleinrichtung.jpg',
      );
    });

    test('getEmergencyPath returns empty string for invalid code', () {
      expect(PictogramPaths.getEmergencyPath('invalid'), '');
    });

    test('isEmergencyCode returns true for valid codes', () {
      expect(PictogramPaths.isEmergencyCode('first-aid'), true);
      expect(PictogramPaths.isEmergencyCode('eye-wash'), true);
    });

    test('isEmergencyCode returns false for invalid codes', () {
      expect(PictogramPaths.isEmergencyCode('invalid'), false);
    });

    test('availableEmergencyCodes returns all codes', () {
      final codes = PictogramPaths.availableEmergencyCodes;
      expect(codes, contains('first-aid'));
      expect(codes, contains('eye-wash'));
    });
  });

  group('PictogramPaths - Data Validation', () {
    test('all GHS codes map to valid paths', () {
      for (final code in PictogramPaths.availableGHSCodes) {
        final path = PictogramPaths.getGHSPath(code);
        expect(path, isNotEmpty);
        expect(path, startsWith('assets/pictograms/'));
        expect(path, endsWith('.gif'));
      }
    });

    test('all safety equipment codes map to valid paths', () {
      for (final code in PictogramPaths.availableSafetyEquipmentCodes) {
        final path = PictogramPaths.getSafetyEquipmentPath(code);
        expect(path, isNotEmpty);
        expect(path, startsWith('assets/pictograms/'));
        expect(path, endsWith('.jpg'));
      }
    });

    test('all warning codes map to valid paths', () {
      for (final code in PictogramPaths.availableWarningCodes) {
        final path = PictogramPaths.getWarningPath(code);
        expect(path, isNotEmpty);
        expect(path, startsWith('assets/pictograms/'));
        expect(path, endsWith('.jpg'));
      }
    });

    test('all emergency codes map to valid paths', () {
      for (final code in PictogramPaths.availableEmergencyCodes) {
        final path = PictogramPaths.getEmergencyPath(code);
        expect(path, isNotEmpty);
        expect(path, startsWith('assets/pictograms/'));
        expect(path, endsWith('.jpg'));
      }
    });
  });
}
