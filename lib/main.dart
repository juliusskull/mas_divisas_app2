import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mas_divisas_app/screen/ppal.dart';
import 'package:mas_divisas_app/screen/loginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mas Divisas S.A.',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notic   e that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page 1'),
    );
  }


}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _correo;

  String mensaje = '';
  String _idCliente = '';
  final String _usuarioPrefs = "usuario";
  final String _clienteIdPrefs = "cliente_id";


  initState() {

    super.initState();

    getCredential();
  }
  dispose() {
    // Es importante SIEMPRE realizar el dispose del controller.
    super.dispose();
  }
  getCredential() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getString(_usuarioPrefs);

    _correo    =  sharedPreferences.getString(_usuarioPrefs);
    _idCliente= sharedPreferences.getString(_clienteIdPrefs);
    //print('print=>'+ _correo );
    //MyCustomForm()
    /*
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    */

    if(_correo!=null){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Ppal(usuario:_correo,idCliente:_idCliente)),
      );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body:Stack(
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
          Material(color: Colors.yellowAccent),
        ],
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


