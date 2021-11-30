import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'count_data.freezed.dart';
part 'count_data.g.dart';

@freezed
class CountData with _$CountData {
  factory CountData({
    @Default(0) int count,
    @Default(0) int countUp,
    @Default(0) int countDown,
  }) = _CountData;
  factory CountData.fromJson(Map<String, dynamic> json) =>
      _$CountDataFromJson(json);
}
