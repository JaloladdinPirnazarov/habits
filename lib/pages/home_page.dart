import '../utils/importer.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final habitDataBase = context.watch<HabitDatabase>();
    final currentHabits = habitDataBase.currentHabits;
    final HabitRepository repository = HabitRepository(context: context);
    return FutureBuilder(
        future: repository.readHabits(),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              actions: [
                Text(context.watch<ThemeProvider>().isDarkMode
                    ? 'Dark mode'
                    : 'Light mode'),
                const SizedBox(
                  width: 10,
                ),
                CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context).isDarkMode,
                    onChanged: (value) => repository.switchTheme(value)),
                const SizedBox(
                  width: 16,
                ),
              ],
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => repository.addEditHabit(null),
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                FutureBuilder(
                    future: habitDataBase.getFirsLaunchDate(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return MyHeatMap(
                            startDate: snapshot.data!,
                            dataSets: prepHeatMapDataSet(currentHabits));
                      } else {
                        return Container();
                      }
                    }),
                const HabitsList()
              ],
            ),
          );
        });
  }
}
