import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponseModel {
  final bool? result;
  final String? code;

  BaseResponseModel({
    required this.result,
    required this.code,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseModelToJson(this);

  @override
  String toString() => 'BaseResponseModel(result=$result, code=$code)';
}


