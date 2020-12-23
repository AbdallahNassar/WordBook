import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/gradient_helper.dart';
import '../../../widgets/white_container.dart';
import './meaning_item.dart';

class MeaningContainer extends StatelessWidget {
  //================================ Parameters ================================
  final list;
  final text;
  // the word iam searching for
  final String word;
  //================================ Constructor ===============================
  const MeaningContainer({
    Key key,
    @required this.list,
    @required this.word,
    @required this.text,
  }) : super(key: key);
  //============================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return WhiteContainer(
      height: _mediaQuery.size.height * 0.2,
      width: _mediaQuery.size.width * 0.92,
      padding: EdgeInsets.only(
        right: _mediaQuery.size.height * 0.01,
        left: _mediaQuery.size.height * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: _mediaQuery.size.height * 0.016,
              right: _mediaQuery.size.height * 0.015,
              left: _mediaQuery.size.height * 0.015,
              bottom: _mediaQuery.size.height * 0.01,
            ),
            child: Text(
              text,
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
              padding: const EdgeInsets.all(
                0.0,
              ),
              itemCount: list.length,
              itemBuilder: (_, index) =>
                  MeaningItem(meaningElement: list[index], word: word),
            ),
          ),
        ],
      ),
    );
  }
}
