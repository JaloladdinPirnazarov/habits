import 'utils/importer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();
  await HabitRepository().setTheme();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => HabitDatabase(),
        child: const MyApp(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider.instance,
        child: const MyApp(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
    );
  }
}
