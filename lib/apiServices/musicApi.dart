import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<MusicApi> fetchMusic(String barcode) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var jsonResponse;
  final http.Response response = await http.get(
    'https://local/api/QrCode?qrCode=$barcode',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body);
    sharedPreferences.setString("Mp3", jsonResponse['mp3']);
    return MusicApi.fromJson(jsonDecode(response.body));
  } else {
    throw Text('');
  }
}

class MusicApi {
  final String qrCode;

  MusicApi({this.qrCode});

  factory MusicApi.fromJson(Map<String, dynamic> json) {
    return MusicApi(
      qrCode: json['Mp3'],
    );
  }
}
