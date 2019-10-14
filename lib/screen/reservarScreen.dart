import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mas_divisas_app/models/post_reserva.dart';
import 'package:mas_divisas_app/models/post_respuesta.dart';

class ReservarScreen extends StatefulWidget {
  final String idCotizacion;
  final String tipoMoneda;
  final String compra;
  final String venta;
  final String idCliente;
  ReservarScreen({Key key,this.idCotizacion,this.tipoMoneda,this.compra,this.venta,this.idCliente}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState(idCotizacion: this.idCotizacion,tipoMoneda: this.tipoMoneda,compra: this.compra,venta: this.venta,idCliente: this.idCliente);
}

class _MyHomePageState extends State<ReservarScreen> {
  final String idCotizacion;
  final String tipoMoneda;
  final String compra;
  final String venta;
  final String idCliente;

  double _radioValue = 0;
  String  _imagenUrl="http://sd-1578096-h00001.ferozo.net/reservas/reservas_imagenes/";//'https://picsum.photos/250?image=9';
  final String url="http://sd-1578096-h00001.ferozo.net/reservas/wses.php";
  int  estadoAdd=1;
  int  estadoImg=2;
  int estado= 1;
  String valorFinal="0.0";
  String idReserva="";
  _MyHomePageState({this.idCotizacion,this.tipoMoneda,this.compra,this.venta,this.idCliente});
  final cantidadController = TextEditingController();
  @override
  void initState() {
    setState(() {
      _radioValue = .5;
    });
    super.initState();
  }

  // ignore: must_call_super
  void dispose() {
    cantidadController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Reservas'),
      ),
      body: (estado==this.estadoAdd)? verAdd(): verImagen()
      ,
    );
  }
  void buttonPressed(){
    setState(() {
      estado=this.estadoImg;
    });
  }
  verImagen(){
    return Container(
      margin: const EdgeInsets.all(30),
      child: Image.network(_imagenUrl+"R"+this.idReserva+".png",
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
verAdd(){
  return  Container(

      child: new SingleChildScrollView(
        child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text(
            this.tipoMoneda,
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
                  this.valorFinal,
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
                _cambioValor( text);
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
                suffixText: this.tipoMoneda,
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
                        print("valor=>"+this.idCliente);
                        print("valor=>"+this.idCotizacion);
                        print("valor=>"+this.tipoMoneda);
                        String operacion="";
                        if(_radioValue==0.5){
                          operacion="venta";
                        }else{
                          operacion="compra";
                        }

                        PostReserva newPostReserva = new PostReserva(idCliente: this.idCliente,idReserva: this.idCotizacion,tipoMoneda: this.tipoMoneda,valor: this.valorFinal,tipo: operacion);
                        PostRespuesta p= await createPostRespuesta(this.url,body: newPostReserva.toMap());
                        if(p.status){
                          print("reserva=>"+p.extra);
                          this.idReserva=p.extra;
                          setState(() {
                            this.estado=this.estadoImg;
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

 _cambioValor(String text){
   try {
     double dd = double.parse(text);
     if(_radioValue==0.5){
       dd = dd * double.parse(this.venta);
     }else{
       dd = dd * double.parse(this.compra);
     }

     this.valorFinal = dd.toStringAsFixed(3);
   } catch (exception) {
     this.valorFinal = "0.00";
   }
 }
  void radioChanged(double value) {
    print("ckech:"+ value.toString());
    setState(() {
      _radioValue = value;
      _cambioValor(this.cantidadController.text);
    });
  }

}
