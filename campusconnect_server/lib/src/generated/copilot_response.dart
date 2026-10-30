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
import 'package:campusconnect_server/src/generated/protocol.dart' as _iusjeinx;
import 'package:serverpod/serverpod.dart' as _is;
import 'copilot_action_card.dart' as _isfb8n60;

abstract class CopilotResponse
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CopilotResponse._({
    required this.reply,
    required this.category,
    required this.suggestedPrompts,
    required this.recommendedCards,
  });

  factory CopilotResponse({
    required String reply,
    required String category,
    required List<String> suggestedPrompts,
    required List<_isfb8n60.CopilotActionCard> recommendedCards,
  }) = _CopilotResponseImpl;

  factory CopilotResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return CopilotResponse(
      reply: jsonSerialization['reply'] as String,
      category: jsonSerialization['category'] as String,
      suggestedPrompts: _iusjeinx.Protocol().deserialize<List<String>>(
        jsonSerialization['suggestedPrompts'],
      ),
      recommendedCards: _iusjeinx.Protocol()
          .deserialize<List<_isfb8n60.CopilotActionCard>>(
            jsonSerialization['recommendedCards'],
          ),
    );
  }

  String reply;

  String category;

  List<String> suggestedPrompts;

  List<_isfb8n60.CopilotActionCard> recommendedCards;

  /// Returns a shallow copy of this [CopilotResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CopilotResponse copyWith({
    String? reply,
    String? category,
    List<String>? suggestedPrompts,
    List<_isfb8n60.CopilotActionCard>? recommendedCards,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CopilotResponse',
      'reply': reply,
      'category': category,
      'suggestedPrompts': suggestedPrompts.toJson(),
      'recommendedCards': recommendedCards.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CopilotResponse',
      'reply': reply,
      'category': category,
      'suggestedPrompts': suggestedPrompts.toJson(),
      'recommendedCards': recommendedCards.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CopilotResponseImpl extends CopilotResponse {
  _CopilotResponseImpl({
    required String reply,
    required String category,
    required List<String> suggestedPrompts,
    required List<_isfb8n60.CopilotActionCard> recommendedCards,
  }) : super._(
         reply: reply,
         category: category,
         suggestedPrompts: suggestedPrompts,
         recommendedCards: recommendedCards,
       );

  /// Returns a shallow copy of this [CopilotResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CopilotResponse copyWith({
    String? reply,
    String? category,
    List<String>? suggestedPrompts,
    List<_isfb8n60.CopilotActionCard>? recommendedCards,
  }) {
    return CopilotResponse(
      reply: reply ?? this.reply,
      category: category ?? this.category,
      suggestedPrompts:
          suggestedPrompts ?? this.suggestedPrompts.map((e0) => e0).toList(),
      recommendedCards:
          recommendedCards ??
          this.recommendedCards.map((e0) => e0.copyWith()).toList(),
    );
  }
}
