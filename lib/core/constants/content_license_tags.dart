import 'package:json_annotation/json_annotation.dart';

/// Structured rights markers for static therapeutic content.
enum ContentLicenseTag {
  @JsonValue('original-inspired-no-copy')
  originalInspiredNoCopy('original-inspired-no-copy'),

  @JsonValue('license-required')
  licenseRequired('license-required'),

  @JsonValue('licensed-kohlhammer')
  licensedKohlhammer('licensed-kohlhammer'),

  @JsonValue('licensed-hogrefe')
  licensedHogrefe('licensed-hogrefe'),

  @JsonValue('licensed-oup')
  licensedOup('licensed-oup'),

  @JsonValue('public-domain')
  publicDomain('public-domain');

  const ContentLicenseTag(this.wireValue);

  final String wireValue;

  bool get requiresExternalApproval {
    switch (this) {
      case ContentLicenseTag.originalInspiredNoCopy:
      case ContentLicenseTag.publicDomain:
        return false;
      case ContentLicenseTag.licenseRequired:
      case ContentLicenseTag.licensedKohlhammer:
      case ContentLicenseTag.licensedHogrefe:
      case ContentLicenseTag.licensedOup:
        return true;
    }
  }
}
