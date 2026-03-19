import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/core/constants/content_license_tags.dart';
import 'package:innenkompass/domain/models/belastungsskala.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';

void main() {
  group('Intervention content licensing', () {
    test('all interventions expose structured rights metadata', () {
      for (final intervention in InterventionLibrary.allInterventions) {
        expect(
          intervention.licenseTag,
          isA<ContentLicenseTag>(),
          reason: 'Missing license tag for ${intervention.id}',
        );
        expect(
          intervention.licenseNotes,
          isNotNull,
          reason: 'Missing license notes for ${intervention.id}',
        );
        expect(
          intervention.licenseNotes!.trim(),
          isNotEmpty,
          reason: 'Empty license notes for ${intervention.id}',
        );
      }
    });

    test('worksheet templates use the documented rights tag', () {
      expect(
        InterventionLibrary.abc3Protocol.licenseTag,
        ContentLicenseTag.originalInspiredNoCopy,
      );
      expect(
        InterventionLibrary.rsaAbcde.licenseTag,
        ContentLicenseTag.originalInspiredNoCopy,
      );
    });

    test('intervention json uses the documented wire value', () {
      final json = InterventionLibrary.abc3Protocol.toJson();

      expect(json['licenseTag'], 'original-inspired-no-copy');
    });

    test('selbsteinschaetzung exposes structured rights metadata', () {
      expect(
        SelbsteinschaetzungsSkala.licenseTag,
        ContentLicenseTag.publicDomain,
      );
      expect(SelbsteinschaetzungsSkala.licenseNotes, isNotEmpty);
    });
  });
}
