import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mas_divisas_app/screen/about.dart';
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
      home: new MyHomePage(usuario: this.usuario, cliente_id: this.cliente_id,sucursal_id: this.sucursal_id,),
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
  static Future getUsers( sucursal) {
    var url = baseUrl+sucursal;
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
    API.getUsers(this.sucursal_id).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users= list.map((model) => Cotizacion.fromJson(model)).toList();
        var users2 = new List<Cotizacion>();
        print("length=>"+users.length.toString()
        +"->"+this.sucursal_id);
        for(final aa in users){
          if (aa.sucursal_id == this.sucursal_id && aa.moneda!=""){

            users2.add(aa);
          }
        }
        /*
        //users=users2;
        print("=>"+users2[3].moneda);
        print("=>"+users2[2].moneda);
        print("=>"+users2[1].moneda);
        print("=>"+users2[0].moneda);*/
        users= new List<Cotizacion>();

        users.add(users2[3]);

        users.add(users2[2]);
        users.add(users2[1]);
        users.add(users2[0]);



        /*
        users[0]=users2[3];
        users[1]=users2[2];
        users[2]=users2[1];
        users[3]=users2[0];
*/

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
          Navigator.push(
          context,
          new MaterialPageRoute(
          builder: (BuildContext context) => new ReservarScreen(cliente_id: this.cliente_id,compra: compra, venta: venta,id_cotizacion: id_cotizacion,tipo_moneda: tipo_moneda,)));

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
          ListView.builder(
            itemCount: users.length,
            padding: const EdgeInsets.all(30.0),
            itemBuilder: (context, index) {
              // if( users[index].sucursal_id.toString().ec == '1')
              return Card(
                  child: ListTile(
                    title: IntrinsicHeight( child: _dinero(
                        users[index].moneda=="DOLAR"?"Dolar Estaunidence": users[index].moneda=="PESO_CHILENO"?"Peso Chileno": users[index].moneda=="REAL"?"Real":users[index].moneda
                        ,users[index].cotizacion_compra
                        , users[index].cotizacion_venta),)
                    , subtitle: Container( color: Colors.black,  child:  _boton(context,users[index].id_cotizaciones,users[index].moneda, users[index].cotizacion_compra,users[index].cotizacion_venta )),
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
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              /*accountName: new Text('Raja'),*/
              accountEmail: new Text(this.usuario+"-"),
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
