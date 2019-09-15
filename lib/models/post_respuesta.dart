class PostRespuesta {
  final bool status;
  final String massage;
  final String id_cliente;
  final String extra;
  PostRespuesta({this.status,this.massage,this.id_cliente,this.extra});



  factory PostRespuesta.fromJson(Map<String, dynamic> json) {
    return PostRespuesta(
      status: json['status'],
      massage: json['massage'],
      id_cliente: json['id_cliente'],
      extra: ""

    );
  }
  factory PostRespuesta.fromJson2(Map<String, dynamic> json) {
    return PostRespuesta(
      status: json['status'],
      massage: json['massage'],
      id_cliente: json['id_cliente'],
      extra: json['extra'],

    );
  }


}