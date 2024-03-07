import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../messageBox.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> writeMessages(List<MessageBox> messages) async {
  final path = join((await localPath), 'messages.txt');

  return File(path).writeAsString(messages.join('\n'));
}

Future<List<MessageBox>> readMessages() async {
  try {
    final path = join((await localPath), 'messages.txt');

    final contents = await File(path).readAsString();

    List<String> lines = contents.split('\n');

    List<MessageBox> messages = lines.map((line) {
      return MessageBox(message: line);
    }).toList();

    return messages;
  } catch (e) {
    // If error, return empty list
    return [];
  }
}
