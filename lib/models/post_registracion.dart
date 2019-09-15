class PostRegistracion{
  final String registracion;
  final String nombre;
  final String dni;
  final String telefono;
  final String email;
  final String password;
  PostRegistracion({this.registracion,this.nombre,this.dni,this.telefono,this.email,this.password});
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["registracion"] = '1';
    map["nombre"] = nombre;
    map["dni"] = dni;
    map["telefono"] = telefono;
    map["email"] = email;
    map["password"] = password;

    return map;
  }
}