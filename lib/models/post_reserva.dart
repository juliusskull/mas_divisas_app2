class PostReserva{
  final String id_reserva;
  final String tipo;
  final String cliente_id;
  final String valor;
  final String tipo_moneda;

  PostReserva({this.id_reserva, this.tipo, this.cliente_id, this.valor, this.tipo_moneda});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["reserva"] = "1";
    map["tipo"] = tipo;
    map["cliente_id"] = cliente_id;
    map["valor"] = valor;
    map["tipo_moneda"] = id_reserva;


    return map;
  }



}