import 'package:flutter/cupertino.dart';
import 'package:habit_heat_map/models/app_setting.dart';
import 'package:habit_heat_map/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;
  /*
  setup
  */
  //initialize -database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingSchema],
      directory: dir.path,
    );
  }

  // save first date of app starup(for heatma);
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSetting()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(
        () => isar.appSettings.put(settings),
      );
    }
  }

  // get frist dateof app setting
  Future<DateTime?> getFirstLaunchedDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /*
  CRUD Operations
  */

  // lsit of habit
  final List<Habit> currentHabits = [];
  // create -- add a new habit
  Future<void> addHabit(String habitName) async {
    // create a new habit
    final newHabit = Habit()..name = habitName;

    //save to db
    await isar.writeTxn(() => isar.habits.put(newHabit));
    // re-read from db
    readHabits();
  }

  // read -read saved habit from database
  Future<void> readHabits() async {
    // fetch all the habits from db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // give to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);
    // update ui
    notifyListeners();
  }

  // update -- check habit on and off
  Future<void> updateHabitCompletion(int id, bool isComplted) async {
    // find the spectific habit
    final habit = await isar.habits.get(id);
    // update complteiton status
    if (habit != null) {
      await isar.writeTxn(() async {
        // if habit is complted -> add the current date to the  completeddate list
        if (isComplted && !habit.completedDays.contains(DateTime.now())) {
          // today
          final today = DateTime.now();
          // add the current date  if it's not already in the list
          habit.completedDays.add(
            DateTime(
              today.year,
              today.month,
              today.day,
            ),
          );
        } else {
          // remove curr date if the habit is marked as not completed
          habit.completedDays.removeWhere(
            (date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day,
          );
        }
        // save the updated habits back to db
        await isar.habits.put(habit);
      });
    }
    // re-read from db
    readHabits();
  }

  // update-- edit habit name
  Future<void> updatedHabitName(int id, String newName) async {
    //find  the spectific habit
    final habit = await isar.habits.get(id);

    // update the habi name
    if (habit != null) {
      // update name
      await isar.writeTxn(() async {
        habit.name = newName;
        // save update habit back to db
        await isar.habits.put(habit);
      });
    }

    // reread from db
    readHabits();
  }

  // delete -delete habit
  Future<void> deleteHabit(int id) async {
    // perform the delete
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
    // re-read from db
    readHabits();
  }
}
