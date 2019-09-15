class Sucursal {
  final String id_sucursal;
  final String desc_sucursal;
  final String observacion;
  final String activo;
  Sucursal({this.id_sucursal, this.desc_sucursal, this.observacion, this.activo});

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
        id_sucursal: json['id_sucursal'],
        desc_sucursal: json['desc_sucursal'],
        observacion: json['observacion'],
        activo: json['activo'],

    );
  }
}