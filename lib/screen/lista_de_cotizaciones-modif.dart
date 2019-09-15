import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mas_divisas_app/screen/about.dart';
import 'package:mas_divisas_app/screen/list3.dart';
import 'package:mas_divisas_app/models/cotizacion.dart';
import 'package:mas_divisas_app/screen/reservarScreen.dart';
import 'package:http/http.dart' as http;
class ListaDeCotizaciones extends StatelessWidget {
  // This widget is the root of your application.
  final String usuario;
  final String cliente_id;
  final String sucursal_id;

  ListaDeCotizaciones({Key key, this.usuario, this.cliente_id, this.sucursal_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new MyHomePage(usuario: this.usuario, cliente_id: this.cliente_id, sucursal_id:this.cliente_id),
    );
  }
}
const baseUrl = "http://sd-1578096-h00001.ferozo.net/reservas/wses.php?cotizaciones=1";


class MyHomePage extends StatefulWidget {
  final String usuario;
  final String cliente_id;
  final String sucursal_id;
  const MyHomePage({Key key, this.usuario, this.cliente_id, this.sucursal_id}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState(usuario: this.usuario, cliente_id: this.cliente_id,sucursal_id: this.sucursal_id);
}
class API {
  static Future getUsers() {
    var url = baseUrl;
    return http.get(url);
  }
}


class _MyHomePageState extends State<MyHomePage> {
  final String usuario;
  final String cliente_id;
  final String sucursal_id;
  final String tyc="Caseros 521 local 6, (Paseo del Cabildo) telf.387-4222466. Horario de atención de 8.30 a 13 hs y de 16.30 a 19hs y sábados de 9 a 13 hs";
  var users = new List<Cotizacion>();
  initState() {
    super.initState();
    _getUsers();
  }
  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => Cotizacion.fromJson(model)).toList();
      });
    });
  }
  _MyHomePageState({this.usuario,this.cliente_id,this.sucursal_id});
  var icono_empresa = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/user.png')
      ]
  );
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
         // Navigator.of(context).pop();
          /*
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ReservarScreen(context)),
          );
          */
         Navigator.of(context).pop();
          Navigator.push(
          context,
          new MaterialPageRoute(
          builder: (BuildContext context) => new AboutPage()));

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Mas Divisas S.A')),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
            RaisedButton(
            padding: const EdgeInsets.all(8.0),
            elevation: 4.0,
            color: Colors.blue,
            splashColor: Colors.black,
            child:
            Text('Open route'),
    onPressed: (){
    // Navigator.of(context).pop();
    /*
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ReservarScreen(context)),
          );
          */

    Navigator.push(
    context,
    new MaterialPageRoute(
    builder: (BuildContext context) => new ReservarScreen()));

    }
    ),
          Positioned(
            bottom: 0.0,
            left: 10.0,
            right: 10.0,
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(tyc,
                        style: TextStyle(
                          fontSize: 8.0,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "Mas Divisas S.A.",
                      style: TextStyle(
                        fontSize: 6.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Raja'),
              accountEmail: new Text(this.usuario),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new AssetImage('assets/user.png'),
              ),
            ),
            new ListTile(
              title: new Text('About Page'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
