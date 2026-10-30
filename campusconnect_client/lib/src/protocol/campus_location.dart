/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:campusconnect_client/src/protocol/protocol.dart' as _im7konmk;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class CampusLocation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CampusLocation._({
    this.id,
    required this.name,
    required this.category,
    required this.shortDescription,
    required this.latitude,
    required this.longitude,
    this.buildingBlock,
    this.openingHours,
    this.contactInfo,
    this.website,
    this.accessibilityInfo,
    required this.isVerified,
    this.tags,
  });

  factory CampusLocation({
    int? id,
    required String name,
    required String category,
    required String shortDescription,
    required double latitude,
    required double longitude,
    String? buildingBlock,
    String? openingHours,
    String? contactInfo,
    String? website,
    String? accessibilityInfo,
    required bool isVerified,
    List<String>? tags,
  }) = _CampusLocationImpl;

  factory CampusLocation.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusLocation(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] as String,
      shortDescription: jsonSerialization['shortDescription'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      buildingBlock: jsonSerialization['buildingBlock'] as String?,
      openingHours: jsonSerialization['openingHours'] as String?,
      contactInfo: jsonSerialization['contactInfo'] as String?,
      website: jsonSerialization['website'] as String?,
      accessibilityInfo: jsonSerialization['accessibilityInfo'] as String?,
      isVerified: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isVerified'],
      ),
      tags: jsonSerialization['tags'] == null
          ? null
          : _im7konmk.Protocol().deserialize<List<String>>(
              jsonSerialization['tags'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String category;

  String shortDescription;

  double latitude;

  double longitude;

  String? buildingBlock;

  String? openingHours;

  String? contactInfo;

  String? website;

  String? accessibilityInfo;

  bool isVerified;

  List<String>? tags;

  /// Returns a shallow copy of this [CampusLocation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CampusLocation copyWith({
    int? id,
    String? name,
    String? category,
    String? shortDescription,
    double? latitude,
    double? longitude,
    String? buildingBlock,
    String? openingHours,
    String? contactInfo,
    String? website,
    String? accessibilityInfo,
    bool? isVerified,
    List<String>? tags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusLocation',
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'shortDescription': shortDescription,
      'latitude': latitude,
      'longitude': longitude,
      if (buildingBlock != null) 'buildingBlock': buildingBlock,
      if (openingHours != null) 'openingHours': openingHours,
      if (contactInfo != null) 'contactInfo': contactInfo,
      if (website != null) 'website': website,
      if (accessibilityInfo != null) 'accessibilityInfo': accessibilityInfo,
      'isVerified': isVerified,
      if (tags != null) 'tags': tags?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusLocation',
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'shortDescription': shortDescription,
      'latitude': latitude,
      'longitude': longitude,
      if (buildingBlock != null) 'buildingBlock': buildingBlock,
      if (openingHours != null) 'openingHours': openingHours,
      if (contactInfo != null) 'contactInfo': contactInfo,
      if (website != null) 'website': website,
      if (accessibilityInfo != null) 'accessibilityInfo': accessibilityInfo,
      'isVerified': isVerified,
      if (tags != null) 'tags': tags?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusLocationImpl extends CampusLocation {
  _CampusLocationImpl({
    int? id,
    required String name,
    required String category,
    required String shortDescription,
    required double latitude,
    required double longitude,
    String? buildingBlock,
    String? openingHours,
    String? contactInfo,
    String? website,
    String? accessibilityInfo,
    required bool isVerified,
    List<String>? tags,
  }) : super._(
         id: id,
         name: name,
         category: category,
         shortDescription: shortDescription,
         latitude: latitude,
         longitude: longitude,
         buildingBlock: buildingBlock,
         openingHours: openingHours,
         contactInfo: contactInfo,
         website: website,
         accessibilityInfo: accessibilityInfo,
         isVerified: isVerified,
         tags: tags,
       );

  /// Returns a shallow copy of this [CampusLocation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CampusLocation copyWith({
    Object? id = _Undefined,
    String? name,
    String? category,
    String? shortDescription,
    double? latitude,
    double? longitude,
    Object? buildingBlock = _Undefined,
    Object? openingHours = _Undefined,
    Object? contactInfo = _Undefined,
    Object? website = _Undefined,
    Object? accessibilityInfo = _Undefined,
    bool? isVerified,
    Object? tags = _Undefined,
  }) {
    return CampusLocation(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      shortDescription: shortDescription ?? this.shortDescription,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      buildingBlock: buildingBlock is String?
          ? buildingBlock
          : this.buildingBlock,
      openingHours: openingHours is String? ? openingHours : this.openingHours,
      contactInfo: contactInfo is String? ? contactInfo : this.contactInfo,
      website: website is String? ? website : this.website,
      accessibilityInfo: accessibilityInfo is String?
          ? accessibilityInfo
          : this.accessibilityInfo,
      isVerified: isVerified ?? this.isVerified,
      tags: tags is List<String>? ? tags : this.tags?.map((e0) => e0).toList(),
    );
  }
}
