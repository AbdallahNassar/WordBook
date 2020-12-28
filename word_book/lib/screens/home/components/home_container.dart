import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import './home_text.dart';
import '../../../widgets/white_container.dart';
import '../../../screens/word/word_screen.dart';
import '../../../helpers/gradient_helper.dart';
import '../../../helpers/language_helper.dart';
import '../../../widgets/gradient_icon.dart';

class HomeContainer extends StatefulWidget {
  //================================ Constructor ===============================
  const HomeContainer({
    Key key,
  }) : super(key: key);
  //================================= Methods ==================================
  void arrowFunction(context, _selectedChipIndex) {
    Navigator.of(context).pushNamed(
      WordScreen.routeName,
      arguments: LanguageHelper.langListMap[_selectedChipIndex]['code'],
    );
  }

  //============================================================================
  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  //================================ Parameters ==============================

  int _selectedChipIndex = 0;
//==========================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    // to create more than one line of chips if there isn't enough space
    return WhiteContainer(
      width: _mediaQuery.size.width * 0.8,
      child: SingleChildScrollView(
        child: Column(children: [
          HomeText(widgetText: 'Choose your Language'),
          Padding(
            padding: EdgeInsets.only(
              top: _mediaQuery.size.height * 0.04,
              left: _mediaQuery.size.height * 0.03,
              right: _mediaQuery.size.height * 0.025,
            ),
            child: Wrap(
              children: List.generate(
                LanguageHelper.langListMap.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: ChoiceChip(
                    backgroundColor: Colors.grey.shade100,
                    label: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        LanguageHelper.langListMap[index]['lang'],
                        style: index == _selectedChipIndex
                            ? GradientHelper.mGetSearchCardTextStyle(
                                context,
                                _mediaQuery.size.width * 0.3,
                                _mediaQuery.size.height * 0.01,
                              )
                            : Platform.isAndroid
                                ? Theme.of(context).textTheme.button.copyWith(
                                      fontSize: 15.0,
                                    )
                                : CupertinoTheme.of(context)
                                    .textTheme
                                    .tabLabelTextStyle
                                    .copyWith(
                                      fontSize: 15.0,
                                    ),
                      ),
                    ),
                    selected: index == _selectedChipIndex,
                    selectedColor: Colors.grey.shade50,
                    onSelected: (isSelected) {
                      setState(() {
                        _selectedChipIndex = isSelected ? index : 0;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              bottom: 8.0,
            ),
            child: NextArrow(
              icon: Icon(
                PlatformIcons(context).upArrow,
                size: _mediaQuery.orientation == Orientation.landscape
                    ? _mediaQuery.size.height * 0.1
                    : _mediaQuery.size.height * 0.03,
              ),
              functionHandler: () =>
                  widget.arrowFunction(context, _selectedChipIndex),
            ),
          ),
        ]),
      ),
    );
  }
}
