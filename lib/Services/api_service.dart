import 'dart:convert';

import 'package:dictionary_app/Model/drctionary_model.dart';
import 'package:http/http.dart' as http;

 class ApiService {
 static String baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';
 static Future<DictionaryModel?> fetchData(String word) async{
    Uri url = Uri.parse("$baseUrl$word");
    final response = await http.get(url);
    try {
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        return DictionaryModel.fromJson(data[0]);
      }
      else{
        throw Exception("Unable to load data");
      }
    } catch (e) {
      print(e.toString());
      
    }

  }

}