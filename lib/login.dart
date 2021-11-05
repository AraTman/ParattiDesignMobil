import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:qparattidesign/Animation/FadeAnimation.dart';
import 'package:qparattidesign/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// ignore: must_be_immutable
class Login extends KFDrawerContent {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String isim = "";
  String sifre = "";
  bool _isLoading = false;
  signIn(String username, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'grant_type': 'password',
      'username': username,
      'password': password,
    };
    var jsonResponse;
    var response = await http.post("https://mobilapi.athleteanalysis.com/Token",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        sharedPreferences.setBool("durum", true);
        sharedPreferences.setInt("kayitno", 1);
        sharedPreferences.setString(
            "access_token", jsonResponse['access_token']);
        sharedPreferences.setString(
            "username", kuladiController.text.toString());
        sharedPreferences.setString(
            "password", sifreController.text.toString());
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
        return Fluttertoast.showToast(
            msg: 'Hoşgeldiniz.',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 7,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      setState(() {
        _isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
      });
      return Fluttertoast.showToast(
          msg: "Hatalı kullanıcı adı veya şifre",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 7,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    super.initState();
    kayitlikayit();
  }

  void kayitlikayit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String kadi = sharedPreferences.getString("username");
    String ksifre = sharedPreferences.getString("password");
    if (kadi != "" && ksifre != "") {
      if (kadi != null && ksifre != null) {
        setState(() {
          isim = kadi;
          sifre = ksifre;
        });

        Map data = {
          'grant_type': 'password',
          'username': kadi,
          'password': ksifre,
        };
        var jsonResponse;
        var response =
            await http.post("https://mobilapi.athleteanalysis.com/Token",
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: data);
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          sharedPreferences.setString(
              "access_token", jsonResponse['access_token']);
          if (jsonResponse != null) {
            setState(() {
              _isLoading = false;
            });

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) => Home()),
                (Route<dynamic> route) => false);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.blueGrey[100],
            child: _isLoading
                ? Center(
                    heightFactor: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.amberAccent,
                    ))
                : Column(
                    children: <Widget>[
                      Container(
                        height: 380,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(108.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/logo.png'),
                                      fit: BoxFit.fill)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            FadeAnimation(
                                1.8,
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[100]))),
                                        child: TextFormField(
                                          controller: kuladiController,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.person_pin,
                                                  color: Colors.black),
                                              border: InputBorder.none,
                                              hintText: "Kullanıcı Adı",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400])),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: sifreController,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.lock,
                                                  color: Colors.black),
                                              border: InputBorder.none,
                                              hintText: "Şifre",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400])),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            FadeAnimation(
                                2,
                                Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: RaisedButton(
                                    color: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      signIn(kuladiController.text,
                                          sifreController.text);
                                    },
                                    child: Text(
                                      "Giriş",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 70,
                            ),
                            FadeAnimation(
                                1.5,
                                Text(
                                  "Athlete Analysis",
                                  style: TextStyle(
                                      color: Color.fromRGBO(248, 151, 29, .6)),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ));
  }
}

final kuladiController = new TextEditingController();
final sifreController = new TextEditingController();
