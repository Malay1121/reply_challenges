import 'dart:convert';
import 'dart:io';

void main() async {
  File file = File('input.txt');
  String text = await file.readAsStringSync();
  List lines = LineSplitter().convert(text);
  int testCases = int.parse(lines[0]);
  List<Map> result = [];
  lines.removeAt(0);
  for (var i = 0; i < testCases; i++) {
    print('case:- ' + i.toString());
    List splittedData = lines[0].toString().split(' ');
    int width = int.parse(splittedData[0]);
    int height = int.parse(splittedData[1]);
    int plants = int.parse(splittedData[2]);

    int ground = int.parse(splittedData[3]);
    lines.removeAt(0);
    List<(int, int)> data = [];
    for (var j = 0; j < ground; j++) {
      List splittedCoordinate = lines[j].toString().split(' ');
      var coordinate =
          (int.parse(splittedCoordinate[0]), int.parse(splittedCoordinate[1]));
      data.add(coordinate);
    }
  }
  String finalText = '';
  result.forEach(
      (element) => finalText += 'Case #${element['case']}: ${element['id']}\n');
  File outputFile = File('output.txt');
  outputFile.writeAsString(finalText);
}
