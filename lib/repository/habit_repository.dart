import '../utils/importer.dart';

class HabitRepository {
  final BuildContext? context;

  HabitRepository({this.context});

  void addEditHabit(Habit? habit) {
    showDialog(
        context: context!,
        builder: (context) => AddEditHabitDialog(
              habit: habit,
            ));
  }

  void deleteHabit(Habit habit) {
    showDialog(
        context: context!,
        builder: (context) => DeleteHabitDialog(
              habit: habit,
            ));
  }

  Future<void> setTheme() async {
    bool? isDark = await HabitDatabase().getThemeMode();
    isDark ??= false;
    ThemeProvider.instance.switchTheme(isDark);
  }

  Future<void> switchTheme(bool isDarkMode) async {
    Provider.of<ThemeProvider>(context!, listen: false).switchTheme(isDarkMode);
    await HabitDatabase().saveThemeMode(isDarkMode);
  }

  Future<void> readHabits() async {
    await Provider.of<HabitDatabase>(context!, listen: false).readHabits();
  }
}
