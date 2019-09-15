import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mas_divisas_app/models/sucursal.dart';
//Pages
import './about.dart';
import 'package:mas_divisas_app/screen/lista_de_cotizaciones.dart';
import 'package:mas_divisas_app/screen/listaDePedidosScreen.dart';
import 'package:mas_divisas_app/screen/loginScreen.dart';
class Ppal extends StatelessWidget {
  // This widget is the root of your application.
  final String usuario;
  final String cliente_id;
  Ppal({Key key, this.usuario, this.cliente_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new MyHomePage(usuario: this.usuario, cliente_id: this.cliente_id),
    );
  }
}


class MyHomePage extends StatefulWidget {
  final String usuario;
  final String cliente_id;
  const MyHomePage({Key key, this.usuario, this.cliente_id}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState(usuario: this.usuario, cliente_id: this.cliente_id);
}
class API {
  static Future getUsers(baseUrl ) {
    var url = baseUrl;
    return http.get(url);
  }
}
class _MyHomePageState extends State<MyHomePage> {
  final String baseUrl = "http://sd-1578096-h00001.ferozo.net/reservas/wses.php?sucursales=1";
  final String usuario;
  final String cliente_id;
  final String tyc="Mediante esta aplicación, podrás reservar una  una operación de  compra-venta de moneda "
  + "extranjera. Realizada la reserva, la operación se concreta en una de nuestras agencias."
  +"La reserva es válida por 3 horas.  El precio de reserva se mantendrá si el mismo no varía en más o en menos 1%."
  +"Si superase ese límite, la operación se ajustará según la variación producida. "
  +"Recuerde que Usted está realizando una realizando una reserva y no concretando una operación "
  +"Por cualquier duda o inquietud, consulte personalmente con nosotros, será tratado con la mayor discreción. "
  +"Las reservas realizadas por esta aplicación tienen una atención personalizada";
  var users = new List<Sucursal>();
  _MyHomePageState({this.usuario,this.cliente_id});
  var icono_empresa = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/user.png')
      ]
  );

  _getUsers() {
    API.getUsers(baseUrl).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users= list.map((model) => Sucursal.fromJson(model)).toList();


      });
    });
  }
  initState() {
    super.initState();
    _getUsers();
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
          Positioned(
            top: 0,
            left: 10.0,
            right: 10.0,
              child: Image.asset('assets/user.png')
          ),
          Positioned(
              top: 240,
              left: 10.0,
              right: 10.0,
              child: Text("Seleccione Sucursal", style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
              ),
              )
          ),
          Material(color: Colors.yellowAccent),

          Positioned(
              top: 260.0,
              left: 10.0,
              right: 10.0,

              child:

              new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                elevation: 4.0,
                color: Colors.blue,
                splashColor: Colors.blueGrey,
                child:
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center ,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                const  Text("SALTA",style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                   color: Colors.white
                )),
                      Icon(Icons.play_arrow, color: Colors.white,),
                ]),
              onPressed: () {
               // Navigator.of(context).pop();

                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ListaDeCotizaciones(usuario: this.usuario,cliente_id: this.cliente_id, sucursal_id: '1',)));

              },
              )
          ),

          Positioned(
            bottom: 48.0,
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
                    padding: const EdgeInsets.all(16.0),
                    child: Text(tyc,
                        style: TextStyle(
                        fontSize: 8.0,
                        fontWeight: FontWeight.bold,
                    )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
              /*accountName: new Text('error'),*/
              accountEmail:new Text(this.usuario) ,
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new AssetImage('assets/user.png'),
              ),
            ),
            new ListTile(
              title: new Text('About Page'),
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
            ),
            new ListTile(
              title: new Text('Lista de Reservas'),
              onTap: () {
                //Navigator.of(context).pop();

                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ListaDePedidosScreen(usuario:this.usuario,cliente_id:this.cliente_id)));

                },
            ),
            new ListTile(
              title: new Text('Logout'),
              onTap: () {
                //Navigator.of(context).pop();

                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new LoginScreen()));

              },
            ),
          ],
        ),
      ),
    );
  }
}