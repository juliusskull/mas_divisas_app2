import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mas_divisas_app/models/cotizacion.dart';
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
//--------------------------------------------------------------------------

Widget  _boton(BuildContext context, String idCotizacion,String tipoMoneda, String compra, String venta ){
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
                    title: IntrinsicHeight( child: _dinero(users[index].moneda,users[index].cotizacionCompra, users[index].cotizacionVenta),)
                    , subtitle: Container( color: Colors.black,  child:  _boton(context,users[index].idCotizaciones,users[index].moneda, users[index].cotizacionCompra,users[index].cotizacionVenta )),
                  )
              );
           // else return null;
          },

        ) ]
     )
    );

  }
}