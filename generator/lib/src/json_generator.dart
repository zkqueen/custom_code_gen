import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:generator/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

class JsonGenerator extends GeneratorForAnnotation<CustomAnnotation> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final ModelVisitor visitor = ModelVisitor();
    element.visitChildren(visitor);

    // Buffer to write each part of generated class
    final buffer = StringBuffer();

    // fromJson
    String generatedFromJSon = generateFromJsonMethod(visitor);
    buffer.writeln(generatedFromJSon);

    // toJson
    String generatedToJSon = generateToJsonMethod(visitor);
    buffer.writeln(generatedToJSon);

    // copyWith
    String generatedCopyWith = generateCopyWithMethod(visitor);
    buffer.writeln(generatedCopyWith);

    return buffer.toString();
  }

  // Method to generate fromJSon method
  String generateFromJsonMethod(ModelVisitor visitor) {
    // Class name from model visitor
    String className = visitor.className;

    // Buffer to write each part of generated class
    final buffer = StringBuffer();

    // --------------------Start fromJson Generation Code--------------------//
    buffer.writeln('// From Json Method');
    buffer.writeln(
        '$className _\$${className}FromJson(Map<String, dynamic> json) => ');
    buffer.write('$className(');

    for (int i = 0; i < visitor.fields.length; i++) {
      String fieldName = visitor.fields.keys.elementAt(i);
      String mapValue = "json['$fieldName']";

      buffer.writeln(
        "${visitor.fields.keys.elementAt(i)}: $mapValue,",
      );
    }
    buffer.writeln(');');
    buffer.toString();
    return buffer.toString();
    // --------------------End fromJson Generation Code--------------------//
  }

  // Method to generate fromJSon method
  String generateToJsonMethod(ModelVisitor visitor) {
    // Class name from model visitor
    String className = visitor.className;

    // Buffer to write each part of generated class
    final buffer = StringBuffer();

    // --------------------Start toJson Generation Code--------------------//
    buffer.writeln('// To Json Method');
    buffer.writeln(
        'Map<String, dynamic> _\$${className}ToJson($className instance) => ');
    buffer.write('<String, dynamic>{');
    for (int i = 0; i < visitor.fields.length; i++) {
      String fieldName = visitor.fields.keys.elementAt(i);
      buffer.writeln(
        "'$fieldName': instance.$fieldName,",
      );
    }
    buffer.writeln('};');
    return buffer.toString();
    // --------------------End toJson Generation Code--------------------//
  }

  // Method to generate fromJSon method
  String generateCopyWithMethod(ModelVisitor visitor) {
    // Class name from model visitor
    String className = visitor.className;

    // Buffer to write each part of generated class
    final buffer = StringBuffer();

    // --------------------Start copyWith Generation Code--------------------//
    buffer.writeln(
        "// Extension for a $className class to provide 'copyWith' method");
    buffer.writeln('extension \$${className}Extension on $className {');
    buffer.writeln('$className copyWith({');
    for (int i = 0; i < visitor.fields.length; i++) {
      String dataType =
          visitor.fields.values.elementAt(i).toString().replaceAll("?", "");
      String fieldName = visitor.fields.keys.elementAt(i);
      buffer.writeln(
        '$dataType? $fieldName,',
      );
    }
    buffer.writeln('}) {');
    buffer.writeln('return $className(');
    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        "${visitor.fields.keys.elementAt(i)}: ${visitor.fields.keys.elementAt(i)} ?? this.${visitor.fields.keys.elementAt(i)},",
      );
    }
    buffer.writeln(');');
    buffer.writeln('}');
    buffer.writeln('}');
    buffer.toString();
    return buffer.toString();
    // --------------------End copyWith Generation Code--------------------//
  }
}
