import 'package:annotations/annotations.dart';

part 'ViewMe.g.dart';

@customAnnotation
class Viewme {
  String? key;
  String? value;
  int? age;

  Viewme({this.key, this.value, this.age});
}
