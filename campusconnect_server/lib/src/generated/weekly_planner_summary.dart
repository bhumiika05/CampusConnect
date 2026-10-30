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
import 'planner_item.dart' as _in2kwev7;

abstract class WeeklyPlannerSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  WeeklyPlannerSummary._({
    required this.items,
    required this.totalTasks,
    required this.completedTasks,
    required this.recommendedItems,
  });

  factory WeeklyPlannerSummary({
    required List<_in2kwev7.PlannerItem> items,
    required int totalTasks,
    required int completedTasks,
    required List<_in2kwev7.PlannerItem> recommendedItems,
  }) = _WeeklyPlannerSummaryImpl;

  factory WeeklyPlannerSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return WeeklyPlannerSummary(
      items: _iusjeinx.Protocol().deserialize<List<_in2kwev7.PlannerItem>>(
        jsonSerialization['items'],
      ),
      totalTasks: jsonSerialization['totalTasks'] as int,
      completedTasks: jsonSerialization['completedTasks'] as int,
      recommendedItems: _iusjeinx.Protocol()
          .deserialize<List<_in2kwev7.PlannerItem>>(
            jsonSerialization['recommendedItems'],
          ),
    );
  }

  List<_in2kwev7.PlannerItem> items;

  int totalTasks;

  int completedTasks;

  List<_in2kwev7.PlannerItem> recommendedItems;

  /// Returns a shallow copy of this [WeeklyPlannerSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WeeklyPlannerSummary copyWith({
    List<_in2kwev7.PlannerItem>? items,
    int? totalTasks,
    int? completedTasks,
    List<_in2kwev7.PlannerItem>? recommendedItems,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WeeklyPlannerSummary',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'totalTasks': totalTasks,
      'completedTasks': completedTasks,
      'recommendedItems': recommendedItems.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WeeklyPlannerSummary',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalTasks': totalTasks,
      'completedTasks': completedTasks,
      'recommendedItems': recommendedItems.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _WeeklyPlannerSummaryImpl extends WeeklyPlannerSummary {
  _WeeklyPlannerSummaryImpl({
    required List<_in2kwev7.PlannerItem> items,
    required int totalTasks,
    required int completedTasks,
    required List<_in2kwev7.PlannerItem> recommendedItems,
  }) : super._(
         items: items,
         totalTasks: totalTasks,
         completedTasks: completedTasks,
         recommendedItems: recommendedItems,
       );

  /// Returns a shallow copy of this [WeeklyPlannerSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WeeklyPlannerSummary copyWith({
    List<_in2kwev7.PlannerItem>? items,
    int? totalTasks,
    int? completedTasks,
    List<_in2kwev7.PlannerItem>? recommendedItems,
  }) {
    return WeeklyPlannerSummary(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      recommendedItems:
          recommendedItems ??
          this.recommendedItems.map((e0) => e0.copyWith()).toList(),
    );
  }
}
