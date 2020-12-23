import 'dart:convert';

import 'package:http/http.dart' as http;

// here i'll handle the words api
class WordHelper {
  // this function will call the api, receive the response, and send it to
  // the calling widget/file, it needs to by async cause http
  static Future<dynamic> mGetWordInfo(String langCode, String word) async {
    // setup the api url
    final String _url =
        'https://api.dictionaryapi.dev/api/v2/entries/$langCode/$word';
    try {
      // send the get request to the api
      final _response = await http.get(_url);
      // decode the response
      final dynamic _jsonResponse = json.decode(_response.body);
      // extract all the relavent information.
      dynamic _phoneticsList = [];
      dynamic _meaningsList = [];
      _jsonResponse.forEach((element) {
        _phoneticsList.addAll(element['phonetics']);
        _meaningsList.addAll(element['meanings']);
      });
      dynamic _result = [];
      _result.add(_phoneticsList);
      _result.add(_meaningsList);
      return _result;
    } catch (e) {
      print('Error @ word Api = $e');
      throw e;
    }
  }
}
