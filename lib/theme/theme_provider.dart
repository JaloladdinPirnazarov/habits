import '../utils/importer.dart';

class ThemeProvider extends ChangeNotifier{
  static final ThemeProvider instance = ThemeProvider._();
  ThemeProvider._();
  ThemeData _themeData = lightMode;

  ThemeData get themeData=>_themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void switchTheme(bool isDarkMode){
    if(isDarkMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}