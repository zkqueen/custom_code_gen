// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ViewMe.dart';

// **************************************************************************
// JsonGenerator
// **************************************************************************

// From Json Method
Viewme _$ViewmeFromJson(Map<String, dynamic> json) => Viewme(
      key: json['key'],
      value: json['value'],
      age: json['age'],
    );

// To Json Method
Map<String, dynamic> _$ViewmeToJson(Viewme instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'age': instance.age,
    };

// Extension for a Viewme class to provide 'copyWith' method
extension $ViewmeExtension on Viewme {
  Viewme copyWith({
    String? key,
    String? value,
    int? age,
  }) {
    return Viewme(
      key: key ?? this.key,
      value: value ?? this.value,
      age: age ?? this.age,
    );
  }
}
