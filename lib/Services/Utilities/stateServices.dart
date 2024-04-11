import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../../Model/WorldStatesModel.dart';
import 'appurls.dart';
class StateServices{
   Future<WorldStatesModel> fetchWorldStatesRecord()async{
   final  response=await http.get(Uri.parse(ApiUrls.WorldStateApi));
   if(response.statusCode==200){
     var data=jsonDecode(response.body);
     return WorldStatesModel.fromJson(data);
   }else{
     throw Exception('error was found');
   }
  }
   Future<List<dynamic>>countriesListApi()async{
     final response=await http.get(Uri.parse(ApiUrls.countriesList));
     if(response.statusCode==200){
       var data=jsonDecode(response.body);
       return data;
     }else{
       throw Exception('error was found');
     }
  }
}