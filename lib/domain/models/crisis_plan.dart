import 'dart:convert';

/// Domain model for the user's personalized crisis plan.
class CrisisPlan {
  const CrisisPlan({
    this.id,
    this.warningSigns = const [],
    this.copingStrategies = const [],
    this.socialSupport = const [],
    this.safeEnvironment,
    this.professionalResources = const [],
    this.emergencyContacts = const [],
    this.localResources = const [],
    this.personalMotivation,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final List<String> warningSigns;
  final List<String> copingStrategies;
  final List<EmergencyContact> socialSupport;
  final String? safeEnvironment;
  final List<ProfessionalResource> professionalResources;
  final List<EmergencyContact> emergencyContacts;
  final List<LocalResource> localResources;
  final String? personalMotivation;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CrisisPlan copyWith({
    int? id,
    List<String>? warningSigns,
    List<String>? copingStrategies,
    List<EmergencyContact>? socialSupport,
    String? safeEnvironment,
    List<ProfessionalResource>? professionalResources,
    List<EmergencyContact>? emergencyContacts,
    List<LocalResource>? localResources,
    String? personalMotivation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CrisisPlan(
      id: id ?? this.id,
      warningSigns: warningSigns ?? this.warningSigns,
      copingStrategies: copingStrategies ?? this.copingStrategies,
      socialSupport: socialSupport ?? this.socialSupport,
      safeEnvironment: safeEnvironment ?? this.safeEnvironment,
      professionalResources:
          professionalResources ?? this.professionalResources,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      localResources: localResources ?? this.localResources,
      personalMotivation: personalMotivation ?? this.personalMotivation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Emergency contact with name and phone number.
class EmergencyContact {
  const EmergencyContact({
    required this.name,
    required this.phoneNumber,
    this.relationship,
    this.note,
  });

  final String name;
  final String phoneNumber;
  final String? relationship;
  final String? note;

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        if (relationship != null) 'relationship': relationship,
        if (note != null) 'note': note,
      };

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      relationship: json['relationship'] as String?,
      note: json['note'] as String?,
    );
  }

  static List<EmergencyContact> listFromJson(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return [];
    final list = jsonDecode(jsonString) as List;
    return list
        .map((e) => EmergencyContact.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listToJson(List<EmergencyContact> contacts) {
    return jsonEncode(contacts.map((e) => e.toJson()).toList());
  }

  EmergencyContact copyWith({
    String? name,
    String? phoneNumber,
    String? relationship,
    String? note,
  }) {
    return EmergencyContact(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      relationship: relationship ?? this.relationship,
      note: note ?? this.note,
    );
  }
}

/// Professional resource like therapist, clinic, or doctor.
class ProfessionalResource {
  const ProfessionalResource({
    required this.name,
    this.phoneNumber,
    this.address,
    this.website,
    this.type,
  });

  final String name;
  final String? phoneNumber;
  final String? address;
  final String? website;
  final String? type;

  Map<String, dynamic> toJson() => {
        'name': name,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (address != null) 'address': address,
        if (website != null) 'website': website,
        if (type != null) 'type': type,
      };

  factory ProfessionalResource.fromJson(Map<String, dynamic> json) {
    return ProfessionalResource(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
      type: json['type'] as String?,
    );
  }

  static List<ProfessionalResource> listFromJson(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return [];
    final list = jsonDecode(jsonString) as List;
    return list
        .map((e) => ProfessionalResource.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listToJson(List<ProfessionalResource> resources) {
    return jsonEncode(resources.map((e) => e.toJson()).toList());
  }
}

/// Local resource like community center or support group.
class LocalResource {
  const LocalResource({
    required this.name,
    this.description,
    this.phoneNumber,
    this.address,
  });

  final String name;
  final String? description;
  final String? phoneNumber;
  final String? address;

  Map<String, dynamic> toJson() => {
        'name': name,
        if (description != null) 'description': description,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (address != null) 'address': address,
      };

  factory LocalResource.fromJson(Map<String, dynamic> json) {
    return LocalResource(
      name: json['name'] as String,
      description: json['description'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
    );
  }

  static List<LocalResource> listFromJson(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return [];
    final list = jsonDecode(jsonString) as List;
    return list
        .map((e) => LocalResource.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listToJson(List<LocalResource> resources) {
    return jsonEncode(resources.map((e) => e.toJson()).toList());
  }
}
