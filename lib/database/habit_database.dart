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
  Future<DateTime?>getFirstLaunchedDate() async{
    final settings=await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /*
  CRUD Operation */

  // lsit of habit

  // create -- add a new habit

  // read -read saved habit from database
  // update -- check habit on and off
  // update-- edit habit name
  // delete -delete habit
}
