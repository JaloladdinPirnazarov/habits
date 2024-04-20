import '../../utils/importer.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;
  final List<Habit> currentHabits = [];
  String textFieldError = '';

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabitSchema, AppSettingsSchema], directory: dir.path);
  }

  void setError(String errorText) {
    textFieldError = errorText;
    notifyListeners();
  }

  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firsLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  Future<void> saveThemeMode(bool isDarkMode) async {
    final existingSettings = await isar.appSettings.where().findFirst();
    existingSettings!.isDarkMode = isDarkMode;
    await isar.writeTxn(() => isar.appSettings.put(existingSettings));
    notifyListeners();
  }

  Future<bool?> getThemeMode() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.isDarkMode;
  }

  Future<DateTime?> getFirsLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firsLaunchDate;
  }

  Future<void> addHabit(String habitName) async {
    final newHabit = Habit()..name = habitName;
    await isar.writeTxn(() => isar.habits.put(newHabit));
    await readHabits();
  }

  Future<void> readHabits() async {
    List<Habit> fetchedHabits = await isar.habits.where().findAll();
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);
    notifyListeners();
  }

  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        if (isCompleted && !habit.isHabitCompletedToday()) {
          habit.completedDays.add(DateTime.now());
        } else {
          final today = DateTime.now();
          habit.completedDays.removeWhere((date) =>
              date.year == today.year &&
              date.month == today.month &&
              date.day == today.day);
        }
        await isar.habits.put(habit);
      });
    }
    await readHabits();
  }

  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;
        await isar.habits.put(habit);
      });
    }
    await readHabits();
  }

  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
    await readHabits();
  }
}
