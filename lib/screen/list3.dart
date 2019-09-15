import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mas_divisas_app/models/cotizacion.dart';
import 'package:mas_divisas_app/models/listpost.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mas_divisas_app/screen/reservarScreen2.dart';
class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();

}
const baseUrl = "http://sd-1578096-h00001.ferozo.net/reservas/wses.php?cotizaciones=1";

class API {
  static Future getUsers() {
    var url = baseUrl;
    return http.get(url);
  }
}
//--------------------------------------------------------------
TextEditingController _textFieldController = TextEditingController();

_displayDialog(BuildContext context) async {
  String compra='45';
  String venta='46';
  return showDialog(
      context: context,
      builder: (context) {
        var _radioValue1;
          return AlertDialog(
          title: Text('TextField in Dialog'),
          content:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Tipos:"),
          new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text("Compra:\$"+compra),
              Radio(
                value: 0,
                groupValue: _radioValue1,
              ),

          ]),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text("Venta:\$"+venta),
                    Radio(
                      value: 1,
                      groupValue: _radioValue1,

                    ),
                  ]),
              Text("\$ 100"),
          TextField(
            controller: _textFieldController,
            maxLength: 5,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "TextField in Dialog"),
          ),
          ]),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
//--------------------------------------------------------------------------
Widget _buildAboutDialog(BuildContext context,String  tipo_moneda, String compra,String venta) {
  List<String> _countrycodes = ["+65", "+91"];
  List<String> _colors = ['', 'red', 'green', 'blue', 'orange'];
  var controller = new MaskedTextController(mask: '000.000.000-00');
  String _selectedCountryCode;
  String _color = '';
  int _radioValue1 = 1;


  final  countryCode = DropdownButton(
    value: _selectedCountryCode,
    items: _countrycodes
        .map((code) =>
    new DropdownMenuItem(value: code, child: new Text(code)))
        .toList(),
    onChanged: null,
  );
  return new AlertDialog(
    title:  Text(tipo_moneda),
    content:
    Container(
    height: 400,
    width: 600,
    child: Padding(
    padding: EdgeInsets.all(0.0),
    child:
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Tipos:"),
        Text("Compra:\$"+compra),
         Radio(
          value: 0,
          groupValue: _radioValue1,
        ),
        Text("Venta:\$"+venta),
         Radio(
          value: 1,
          groupValue: _radioValue1,

        ),
        Text("Valor "+tipo_moneda ),

    new Container(
      width: 100.0,
      child:
    Padding(padding: EdgeInsets.all(20.0),
        child:
        TextField(controller: controller,
          maxLines: 1,
          maxLength: 5,

          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: new TextStyle( fontSize: 15.0),
          decoration: new InputDecoration(hintText: "0.0", contentPadding: const EdgeInsets.all(40.0)),
          onChanged: (text) {
          print("First text field: $text");
        },) ),),
      ],
    ),)),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Aceptar'),
      ),
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Cancelar'),
      ),
    ],
    
  );
}

Widget  _boton(BuildContext context, String id_cotizacion,String tipo_moneda, String compra, String venta ){
  return RaisedButton(
    padding: const EdgeInsets.all(8.0),
    elevation: 4.0,
    color: Colors.blue,
    splashColor: Colors.black,
    child:
    Container(
        color: Colors.black,
        child:
        Row(
            crossAxisAlignment: CrossAxisAlignment.center ,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const  Text("Reservar",style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white

              )),
              Icon(Icons.play_arrow, color: Colors.white,),
            ])),
      onPressed: (){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReservarScreen()),
        );
      }
  );
}
Widget _dinero(String moneda,String compra, String venta) {
  return

    Container(
      margin: EdgeInsets.symmetric(vertical: 40.0),
  child:
    Padding(
      padding: const EdgeInsets.all(0.0),
      child:  Column(
        children: <Widget>[
          Text(moneda ,
              style: TextStyle(fontSize: 18))
          ,new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Compra',
                style: TextStyle(fontSize: 15 , height: 3),),
              VerticalDivider(),
              Text(compra,
                style: TextStyle(fontSize: 15, height: 3),),
              VerticalDivider(),
              Text('Venta',
                style: TextStyle(fontSize: 15, height: 3),),
              VerticalDivider(),
              Text(venta,
                style: TextStyle(fontSize: 15, height: 3),),
            ],
          ),
        ],
      ),
    )

    );
}
class _MyListScreenState extends State {
  var users = new List<Cotizacion>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => Cotizacion.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cotizaciones del Dia"),
        ),
        body:Stack(children: <Widget>[
        Container(
        decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/fondo.png'),
              fit: BoxFit.fitHeight,
            ),
            ),
            ),

          ListView.builder(
          itemCount: users.length,
          padding: const EdgeInsets.all(30.0),
          itemBuilder: (context, index) {
           // if( users[index].sucursal_id.toString().ec == '1')
              return Card(
                  child: ListTile(
                    title: IntrinsicHeight( child: _dinero(users[index].moneda,users[index].cotizacion_compra, users[index].cotizacion_venta),)
                    , subtitle: Container( color: Colors.black,  child:  _boton(context,users[index].id_cotizaciones,users[index].moneda, users[index].cotizacion_compra,users[index].cotizacion_venta )),
                  )
              );
           // else return null;
          },

        ) ]
     )
    );

  }
}