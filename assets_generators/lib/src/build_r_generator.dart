import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';

class AssetsBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final assetDir = Directory('assets');
    if (!assetDir.existsSync()) {
      throw Exception(
          "the assets dir must be create ! please check root project ");
    }

    final assetFiles = assetDir.listSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("class R{");

    for (var file in assetFiles) {
      final relativePath = file.path.replaceFirst("assets/", "");
      final name = relativePath.replaceAll('.', '_');
      buffer.writeln('static String $name = \'assets/$relativePath\';');
    }
    buffer.writeln("}");

    print("AssetsBuilder.build: ${buffer.toString()}");

    final outPutFile = File('lib/generator/R.g.dart');
    if (!outPutFile.existsSync()) {
      await outPutFile.create();
    }
    // 使用DartFormatter 美化输出
    var fileContent = DartFormatter().format(buffer.toString());
    await outPutFile.writeAsString(fileContent);
  }

  @override
  Map<String, List<String>> get buildExtensions => const {
        r'$package$': ['lib/generator/R.g.dart']
      };
}

Builder assetsBuilder(BuilderOptions options) => AssetsBuilder();
