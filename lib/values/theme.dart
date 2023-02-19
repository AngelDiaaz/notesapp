import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color lightGreen = Color(0xff8CBA80);
const Color purple = Color(0xff7E5A9B);
const Color lightBlue = Color(0xff007991);
const Color darkBlue = Color(0xff0D1821);
const Color darkGrey = Color(0xff172121);

class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme;

  // Cuando llamo a esta clase el metodo por defecto que voy a llamar es el del tema claro
  ThemeProvider() {
    setLightMode();
  }

  /// Metodo que hace el tema de la aplicacion sea clara
  setLightMode() {
    currentTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: lightBlue, secondary: lightGreen),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: darkGrey)),
    );
    notifyListeners();
  }

  /// Metodo que hace el tema de la aplicacion sea oscuro
  setDarkMode() {
    currentTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: darkGrey, secondary: purple, brightness: Brightness.dark),
      appBarTheme:
          const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
    );
    notifyListeners();
  }
}
