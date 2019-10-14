class Sucursal {
  final String idSucursal;
  final String descSucursal;
  final String observacion;
  final String activo;
  Sucursal({this.idSucursal, this.descSucursal, this.observacion, this.activo});

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
      idSucursal: json['id_sucursal'],
      descSucursal: json['desc_sucursal'],
        observacion: json['observacion'],
        activo: json['activo'],

    );
  }
}