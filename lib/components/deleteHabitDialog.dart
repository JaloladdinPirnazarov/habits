import '../utils/importer.dart';

class DeleteHabitDialog extends StatelessWidget {
  const DeleteHabitDialog({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Are you sure you want to delete?'),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        MaterialButton(
          onPressed: () {
            context.read<HabitDatabase>().deleteHabit(habit.id);
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
