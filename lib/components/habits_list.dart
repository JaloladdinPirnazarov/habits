import '../utils/importer.dart';

class HabitsList extends StatelessWidget {
  const HabitsList({super.key});

  @override
  Widget build(BuildContext context) {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;

    void checkHabitOnOff(bool? value, Habit habit) {
      if (value != null) {
        print('$value');
        context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
      }
    }

    return currentHabits.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: currentHabits.length,
            itemBuilder: (context, index) {
              final habit = currentHabits[index];
              return HabitTile(
                habit: habit,
                onChanged: (value) => checkHabitOnOff(value, habit),
              );
            })
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SvgPicture.asset(context.watch<ThemeProvider>().isDarkMode
                  ? ImageConstants.emptyImageDark
                  : ImageConstants.emptyImageLight),
            ),
          );
  }
}
