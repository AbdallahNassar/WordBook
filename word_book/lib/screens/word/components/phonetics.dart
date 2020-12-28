import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../screens/word/components/no_data_text.dart';
import '../../../helpers/gradient_helper.dart';
import '../../../widgets/white_container.dart';
import './phonetics_row.dart';

class Phonetics extends StatelessWidget {
  //================================ Parameters ================================
  final List phoneticsList;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String word;
  //================================ Constructor ===============================
  Phonetics({
    Key key,
    @required this.phoneticsList,
    @required this.word,
  }) : super(key: key);
  //============================================================================

  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return WhiteContainer(
      constraints: BoxConstraints(
        maxHeight: _mediaQuery.size.height * 0.33,
      ),
      margin: EdgeInsets.symmetric(
        vertical: _mediaQuery.size.height * 0.01,
      ),
      height: _mediaQuery.size.height * 0.12 +
          _mediaQuery.size.height * 0.12 * phoneticsList.length,
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
              'Phonetics',
              style: GradientHelper.mGetSearchCardTextStyle(
                context,
                _mediaQuery.size.width * 0.12,
                _mediaQuery.size.height * 0.005,
              ).copyWith(
                fontSize: 20.0,
              ),
            ),
          ),
          (phoneticsList.length == 0 || phoneticsList[0] == null)
              ? NoDataText()
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: phoneticsList.length,
                    itemBuilder: (_, index) => PhoneticsRow(
                      audioPlayer: _audioPlayer,
                      phoneticsText: word,
                      phoneticsAudio: phoneticsList[index]['audio'],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
