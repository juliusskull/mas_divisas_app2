class PostLogueo {
  final String login;
  final String usuario;
  final String password;
  PostLogueo({this.login,this.usuario,this.password});

  factory PostLogueo.fromJson(Map<String, dynamic> json) {
    return PostLogueo(
      login: json['login'],
      usuario: json['usuario'],
      password: json['password'],

    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["login"] = login;
    map["usuario"] = usuario;
    map["password"] = password;

    return map;
  }
}