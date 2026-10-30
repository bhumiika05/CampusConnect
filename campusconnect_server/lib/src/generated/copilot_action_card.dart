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
import 'package:serverpod/serverpod.dart' as _is;

abstract class CopilotActionCard
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CopilotActionCard._({
    required this.cardType,
    required this.title,
    required this.subtitle,
    this.badge,
    this.referenceId,
    this.actionLabel,
    this.dataPayload,
  });

  factory CopilotActionCard({
    required String cardType,
    required String title,
    required String subtitle,
    String? badge,
    int? referenceId,
    String? actionLabel,
    String? dataPayload,
  }) = _CopilotActionCardImpl;

  factory CopilotActionCard.fromJson(Map<String, dynamic> jsonSerialization) {
    return CopilotActionCard(
      cardType: jsonSerialization['cardType'] as String,
      title: jsonSerialization['title'] as String,
      subtitle: jsonSerialization['subtitle'] as String,
      badge: jsonSerialization['badge'] as String?,
      referenceId: jsonSerialization['referenceId'] as int?,
      actionLabel: jsonSerialization['actionLabel'] as String?,
      dataPayload: jsonSerialization['dataPayload'] as String?,
    );
  }

  String cardType;

  String title;

  String subtitle;

  String? badge;

  int? referenceId;

  String? actionLabel;

  String? dataPayload;

  /// Returns a shallow copy of this [CopilotActionCard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CopilotActionCard copyWith({
    String? cardType,
    String? title,
    String? subtitle,
    String? badge,
    int? referenceId,
    String? actionLabel,
    String? dataPayload,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CopilotActionCard',
      'cardType': cardType,
      'title': title,
      'subtitle': subtitle,
      if (badge != null) 'badge': badge,
      if (referenceId != null) 'referenceId': referenceId,
      if (actionLabel != null) 'actionLabel': actionLabel,
      if (dataPayload != null) 'dataPayload': dataPayload,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CopilotActionCard',
      'cardType': cardType,
      'title': title,
      'subtitle': subtitle,
      if (badge != null) 'badge': badge,
      if (referenceId != null) 'referenceId': referenceId,
      if (actionLabel != null) 'actionLabel': actionLabel,
      if (dataPayload != null) 'dataPayload': dataPayload,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CopilotActionCardImpl extends CopilotActionCard {
  _CopilotActionCardImpl({
    required String cardType,
    required String title,
    required String subtitle,
    String? badge,
    int? referenceId,
    String? actionLabel,
    String? dataPayload,
  }) : super._(
         cardType: cardType,
         title: title,
         subtitle: subtitle,
         badge: badge,
         referenceId: referenceId,
         actionLabel: actionLabel,
         dataPayload: dataPayload,
       );

  /// Returns a shallow copy of this [CopilotActionCard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CopilotActionCard copyWith({
    String? cardType,
    String? title,
    String? subtitle,
    Object? badge = _Undefined,
    Object? referenceId = _Undefined,
    Object? actionLabel = _Undefined,
    Object? dataPayload = _Undefined,
  }) {
    return CopilotActionCard(
      cardType: cardType ?? this.cardType,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      badge: badge is String? ? badge : this.badge,
      referenceId: referenceId is int? ? referenceId : this.referenceId,
      actionLabel: actionLabel is String? ? actionLabel : this.actionLabel,
      dataPayload: dataPayload is String? ? dataPayload : this.dataPayload,
    );
  }
}
