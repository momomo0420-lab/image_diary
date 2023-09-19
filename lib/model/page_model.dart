import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'page_model.freezed.dart';
part 'page_model.g.dart';

@freezed
class PageModel with _$PageModel {
  const PageModel._();

  const factory PageModel({
    // 主キー
    int? id,
    // タイトル
    @Default('')
    String title,
    // 本文
    @Default('')
    String content,
    // 日付
    @Default(0)
    int date,
    // 画像
    // @ImageConverter()
    @Default([])
    List<int> image,
    // 画像の名前
    @Default('')
    @JsonKey(name: 'image_name')
    String imageName,
  }) = _PageModel;

  factory PageModel.fromJson(Map<String, dynamic> json) => _$PageModelFromJson(json);

  /// 時刻（DateTime）を文字列に変換する
  String getFormattedDate() {
    return DateFormat('yyyy年MM月dd日')
        .format(DateTime.fromMillisecondsSinceEpoch(date));
  }
}
