import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeaningItem extends StatelessWidget {
  //================================ Parameters ================================
  final meaningElement;
  final String word;
  //================================ Constructor ===============================
  const MeaningItem({
    Key key,
    @required this.meaningElement,
    this.word,
  }) : super(key: key);
  //================================Methods=====================================
  // changing the style of the word programatically
  List<TextSpan> _getSpans(String text, String matchWord, TextStyle style) {
    List<TextSpan> spans = [];
    int spanBoundary = 0;

    do {
      // look for the next match
      final startIndex = text.indexOf(matchWord, spanBoundary);

      // if no more matches then add the rest of the string without style
      if (startIndex == -1) {
        spans.add(TextSpan(text: text.substring(spanBoundary)));
        return spans;
      }

      // add any unstyled text before the next match
      if (startIndex > spanBoundary) {
        spans.add(TextSpan(text: text.substring(spanBoundary, startIndex)));
      }

      // style the matched text
      final endIndex = startIndex + matchWord.length;
      final spanText = text.substring(startIndex, endIndex);
      spans.add(TextSpan(text: spanText, style: style));

      // mark the boundary to start the next search from
      spanBoundary = endIndex;

      // continue until there are no more matches
    } while (spanBoundary < text.length);

    return spans;
  }

  //==========================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final TextStyle textStyle = Platform.isAndroid
        ? Theme.of(context).textTheme.headline2.copyWith(
              fontSize: 16.0,
            )
        : CupertinoTheme.of(context).textTheme.tabLabelTextStyle.copyWith(
              fontSize: 16.0,
            );

    final spans = _getSpans(
      meaningElement,
      word,
      textStyle.copyWith(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
    //==========================================================================
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 5.0,
      ),
      child: Row(
        children: [
          Icon(
            Icons.lens,
            size: 10.0,
            color: Color(0xFF8C2480),
          ),
          SizedBox(width: _mediaQuery.size.width * 0.04),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              padding: EdgeInsets.all(_mediaQuery.size.width * 0.03),
              child: RichText(
                text: TextSpan(
                  style: textStyle,
                  children: spans,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
