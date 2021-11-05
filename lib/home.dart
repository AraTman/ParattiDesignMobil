import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:qparattidesign/Animation/constants.dart';

// ignore: must_be_immutable
class Home extends KFDrawerContent {
  Home({
    Key key,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String barcode = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: kRedColor,
                        ),
                        onPressed: widget.onMenuPressed,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 85,
                    child: Center(
                        child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover),
                      ),
                    )),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 170,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/voicered.png'),
                                  fit: BoxFit.cover)),
                        ),
                        Center(
                          child: Container(
                            height: 90,
                            width: 286,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/logoblack.png'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
    //scan barcode asynchronously
  }
}
