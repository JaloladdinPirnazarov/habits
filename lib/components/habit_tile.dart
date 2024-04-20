import 'package:flutter_slidable/flutter_slidable.dart';
import '../utils/importer.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final void Function(bool?) onChanged;

  const HabitTile({
    super.key,
    required this.habit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final HabitRepository repository = HabitRepository(context: context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => repository.addEditHabit(habit),
              backgroundColor: Colors.grey.shade800,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(8),
            ),
            SlidableAction(
              onPressed: (_) => repository.deleteHabit(habit),
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!habit.isHabitCompletedToday());
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: habit.isHabitCompletedToday()
                    ? Colors.green
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              title: Text(
                habit.name,
                style: TextStyle(
                    color: habit.isHabitCompletedToday()
                        ? Colors.white
                        : Theme.of(context).colorScheme.inversePrimary),
              ),
              leading: Checkbox(
                activeColor: Colors.green,
                value: habit.isHabitCompletedToday(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
