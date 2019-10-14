import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mas_divisas_app/models/reserva.dart';

import 'package:http/http.dart' as http;


class ListaDePedidosScreen extends StatefulWidget {
  final String usuario;
  final String cliente_id;

   ListaDePedidosScreen({Key key, this.usuario, this.cliente_id}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState(usuario: this.usuario, cliente_id: this.cliente_id);
}
const baseUrl = "http://sd-1578096-h00001.ferozo.net/reservas/wses.php?select-reservas-imagenes=";
class API {
  static Future getUsers(String s) {
    var url = baseUrl+s;
    return http.get(url);
  }
}
class _MyHomePageState extends State<ListaDePedidosScreen> {
  final String usuario;
  final String cliente_id;
  String _imagen_utl="http://sd-1578096-h00001.ferozo.net/reservas/reservas_imagenes/";//'https://picsum.photos/250?image=9';
  int  _estado_add=1;
  int  _estado_img=2;
  int estado= 1;
  String reserva_id="";
  final String tyc="Caseros 521 local 6, (Paseo del Cabildo) telf.387-4222466. Horario de atención de 8.30 a 13 hs y de 16.30 a 19hs y sábados de 9 a 13 hs";
  var users = new List<Reserva>();
  initState() {
    super.initState();
    _getUsers(this.usuario);
  }
  _getUsers(String usuario) {
    API.getUsers(usuario).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users= list.map((model) => Reserva.fromJson(model)).toList();
       


      });
    });
  }
  ckeck_conexion(){
    /*
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    */
  }
  ver_imagen(){
    return Container(
      margin: const EdgeInsets.all(30),
        child: Image.network(_imagen_utl+"R"+this.reserva_id+".png",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      );
    /*
    Image.network(_imagen_utl+"R"+this.reserva_id+".png",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
    */
  }
  _MyHomePageState({this.usuario,this.cliente_id});
  var icono_empresa = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/user.png')
      ]
  );
  void buttonPressed(String reserva_id){

    setState(() {
      this.reserva_id=reserva_id;
      estado=this._estado_img;
    });
  }
  get_lista(){
   return Stack(
      children: <Widget>[
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
                    title: IntrinsicHeight( child: Text(users[index].fchalta),)
                    , onTap: () => buttonPressed(users[index].id_reserva)
                )

            );
            // else return null;
          },

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Mas Divisas S.A')),
      body: (estado==this._estado_add)? get_lista(): ver_imagen() ,
      /*drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              /*accountName: new Text('Raja'),*/
              accountEmail: new Text(this.usuario),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new AssetImage('assets/user.png'),
              ),
            ),
            new ListTile(
              title: new Text('Volver'),
              onTap: () {
                Navigator.of(context).pop();


              },
            ),
          ],
        ),
      ),
      */
    );
  }
}
