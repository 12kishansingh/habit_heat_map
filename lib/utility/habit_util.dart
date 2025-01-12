// given a habit lsit of compltetion days is the habit complteted today
import 'package:habit_heat_map/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> compltedDays) {
  final today = DateTime.now();
  return compltedDays.any((date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day);
}

// prepare heat map dataset
Map<DateTime,int>prepareHeatMapDataset(List<Habit>habits){
  Map<DateTime,int>dataset={};

  for(var habit in habits){
    for(var date in habit.completedDays){
      // normalize date to avoid time mismatch
      final normalizeddate=DateTime(date.year,date.month,date.day);

      //if the date already existin the dataset increment its count
      if(dataset.containsKey(normalizeddate)){
        dataset[normalizeddate]=dataset[normalizeddate]!+1;
      }else{
        // initialize it with a count of 1
        dataset[normalizeddate]=1;
      }
    }
  }
  return dataset;
}