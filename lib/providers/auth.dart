import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_shop/exceptions/auth_expection.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;

  String get userId => _userId;
  String get token => _token;

  static const _signUpUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAKj4iF5ujbG99wE8auoQTChwMaEjBXcnY";
  static const _signInUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAKj4iF5ujbG99wE8auoQTChwMaEjBXcnY";
  
  Future<bool> signUp(String email,String password) async{
    try {
      final response = await http.post(_signUpUrl,body: json.encode({
      'email' : email,
      'password': password,
      'returnSecureToken' : true
    }));
    final decodedResponse = json.decode(response.body);
      print(decodedResponse);
  
      if(response.statusCode >=400 ){
        throw AuthException(decodedResponse['message']);
      }
       _token = decodedResponse['idToken'];
       _userId = decodedResponse['localId'];
      return true;
    }catch(e){
      return false;
    }
  }

  Future<String> signIn(String email,String password) async{
    try {
      final response = await http.post(_signInUrl,body: json.encode({
      'email' : email,
      'password': password,
      'returnSecureToken' : true
    }));
    final decodedResponse = json.decode(response.body);  
      if(response.statusCode >=400 ){
        return AuthException(decodedResponse['error']['message']).toString();
      }
       
        _token = decodedResponse['idToken'];
        _userId = decodedResponse['localId'];
      return null;
      
     
    }catch(e){
      return AuthException('NETWORK_ERROR').toString();
    }
  }
}