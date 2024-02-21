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
    int trackLength = int.parse(splittedData[0]);
    int cars = int.parse(splittedData[1]);
    lines.removeAt(0);
    List<Map<String, int>> data = [];
    for (var j = 0; j < cars; j++) {
      print(j);
      List split = lines[0].toString().split(' ');
      int cId = int.parse(split[0]);
      int cSpeed = int.parse(split[1]);
      int cturboSpeed = int.parse(split[2]);
      int cturboBoostCooldown = int.parse(split[3]);
      int cturboBoostDuration = int.parse(split[4]);
      int time = 0;
      int pauseTime = 0;

      var distance = 0;
      while (distance <= trackLength) {
        if (time == 0 || pauseTime % (cturboBoostCooldown + 1) == 0) {
          print(time.toString() +
              ' - ' +
              distance.toString() +
              ' - ' +
              (cturboBoostCooldown + 1).toString() +
              ' - ' +
              pauseTime.toString());
          if (cturboSpeed * cturboBoostDuration > trackLength - distance) {
            int ceil = ((trackLength - distance) / cturboSpeed).ceil();
            distance += (cturboSpeed * ceil);
            time += ceil;
            pauseTime++;
          } else {
            distance += (cturboSpeed * cturboBoostDuration);
            time += cturboBoostDuration;
            pauseTime++;
          }
        } else {
          print(distance.toString() + ' / ' + time.toString());

          distance += cSpeed;
          time++;
          pauseTime++;
        }
      }

      data.add(
        {
          'cID': cId,
          'time': time,
          'boost': cturboSpeed,
        },
      );
      lines.removeAt(0);
    }
    data.sort((a, b) => a['time']!.compareTo(b['time']!));
    print(data);

    List newData =
        data.where((element) => element['time'] == data.first['time']).toList();
    newData.sort((a, b) => b['boost']!.compareTo(a['boost']));

    result.add(
      {
        'case': i + 1,
        'id': newData.first['cID'],
      },
    );
  }
  String finalText = '';
  result.forEach(
      (element) => finalText += 'Case #${element['case']}: ${element['id']}\n');
  File outputFile = File('output.txt');
  outputFile.writeAsString(finalText);
}
