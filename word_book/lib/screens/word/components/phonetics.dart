import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../helpers/gradient_helper.dart';
import '../../../widgets/white_container.dart';
import './phonetics_row.dart';

class Phonetics extends StatelessWidget {
  //================================ Parameters ================================
  final List _phoneticsList;
  final AudioPlayer _audioPlayer = AudioPlayer();
  //================================ Constructor ===============================
  Phonetics({
    Key key,
    @required List phoneticsList,
  })  : _phoneticsList = phoneticsList,
        super(key: key);
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
      height: _mediaQuery.size.height * 0.1 +
          _mediaQuery.size.height * 0.09 * _phoneticsList.length,
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
          (_phoneticsList[0] == null)
              ? Text('No Data.')
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: _phoneticsList.length,
                    itemBuilder: (_, index) => PhoneticsRow(
                      audioPlayer: _audioPlayer,
                      phoneticsText: _phoneticsList[index]['text'],
                      phoneticsAudio: _phoneticsList[index]['audio'],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
