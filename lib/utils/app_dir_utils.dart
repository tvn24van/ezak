import 'dart:convert';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'package:path_provider/path_provider.dart' show getApplicationSupportDirectory;
// import 'package:path/path.dart' as p;

final class AppDir{
  static String? _localPath;

  static Future<String> getLocalPath() async{
    if(_localPath == null){
      final pathProvider = await getApplicationSupportDirectory();
      return pathProvider.path;
    }
    return _localPath!;
  }

  static Future<String> loadFromLocalPath(String path) async{
    final localPath = await AppDir.getLocalPath();
    final file = File(localPath + path);
    return await file.readAsString(encoding: utf8);
  }

  static Future<Future<FileSystemEntity>> clear() async{
    final path = p.join(
      await AppDir.getLocalPath(),
      'data'
    );
    return File(path).delete(recursive: true);
  }
}