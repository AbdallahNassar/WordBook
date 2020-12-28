import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/gradient_helper.dart';
import '../../meaning/meaning_screen.dart';
import '../../../widgets/gradient_icon.dart';

class WordMeaningCard extends StatelessWidget {
  //================================ Parameters ================================
  final String word;
  // list of nouns => [nouns] for example
  final meaningCategoryList;
  //================================ Constructor ===============================
  const WordMeaningCard({
    Key key,
    @required this.word,
    @required this.meaningCategoryList,
  }) : super(key: key);
  //================================= Methods ==================================
  void arrowFunction(context, meaningCategoryList, word, id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MeaningScreen(
            meaningCategoryList: meaningCategoryList, word: word, id: id),
      ),
    );
  }

  //============================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    // generate uniqure id for the hero
    final String uniqueID = Uuid().v1();
    //==========================================================================
    return Container(
      margin: EdgeInsets.only(
        bottom: _mediaQuery.size.height * 0.01,
        right: _mediaQuery.size.height * 0.02,
        left: _mediaQuery.size.height * 0.02,
      ),
      padding: EdgeInsets.only(
        left: _mediaQuery.size.height * 0.01,
        right: _mediaQuery.size.height * 0.03,
        top: _mediaQuery.size.height * 0.01,
        bottom: _mediaQuery.size.height * 0.01,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(
            8.0,
          ),
          child: Icon(
            Icons.lens,
            size: 10.0,
            color: Color(0xFF8C2480),
          ),
        ),
        // hero to animate the transition between the word,meaning screens
        title: Hero(
          // uuid package to get a unique id
          //https://stackoverflow.com/questions/15548652/how-to-generate-unique-id-in-dart
          tag: uniqueID,
          child: Container(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                word,
                style: Platform.isAndroid
                    ? Theme.of(context).textTheme.button.copyWith(
                          fontSize: 19,
                        )
                    : CupertinoTheme.of(context)
                        .textTheme
                        .pickerTextStyle
                        .copyWith(
                          fontSize: 19,
                        ),
              ),
            ),
          ),
        ),
        subtitle: Text(
          meaningCategoryList[0]['partOfSpeech'],
          style: GoogleFonts.lobster(
            fontSize: 15.0,
            textStyle: GradientHelper.mGetSearchCardTextStyle(
              context,
              _mediaQuery.size.width * 0.9,
              _mediaQuery.size.height * 0.01,
            ),
          ),
        ),
        trailing: FittedBox(
          child: NextArrow(
            functionHandler: () =>
                arrowFunction(context, meaningCategoryList, word, uniqueID),
            icon: Icon(
              PlatformIcons(context).upArrow,
              size: _mediaQuery.orientation == Orientation.landscape
                  ? _mediaQuery.size.height * 0.1
                  : _mediaQuery.size.height * 0.03,
            ),
          ),
        ),
      ),
    );
  }
}
