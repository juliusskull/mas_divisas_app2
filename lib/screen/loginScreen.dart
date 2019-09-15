import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mas_divisas_app/models/post_respuesta.dart';
import 'package:mas_divisas_app/models/post_logueo.dart';
import 'package:mas_divisas_app/screen/ppal.dart';
import 'package:mas_divisas_app/screen/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mas_divisas_app/screen/loginScreen.dart';
import 'package:mas_divisas_app/screen/registrarceScreen.dart';
//https://github.com/Arkangel12/animacion_loginbasico/blob/master/lib/screens/loginScreen.dart
class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => LoginScreen(),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
final String _usuarioPrefs = "usuario";
final String _cliente_idPrefs = "cliente_id";

Future<String> getStringPrefs(String s) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(s) ?? 'null';
}

Future<bool> setStringPrefs(String s,String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(_usuarioPrefs, value);
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
Future<bool> createSession(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      //throw new Exception("Error while fetching data");
      return false;
    }else{
      PostRespuesta rr =PostRespuesta.fromJson(json.decode(response.body));

      return true;
    }

  });
}
Future<PostLogueo> createPostLogueo(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return PostLogueo.fromJson(json.decode(response.body));
  });
}
Future<Logueo> fetchLogueo() async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Logueo.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
class Logueo {
  final bool status ;
  final String massage;
  final int id_cliente;

  Logueo({this.status,this.massage,this.id_cliente});

  factory Logueo.fromJson(Map<String, dynamic> json) {
    return Logueo(
      status: json['status'],
      massage: json['massage'],
      id_cliente: json['id_cliente'],

    );
  }

}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  GlobalKey<FormState> _key = GlobalKey();
  String url="http://sd-1578096-h00001.ferozo.net/reservas/wses.php";
  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
  String _correo;
  String _contrasena;
  String mensaje = '';
  String _id_cliente;

  bool _logueado = false;

  getCredential() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getString(_usuarioPrefs);

    _correo    =  sharedPreferences.getString(_usuarioPrefs);
    _id_cliente= sharedPreferences.getString(_cliente_idPrefs);
    print('print=>'+ _correo );

    if(_correo!=null){
      _ir();
    }
  }
  setCredential() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_usuarioPrefs, _correo);
    sharedPreferences.setString(_cliente_idPrefs, _id_cliente);
  }
  _ir(){
    //('/ppal');
    Navigator.push(
      context,
      //MaterialPageRoute(builder: (context) => SyncData(post: fetchPost())),
      MaterialPageRoute(builder: (context) => Ppal(usuario:_correo,cliente_id:_id_cliente)),
    );
  }

  initState() {
    super.initState();
    //getCredential();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    //    Descomentar las siguientes lineas para generar un efecto de "respiracion"
//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        controller.reverse();
//      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
//      }
//    });

    controller.forward();
  }

  dispose() {
    // Es importante SIEMPRE realizar el dispose del controller.
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _logueado ? HomeScreen(mensaje: mensaje) : loginForm() ,
//      body: loginForm(),registrarce - loginForm2()
    );
  }
  Widget loginForm2() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Row(
    mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Text("Nombre:"),
          new TextField()
        ])]);
  }
  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedLogo(animation: animation),
          ],
        ),
        Container(
          width: 300.0, //size.width * .6,
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (text) {
                    if (text.length == 0) {
                      return "Este campo correo es requerido";
                    } else if (!emailRegExp.hasMatch(text)) {
                      if(text!='admin'){
                        return "El formato para correo no es correcto";
                      }

                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Ingrese su Correo',
                    labelText: 'Correo',
                    counterText: '',
                    icon:
                    Icon(Icons.email, size: 32.0, color: Colors.blue[800]),
                  ),
                  onSaved: (text) => _correo = text,
                ),
                TextFormField(
                  validator: (text) {
                    if (text.length == 0) {
                      return "Este campo contraseña es requerido";
                    } else if (text.length <= 2) {
                      return "Su contraseña debe ser al menos de 3 caracteres";
                    } else if (!contRegExp.hasMatch(text)) {
                      return "El formato para contraseña no es correcto";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Ingrese su Contraseña',
                    labelText: 'Contraseña',
                    counterText: '',
                    icon: Icon(Icons.lock, size: 32.0, color: Colors.blue[800]),
                  ),
                  onSaved: (text) => _contrasena = text,
                ),
                IconButton(
                  onPressed: () async{

                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      //Aqui se llamaria a su API para hacer el login
                      //PostLogueo newPostLogueo= new PostLogueo(login:"1",usuario:"admin",password:"123");_correo
                      PostLogueo newPostLogueo= new PostLogueo(login:"1",usuario:_correo,password:_contrasena);
                      try {
                          PostRespuesta p= await createPostRespuesta(this.url,body: newPostLogueo.toMap());
                          if(p.status){
                            _id_cliente=p.id_cliente;
                            setCredential();

                            _ir();
                          }else{
                            print('=>Error de logueo');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => _buildAboutDialog(context),
                            );
                          }

                      } catch (e) {
                        // Handle error...
                        print('=>Error de logueo');
                      }
                      //mensaje = 'Gracias \n $_correo \n ';
                     // Navigator.of(context).push( );
//                      Una forma correcta de llamar a otra pantalla
//                      Navigator.of(context).push(HomeScreen.route(mensaje));
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 42.0,
                    color: Colors.blue[800],
                  ),
                )
                ,RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  elevation: 4.0,
                  color: Colors.white,
                  splashColor: Colors.blueGrey,
                  child:
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center ,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Sign Up",style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                        )),

                      ]),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new MyCustomForm()));

                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  // Maneja los Tween estáticos debido a que estos no cambian.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 150.0);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: _sizeTween.evaluate(animation), // Aumenta la altura
        width: _sizeTween.evaluate(animation), // Aumenta el ancho
        child: Image.asset('assets/user.png'),//FlutterLogo(),
      ),
    );
  }
}
Widget _buildAboutDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Error'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Loguin Incorrecto"),


      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Aceptar'),
      ),
    ],
  );

}