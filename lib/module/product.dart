import 'package:annotations/annotations.dart';

part 'product.g.dart';

@customAnnotation
class Product {
  final String name;

  Product(this.name);

  /// Connect the generated [_$ProductFromJson] function to the `fromJson`
  /// factory.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// Connect the generated [_$ProductToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
