import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';

import '../../widgets/back_arrow.dart';
import '../../helpers/gradient_helper.dart';
import '../../helpers/words_helper.dart';
import './components/phonetics.dart';
import './components/meanings.dart';
import './components/loading_indicator.dart';
import './components/something_went_wrong.dart';

class WordScreen extends StatefulWidget {
  //================================ Parameters ================================
  static const String routeName = '/word';
  //================================ Constructor ===============================
  WordScreen({
    Key key,
  }) : super(key: key);
  //============================================================================

  @override
  _WordScreenState createState() => _WordScreenState();
}

//============================================================================
class _WordScreenState extends State<WordScreen> with TickerProviderStateMixin {
  //================================ Parameters ================================
  dynamic _apiResults;
  // to show the word in the meaning screen
  String _word;

  // to show the loading indicator
  bool _isLoading = false;
  // to handle the response of the api.
  List<String> _hasErrors = [];
  // to save the lists
  List<dynamic> _phoneticsList = [];
  List<dynamic> _meaningsList = [];
  //============================== Methods =====================================
  void _onSumbitFunction(String word, String _lang) async {
    try {
      // remove old problems
      _hasErrors = [];
      // check if empty word
      if (word == '')
        throw PlatformException(code: 'Not the same language, bro.');
      // try to translate the word to get its source language, to check if it
      // matches the original language selection
      final GoogleTranslator translator = GoogleTranslator();
      Translation x = await translator.translate(word, to: _lang);

      if (_lang != x.sourceLanguage.code && x.sourceLanguage.code != 'auto')
        throw PlatformException(code: 'Not the same language, bro.');

      // check the input before calling the api
      if (word.isEmpty || word.contains(new RegExp(r'[^A-Za-z]')))
        throw PlatformException(code: 'Not the same language, bro.');
      // == = = = = == = = = = = === = = == == = == = = = == =
      // call the api from it's wordhelper file and receive the
      // check if the user submitted the same word again
      if (word == _word && _apiResults != null) return null;
      setState(() {
        _isLoading = true;
      });
      _apiResults = await WordHelper.mGetWordInfo(_lang, word);
      setState(() {
        _word = word;
        _isLoading = false;
        _hasErrors = [];
      });
    } catch (e) {
      print(
        'error @ calling api from word screen,error message : ${e.runtimeType}',
      );

      setState(() {
        _apiResults = null;
        switch (e.runtimeType) {
          case SocketException:
            _hasErrors.add('Please check your connection.');
            break;
          case PlatformException:
            _hasErrors.add('Please check your input(s).');
            break;
          default:
            _hasErrors.add('Please try again.');
        }
      });
    }
  }

  //============================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    // to adjust the api calling url
    final String _lang = ModalRoute.of(context).settings.arguments;
    try {
      // fill in the data
      if (_apiResults != null) {
        _phoneticsList = _apiResults[0];
        // remove any duplicaiton in _phonetics
        List<int> _deletionList = [];
        for (var i = 0; i < _phoneticsList.length - 1; i++) {
          if (_phoneticsList[i]['audio'] == _phoneticsList[i + 1]['audio'])
            _deletionList.add(i + 1);
        }
        _deletionList.reversed.forEach((index) {
          _phoneticsList.removeAt(index);
        });
        // ==============================
        _meaningsList = _apiResults[1];
        // put all the same meaning category in the same lsit
        // put all nouns together, all verbs together , etc.
        Map<dynamic, dynamic> typesMap = {}; // {'nouns' : 0 , 'verbs' : 1}
        List<dynamic> result = []; // [[nouns],[verbs],[adj]]
        _meaningsList.forEach((element) {
          // check if I have seen that type before
          if (typesMap.containsKey(element['partOfSpeech'])) {
            // yes, get the list index from the map and add it there
            result[typesMap[element['partOfSpeech']]].add(element);
          } else {
            // never seen that element before in my life, create a new list
            result.add([element]);
            // update the map
            typesMap.addAll({element['partOfSpeech']: typesMap.length});
          }
        });
        _meaningsList = result;
      }
    } catch (e) {
      print('error @ wordScreen while splitting the meaning/phonetics list');
      print(e);
    }
    // print(_phoneticsList[0]);
    //==========================================================================
    return Scaffold(
      body: Container(
          height: _mediaQuery.size.height,
          width: _mediaQuery.size.width,
          decoration: BoxDecoration(
            gradient: GradientHelper.linearGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: _mediaQuery.size.height * 0.03,
                ),
                BackArrow(),
                Container(
                  alignment: Alignment.center,
                  height: _mediaQuery.size.height * 0.08,
                  width: _mediaQuery.size.width * 0.92,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    style: GradientHelper.mGetSearchCardTextStyle(
                      context,
                      _mediaQuery.size.width * 0.12,
                      _mediaQuery.size.height * 0.005,
                    ),
                    cursorColor: Colors.black,
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a word',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // what to do once the word is written and user pressed next
                    onSubmitted: (word) =>
                        _onSumbitFunction(word.trim(), _lang),
                    // what to do if the user changes the word
                    onChanged: (_) {
                      setState(() {
                        _apiResults = null;
                        _hasErrors = [];
                        _isLoading = false;
                      });
                    },
                  ),
                ),
                if (_hasErrors.length > 0)
                  SomethingWentWrong(message: _hasErrors[0]),
                if (_isLoading && _hasErrors.length == 0) LoadingIndicator(),
                if (_apiResults != null && _hasErrors.length == 0)
                  Phonetics(phoneticsList: _phoneticsList, word: _word),
                if (_isLoading && _hasErrors.length == 0) LoadingIndicator(),
                if (_apiResults != null && _hasErrors.length == 0)
                  Meanings(
                    meaningsList: _meaningsList,
                    word: _word,
                    phoneticsListLength: _phoneticsList.length,
                  ),
                SizedBox(
                  height: _mediaQuery.size.height * 0.05,
                ),
              ],
            ),
          )),
    );
  }
}
