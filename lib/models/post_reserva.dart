class PostReserva{
  final String idReserva;
  final String tipo;
  final String idCliente;
  final String valor;
  final String tipoMoneda;

  PostReserva({this.idReserva, this.tipo, this.idCliente, this.valor, this.tipoMoneda});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["reserva"] = "1";
    map["tipo"] = tipo;
    map["cliente_id"] = idCliente;
    map["valor"] = valor;
    map["tipo_moneda"] = idReserva;


    return map;
  }



}