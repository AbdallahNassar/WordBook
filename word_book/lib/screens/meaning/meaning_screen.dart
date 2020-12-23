import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../widgets/back_arrow.dart';
import '../../screens/meaning/components/meaning_container.dart';
import '../../helpers/gradient_helper.dart';

class MeaningScreen extends StatelessWidget {
  //================================ Parameters ================================
  static const String routeName = '/meaning';
  final List<dynamic> meaningCategoryList;
  final String word;
  final id;
  //================================ Constructor ===============================
  const MeaningScreen({
    Key key,
    this.meaningCategoryList,
    this.word,
    this.id,
  }) : super(key: key);
  //============================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    // Extracting the three lists from the main list.
    var _definitionsList = [];
    var _examplesList = [];
    var _synomymsList = [];
    meaningCategoryList.forEach((element) {
      element['definitions'].forEach((meaningData) {
        if (meaningData['definition'] != null)
          _definitionsList.add(meaningData['definition']);
        if (meaningData['example'] != null)
          _examplesList.add(meaningData['example']);
        if (meaningData['synomyms'] != null)
          _synomymsList.add(meaningData['synomyms']);
      });
    });

    //==========================================================================
    return PlatformScaffold(
      body: Container(
        height: _mediaQuery.size.height,
        width: _mediaQuery.size.width,
        decoration: BoxDecoration(
          gradient: GradientHelper.linearGradient,
        ),
        child: Column(
          children: [
            Row(
              children: [
                BackArrow(),
                Hero(
                  tag: id,
                  child: Container(
                    width: _mediaQuery.size.width * 0.7,
                    height: _mediaQuery.size.height * 0.1,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      word == null ? '' : word,
                      style: Platform.isIOS
                          ? CupertinoTheme.of(context)
                              .textTheme
                              .navLargeTitleTextStyle
                              .copyWith(
                                color: Colors.white,
                                fontSize: 30,
                              )
                          : Theme.of(context).textTheme.headline1.copyWith(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: _mediaQuery.size.height * 0.82,
                  width: _mediaQuery.size.width * 0.94,
                  child: Column(
                    children: [
                      if (_definitionsList.length > 0)
                        Expanded(
                          child: MeaningContainer(
                            list: _definitionsList,
                            text: 'Definitions',
                            word: word,
                          ),
                        ),
                      if (_examplesList.length > 0)
                        Expanded(
                          child: MeaningContainer(
                            list: _examplesList,
                            text: 'Examples',
                            word: word,
                          ),
                        ),
                      if (_synomymsList.length > 0)
                        Expanded(
                          child: MeaningContainer(
                            list: _synomymsList,
                            text: 'Synomyms',
                            word: word,
                          ),
                        ),
                      // to adjust the heght of the containers if there's only
                      // 2 containers and each only has 1 item.
                      if (_synomymsList.length == 0 &&
                          _definitionsList.length == 1 &&
                          _examplesList.length == 1)
                        Expanded(
                          child: Text(''),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
