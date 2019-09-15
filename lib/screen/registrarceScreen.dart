import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mas_divisas_app/models/post_registracion.dart';
import 'package:mas_divisas_app/models/post_respuesta.dart';
// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class _MyHomePageState extends State<MyCustomForm> {
  int _currVal = 1;
  double _radioValue = 0;
  String _imagen_utl='https://picsum.photos/250?image=9';
  int  _estado_add=1;
  int  _estado_img=2;
  int estado= 1;
  final nombreController = TextEditingController();
  final dniController = TextEditingController();
  final telefonoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final url="http://sd-1578096-h00001.ferozo.net/reservas/wses.php";
 // final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nombreController.dispose();
    dniController.dispose();
    telefonoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
        title: new Text('Register'),
      ),
      body: (estado==this._estado_add)? ver_add(): ver_imagen()
      ,
    );
  }
  void buttonPressed(){
   /* setState(() {
      //estado=this._estado_img;
    });
    */

  }
  Future<PostRespuesta> createPostRespuesta(String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return PostRespuesta.fromJson(json.decode(response.body));
    });
  }
  ver_imagen(){
    return Image.network(_imagen_utl, );
  }
  Future<Null> _submitDialog(BuildContext context) async {
    return await showDialog<Null>(
        context: context,
        barrierDismissible: false,

        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,

            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        });
  }
  ver_add(){
    return  Container(
      //child:
      child: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new TextField(
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  controller:nombreController,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: '- -',
                      helperText: 'Nombre',
                      labelText: 'Nombre',
                      prefixIcon: const Icon(
                        Icons.account_box,
                        color: Colors.black,
                      ),
                      prefixText: ' ',
                      suffixText: '(*)Nombre',
                      suffixStyle: const TextStyle(color: Colors.black)),
                ),
                new TextField(
                  keyboardType: TextInputType.number,
                  controller:dniController,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: '- -',
                      helperText: 'DNI',
                      labelText: 'DNI',
                      prefixIcon: const Icon(
                        Icons.account_box,
                        color: Colors.black,
                      ),
                      prefixText: ' ',
                      suffixText: 'DNI',
                      suffixStyle: const TextStyle(color: Colors.black)),
                ),
                new TextField(
                  keyboardType: TextInputType.phone,
                  controller:telefonoController,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: '- -',
                      helperText: 'Telefono',
                      labelText: 'Telefono',
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      prefixText: ' ',
                      suffixText: '(*)Telefono',
                      suffixStyle: const TextStyle(color: Colors.black)),
                ),
                new TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller:emailController,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: '- -',
                      helperText: 'Email',
                      labelText: 'Email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      prefixText: '',
                      suffixText: '(*)Email',
                      suffixStyle: const TextStyle(color: Colors.black)),
                ),
                new TextField(
                  keyboardType: TextInputType.text,
                  controller:passwordController,
                  obscureText: true,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: '- -',
                      helperText: 'Password',
                      labelText: 'Password',
                      prefixIcon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      prefixText: ' ',
                      suffixText: '(*)Password',
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
                          onPressed:()
                      async{
                        if(nombreController.text!=null && emailController.text!=null && telefonoController.text!=null && passwordController.text!=null){
                          _submitDialog(context);
                          PostRegistracion newPostRegistracion =new PostRegistracion(registracion: '1',nombre:nombreController.text,dni: dniController.text,telefono: telefonoController.text,email: emailController.text,password: passwordController.text );
                              PostRespuesta p= await createPostRespuesta(url,body: newPostRegistracion.toMap());

                              if(p.status){
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      // Retrieve the text the user has entered by using the
                                      // TextEditingController.
                                      content: Text("Se creo Correctamente el nuevo usuario!!"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
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

                        }else{
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the user has entered by using the
                                // TextEditingController.
                                content: Text("Los campos (*) son obligatorios"),
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
            ],
          ),
    ),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
    );
  }


  void radioChanged(double value) {
    print("ckech:"+ value.toString());
    setState(() {
      _radioValue = value;
    });
  }

}