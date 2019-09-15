import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
@override
_AboutPageState createState() => new _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  void buttonPressed(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
      appBar: new AppBar(
      title: new Text('About Page'),
      ),
      body:
      new Container(
          child: new RaisedButton(key:null, onPressed:buttonPressed,
              color: Colors.black,
              textColor: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.check, color: Colors.white,),
                  new Text(
                    "Volver",
                    style: new TextStyle(
                        fontSize:20.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Roboto"
                    ),
                  ),

                ],

              )
          )
      )
    );
  }
}