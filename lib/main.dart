import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qparattidesign/apiServices/musicApi.dart';
import 'package:qparattidesign/class_builder.dart';
import 'package:qparattidesign/home.dart';
import 'package:qparattidesign/musicplayer.dart';
import 'package:qparattidesign/videoplayer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qparattidesign/Animation/constants.dart';
import 'package:http/http.dart' as http;

void main() {
  ClassBuilder.registerClasses();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  ScanResult scanResult;
  // ignore: unused_field
  Future<MusicApi> _futureMusic;
  final _flashOnController = TextEditingController(text: "Flash on");
  final _flashOffController = TextEditingController(text: "Flash off");
  final _cancelController = TextEditingController(text: "Cancel");

  var _aspectTolerance = 0.00;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  KFDrawerController _drawerController;

  // ignore: unused_field

  _instagram() async {
    const url = 'https://www.instagram.com/paratti.design/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _facebook() async {
    const url = 'https://www.facebook.com/parattidesign1/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _whatsapp() async {
    const url =
        'https://api.whatsapp.com/send?phone=+905394373404&text=Merhaba%21';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _phoneCall() async {
    const url = "tel://05394373404";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _webSite() async {
    const url = "https://www.parattidesign.com/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('Home'),
      items: [
        KFDrawerItem.initWithPage(
          text:
              Text('Home', style: TextStyle(color: Colors.white, fontSize: 22)),
          icon: Icon(Icons.home, color: kOrangeColor),
          page: Home(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return scan();
        },

        /* onPressed: () {
            return Fluttertoast.showToast(
                msg: "Qr Kod giriş sistemin yakında ..",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP_LEFT,
                timeInSecForIosWeb: 7,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          },*/
        child: ImageIcon(AssetImage('assets/images/voicew.png'),
            size: 80, color: Colors.white),
        backgroundColor: kRedColor,
      ),
      body: KFDrawer(
          controller: _drawerController,
          header: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/voicew.png'),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    height: 80,
                    width: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
            ),
          ),
          footer: Column(
            children: [
              KFDrawerItem(
                text: Text(''),
                icon: Container(
                  width: 200,
                  child: Row(
                    children: [
                      GFIconButton(
                        onPressed: () {
                          _facebook();
                        },
                        icon: Image.asset('assets/images/facebook.png'),
                        color: Colors.transparent,
                      ),
                      Spacer(),
                      GFIconButton(
                        onPressed: () {
                          _instagram();
                        },
                        icon: Image.asset(
                          'assets/images/instagram.png',
                          color: kOrangeColor,
                        ),
                        color: Colors.transparent,
                      ),
                      Spacer(),
                      GFIconButton(
                        onPressed: () {
                          _whatsapp();
                        },
                        icon: Image.asset(
                          'assets/images/whatsapp.png',
                        ),
                        color: Colors.transparent,
                      ),
                      Spacer(),
                      GFIconButton(
                        onPressed: () {
                          _phoneCall();
                        },
                        icon: Icon(
                          Icons.phone,
                          color: kOrangeColor,
                        ),
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              KFDrawerItem(
                text: Text(
                  "www.parattidesign.com",
                  style: TextStyle(
                      fontFamily: 'Raleway', color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  _webSite();
                },
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: kRedColor,
          )),
    );
  }

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);
      String barcode = result.rawContent.toString();
      Future<void> initStatee() async {
        final url = "https://app.portalofarge.com/api/QrCode?qrCode=$barcode";
        var res = await http
            .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
        try {
          var resBody = json.decode(res.body);
          if (res.statusCode == 200) {
            if (resBody != null) {
              String link = resBody["mp3"];
              String linkLast = link.split('.').last;
              if (linkLast == "mp3") {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicPlayer(musicLink: link),
                    ));
              } else if (linkLast == "mp4") {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayer(videoLink: link),
                    ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainWidget(),
                    ));
                Fluttertoast.showToast(
                    msg: 'Not found mp3/mp4.',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM_LEFT,
                    timeInSecForIosWeb: 7,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainWidget(),
                  ));
              Fluttertoast.showToast(
                  msg: 'Not found.',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM_LEFT,
                  timeInSecForIosWeb: 7,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainWidget(),
                ));
            Fluttertoast.showToast(
                msg: 'Errors:404.',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM_LEFT,
                timeInSecForIosWeb: 7,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } catch (e) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainWidget(),
              ));
          Fluttertoast.showToast(
              msg: 'Errors:404',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM_LEFT,
              timeInSecForIosWeb: 7,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }

      setState(() {
        scanResult = result;
        initStatee();
      });
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }
}
