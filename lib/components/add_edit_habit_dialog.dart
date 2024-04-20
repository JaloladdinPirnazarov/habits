import '../utils/importer.dart';

class AddEditHabitDialog extends StatelessWidget {
  AddEditHabitDialog({super.key, this.habit}) {
    if (habit != null) {
      action = 'Edit';
      textController.text = habit!.name;
    }
  }

  final Habit? habit;
  final TextEditingController textController = TextEditingController();
  String action = 'Save';

  @override
  Widget build(BuildContext context) {

    void dismissDialog(){
      context.read<HabitDatabase>().setError('');
      Navigator.of(context).pop();
      textController.clear();
    }

    void addEditHabit() {
      if (textController.text.trim().isNotEmpty) {
        String newHabitName = textController.text;
        if (habit != null) {
          context
              .read<HabitDatabase>()
              .updateHabitName(habit!.id, newHabitName);
        } else {
          context.read<HabitDatabase>().addHabit(newHabitName);
        }
        dismissDialog();
      } else {
        context.read<HabitDatabase>().setError('Fill the field');
      }
    }

    return AlertDialog(
      content: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: 'Create a new habit',
          error: context.watch<HabitDatabase>().textFieldError == ''
              ? null
              : Text(
                  context.watch<HabitDatabase>().textFieldError,
                  style: const TextStyle(color: Colors.red),
                ),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: dismissDialog,
          child: const Text('Cancel'),
        ),
        MaterialButton(
          onPressed: addEditHabit,
          child: Text(action),
        ),
      ],
    );
  }
}
