import 'package:flutter/material.dart';

import '../../../widgets/white_container.dart';
import '../../../helpers/gradient_helper.dart';
import './meanings_row.dart';

class Meanings extends StatelessWidget {
  //================================ Parameters ================================
  final List meaningsList;
  final String word;
  final int phoneticsListLength;
  //================================ Constructor ===============================
  const Meanings({
    Key key,
    @required this.meaningsList,
    @required this.word,
    @required this.phoneticsListLength,
  }) : super(key: key);
  //============================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return WhiteContainer(
      constraints: BoxConstraints(
        maxHeight: phoneticsListLength == 1
            ? _mediaQuery.size.height * 0.54
            : _mediaQuery.size.height * 0.37,
      ),
      margin: EdgeInsets.symmetric(
        vertical: _mediaQuery.size.height * 0.005,
      ),
      height: _mediaQuery.size.height * 0.08 +
          _mediaQuery.size.height * 0.13 * meaningsList.length,
      width: _mediaQuery.size.width * 0.92,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: _mediaQuery.size.height * 0.02,
              right: _mediaQuery.size.height * 0.015,
              left: _mediaQuery.size.height * 0.015,
              bottom: _mediaQuery.size.height * 0.02,
            ),
            child: Text(
              'Meanings',
              style: GradientHelper.mGetSearchCardTextStyle(
                context,
                _mediaQuery.size.width * 0.12,
                _mediaQuery.size.height * 0.005,
              ).copyWith(
                fontSize: 20.0,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: meaningsList.length,
              itemBuilder: (_, index) => WordMeaningCard(
                meaningCategoryList: meaningsList[index],
                word: word,
              ),
            ),
            // child: MeaningItem(meaningsList: _meaningsList, mediaQuery: _mediaQuery),
          ),
        ],
      ),
    );
  }
}
