import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mas_divisas_app/models/cotizacion.dart';
class ReservarScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Reservas',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currVal = 1;
  double _radioValue = 0;
  @override
  void initState() {
    setState(() {
      _radioValue = .5;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Reservas'),
      ),
      body:
      new Container(

        child:
        new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Text(
                "Dolar Estadounidense",
                style: new TextStyle(
                    fontSize:19.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w900,
                    fontFamily: "Roboto"),
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Radio(key:null, groupValue: _radioValue
                        , value: .5, onChanged: radioChanged),

                    new Text(
                      "Te Vendemos a \$0.06500",
                      style: new TextStyle(
                          fontSize:11.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w900,
                          fontFamily: "Roboto"),
                    ),

                  ]

              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Radio(key:null, groupValue: _radioValue, value: .15, onChanged: radioChanged),

                    new Text(
                      "Te Compramos a \$0.06500",
                      style: new TextStyle(
                          fontSize:11.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w900,
                          fontFamily: "Roboto"),
                    ),


                  ]

              ),

              new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Valor en Pesos:",
                      style: new TextStyle(
                          fontSize:15.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w900,
                          fontFamily: "Roboto"),
                    ),
                    new Text(
                      "100000.00",
                      style: new TextStyle(
                          fontSize:15.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w900,
                          fontFamily: "Roboto"),
                    )
                  ]

              ),

              new TextField(
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    hintText: '0.00',
                    helperText: 'Agregue el valor en la moneda extranjera',
                    labelText: 'Valor',
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      color: Colors.black,
                    ),
                    prefixText: ' ',
                    suffixText: 'PESO CHILENO',
                    suffixStyle: const TextStyle(color: Colors.black)),
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(key:null, onPressed:(){    Navigator.pop(context);
                    },
                        color: const Color(0xFFe0e0e0),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child:
                        new Text(
                          "Cancelar",
                          style: new TextStyle(
                              fontSize:20.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w900,
                              fontFamily: "Roboto"),
                        )
                    ),

                    new RaisedButton(key:null, onPressed:buttonPressed,
                        color: Colors.black,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: <Widget>[
                              Icon(Icons.check, color: Colors.white,),
                              new Text(
                                "Reservar",
                                style: new TextStyle(
                                    fontSize:20.0,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Roboto"
                                ),
                              ),

                            ],

                    )
                    ),
                  ]

              ),
              /*
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
              )
              */
            ]

        ),

        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,

      ),

    );
  }
  void buttonPressed(){

  }


  void radioChanged(double value) {
    print("ckech:"+ value.toString());
    setState(() {
      _radioValue = value;
    });
  }

}
