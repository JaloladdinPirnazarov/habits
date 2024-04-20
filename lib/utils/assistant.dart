import 'package:habits/utils/importer.dart';

Map<DateTime, int> prepHeatMapDataSet(List<Habit> habits) {
  Map<DateTime, int> dataSet = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      final normalizedData = DateTime(date.year, date.month, date.day);
      if (dataSet.containsKey(normalizedData)) {
        dataSet[normalizedData] = dataSet[normalizedData]! + 1;
      } else {
        dataSet[normalizedData] = 1;
      }
    }
  }
  return dataSet;
}

int dayDifference(DateTime start, DateTime end){
  Duration difference = end.difference(start);
  return difference.inDays;
}
