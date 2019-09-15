class Reserva {
  final String id_reservas_imagenes;
  final String id_reserva;
  final String archivo;
  final String usuario;
  final String fchalta;

 Reserva({this.id_reservas_imagenes, this.id_reserva, this.archivo, this.usuario, this.fchalta});
/*
  Reserva.map(dynamic obj){
    this._id_reservas_imagenes = obj["id_reservas_imagenes"];
    this._id_reserva = obj["id_reserva"];
    this._archivo = obj["archivo"];
    this._usuario = obj["usuario"];
    this._fchalta = obj["fchalta"];
  }
  */
/*
  String get id_reservas_imagenes => _id_reservas_imagenes;
  String get id_reserva => _id_reserva;
  String get archivo => _archivo;
  String get usuario => _usuario;
  String get fchalta => _fchalta;
  */
/*
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id_reservas_imagenes"] = _id_reservas_imagenes;
    map["id_reserva"] = _id_reserva;
    map["archivo"] = _archivo;
    map["usuario"] = _usuario;
    map["fchalta"] = _fchalta;
    return map;
  }
*/
  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      id_reservas_imagenes: json['id_reservas_imagenes'],
      id_reserva: json['id_reserva'],
      archivo: json['archivo'],
      usuario: json['usuario'],
      fchalta: json['fchalta']
    );
  }
}