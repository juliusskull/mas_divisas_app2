class PostRespuesta {
  final bool status;
  final String massage;
  final String idCliente;
  final String extra;
  PostRespuesta({this.status,this.massage,this.idCliente,this.extra});



  factory PostRespuesta.fromJson(Map<String, dynamic> json) {
    return PostRespuesta(
      status: json['status'],
      massage: json['massage'],
        idCliente: json['id_cliente'],
      extra: ""

    );
  }
  factory PostRespuesta.fromJson2(Map<String, dynamic> json) {
    return PostRespuesta(
      status: json['status'],
      massage: json['massage'],
      idCliente: json['id_cliente'],
      extra: json['extra'],

    );
  }


}