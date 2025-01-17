import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/home/home_screen.dart';
import './screens/word/word_screen.dart';
import './screens/meaning/meaning_screen.dart';

void main() {
  runApp(WordBook());
}

class WordBook extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return PlatformApp(
      debugShowCheckedModeBanner: false,
      // to allow the usage of material stuff on cupertino app
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      routes: {
        // String, Widget Function(BuildContext)
        HomeScreen.routeName: (context) => HomeScreen(),
        WordScreen.routeName: (context) => WordScreen(),
        MeaningScreen.routeName: (context) => MeaningScreen(),
      },
      material: (_, __) => MaterialAppData(
        theme: ThemeData(
          primaryColor: Color(0xFFFF9D80),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            // app title style
            headline1: GoogleFonts.pacifico(
              color: Colors.white,
              fontSize: 38.0,
              fontWeight: FontWeight.bold,
            ),
            // home screen chips style
            button: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 23.0,
            ),
            // phonetics list tile text style
            headline2: GoogleFonts.comfortaa(
              color: Colors.black,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
            // meanding list tile style
            headline3: GoogleFonts.lobster(
              color: Colors.black,
              fontSize: 17.0,
            ),
            // phonetics row style
            headline4: GoogleFonts.dancingScript(
              color: Colors.black,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      cupertino: (_, __) => CupertinoAppData(
        // to allow the usage of material stuff on cupertino app
        theme: CupertinoThemeData(
          primaryColor: Color(0xFFFF9D80),
          textTheme: CupertinoTextThemeData(
              // this will be for the application title
              navLargeTitleTextStyle: GoogleFonts.pacifico(
                color: Colors.white,
                fontSize: 38.0,
                fontWeight: FontWeight.bold,
              ),
              // meaning list tile text style
              pickerTextStyle: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 23.0,
                fontWeight: FontWeight.w500,
              ),
              // home screen chips style
              tabLabelTextStyle: GoogleFonts.comfortaa(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
              // meanding subtitle list tile style
              navActionTextStyle: GoogleFonts.lobster(
                color: Color(0xFFFF9485),
                fontSize: 17.0,
              ),
              // phonetics row style
              dateTimePickerTextStyle: GoogleFonts.dancingScript(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
