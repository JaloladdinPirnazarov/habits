import '../utils/importer.dart';
part 'app_settings.g.dart';

@Collection()
class AppSettings{
  Id id = Isar.autoIncrement;
  DateTime? firsLaunchDate;
  bool? isDarkMode;
}