import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PhoneticsRow extends StatelessWidget {
  //================================ Parameters ================================
  final String phoneticsText;
  final AudioPlayer audioPlayer;
  final String phoneticsAudio;
  //================================ Constructor ===============================
  const PhoneticsRow({
    Key key,
    @required this.phoneticsText,
    @required this.phoneticsAudio,
    @required this.audioPlayer,
  }) : super(key: key);
  //============================================================================

  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
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
        title: Container(
          alignment: Alignment.topLeft,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              (phoneticsText),
              style: Platform.isAndroid
                  ? Theme.of(context).textTheme.headline2
                  : CupertinoTheme.of(context).textTheme.tabLabelTextStyle,
            ),
          ),
        ),
        trailing: PlatformIconButton(
          onPressed: () async {
            int _ = await audioPlayer.stop();
            int result = await audioPlayer.play(
              phoneticsAudio,
              respectSilence: false,
            );
            if (result == 1) {
            } else {
              print('error fetching audio data');
            }
          },
          icon: Icon(
            PlatformIcons(context).volumnnUp,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
    );
  }
}
