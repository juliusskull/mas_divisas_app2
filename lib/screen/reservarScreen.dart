import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mas_divisas_app/models/cotizacion.dart';
import 'package:mas_divisas_app/models/post_reserva.dart';
import 'package:mas_divisas_app/models/post_respuesta.dart';

class ReservarScreen extends StatefulWidget {
  final String id_cotizacion;
  final String tipo_moneda;
  final String compra;
  final String venta;
  final String cliente_id;
  ReservarScreen({Key key,this.id_cotizacion,this.tipo_moneda,this.compra,this.venta,this.cliente_id}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState(id_cotizacion: this.id_cotizacion,tipo_moneda: this.tipo_moneda,compra: this.compra,venta: this.venta,cliente_id: this.cliente_id);
}

class _MyHomePageState extends State<ReservarScreen> {
  final String id_cotizacion;
  final String tipo_moneda;
  final String compra;
  final String venta;
  final String cliente_id;
  int _currVal = 1;
  double _radioValue = 0;
  String  _imagen_utl="http://sd-1578096-h00001.ferozo.net/reservas/reservas_imagenes/";//'https://picsum.photos/250?image=9';
  final String url="http://sd-1578096-h00001.ferozo.net/reservas/wses.php";
  int  _estado_add=1;
  int  _estado_img=2;
  int estado= 1;
  String valor_final="0.0";
  String reserva_id="";
  _MyHomePageState({this.id_cotizacion,this.tipo_moneda,this.compra,this.venta,this.cliente_id});
  final cantidadController = TextEditingController();
  @override
  void initState() {
    setState(() {
      _radioValue = .5;
    });
    super.initState();
  }
  @override
  void dispose() {
    cantidadController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Reservas'),
      ),
      body: (estado==this._estado_add)? ver_add(): ver_imagen()
      ,
    );
  }
  void buttonPressed(){
    setState(() {
      estado=this._estado_img;
    });
  }
 ver_imagen(){
    return Image.network(_imagen_utl+"R"+this.reserva_id+".png",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,);
}
ver_add(){
  return  Container(

      child: new SingleChildScrollView(
        child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text(
            this.tipo_moneda,
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
                  "Te Vendemos a \$"+this.venta,
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
                  "Te Compramos a \$"+this.compra,
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
                  this.valor_final,
                  style: new TextStyle(
                      fontSize:15.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w900,
                      fontFamily: "Roboto"),
                )
              ]

          ),

          new TextField(/**/
            keyboardType: TextInputType.number,
            autofocus: true,
            controller:cantidadController,
            onChanged: (text) {
              print("valor=>"+_radioValue.toString() );
              setState(() {
                _cambio_valor( text);
              });
            },
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
                suffixText: this.tipo_moneda,
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

                new RaisedButton(key:null,
                    onPressed:()async{
                        print("valor=>"+cantidadController.text);
                        print("valor=>"+this.cliente_id);
                        print("valor=>"+this.id_cotizacion);
                        print("valor=>"+this.tipo_moneda);
                        String operacion="";
                        if(_radioValue==0.5){
                          operacion="venta";
                        }else{
                          operacion="compra";
                        }

                        PostReserva newPostReserva = new PostReserva(cliente_id: this.cliente_id,id_reserva: this.id_cotizacion,tipo_moneda: this.tipo_moneda,valor: this.valor_final,tipo: operacion);
                        PostRespuesta p= await createPostRespuesta(this.url,body: newPostReserva.toMap());
                        if(p.status){
                          print("reserva=>"+p.extra);
                          this.reserva_id=p.extra;
                          setState(() {
                            this.estado=this._estado_img;
                          });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the user has entered by using the
                                // TextEditingController.
                                content: Text("Se creo Correctamente la nueva reserva"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();


                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }else{
                          Navigator.of(context).pop();
                          print('=>Error de logueo');
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the user has entered by using the
                                // TextEditingController.
                                content: Text("Error al crear un nuevo usuario"),
                              );
                            },
                          );
                        }
                    },
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
      ),
    padding: const EdgeInsets.all(0.0),
    alignment: Alignment.center,
  );
}
  Future<PostRespuesta> createPostRespuesta(String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return PostRespuesta.fromJson2(json.decode(response.body));
    });
  }

 _cambio_valor(String text){
   try {
     double dd = double.parse(text);
     if(_radioValue==0.5){
       dd = dd * double.parse(this.venta);
     }else{
       dd = dd * double.parse(this.compra);
     }

     this.valor_final = dd.toStringAsFixed(3);
   } catch (exception) {
     this.valor_final = "0.00";
   }
 }
  void radioChanged(double value) {
    print("ckech:"+ value.toString());
    setState(() {
      _radioValue = value;
      _cambio_valor(this.cantidadController.text);
    });
  }

}
