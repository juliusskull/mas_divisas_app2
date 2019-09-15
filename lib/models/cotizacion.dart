class Cotizacion {
  final String id_cotizaciones;
  final String sucursal_id;
  final String moneda;
  final String cotizacion_compra;
  final String cotizacion_venta;
  final String fchalta;
  final String desc_sucursal;

  Cotizacion({this.id_cotizaciones, this.sucursal_id, this.moneda, this.cotizacion_compra, this.cotizacion_venta, this.fchalta, this.desc_sucursal});

  factory Cotizacion.fromJson(Map<String, dynamic> json) {
    return Cotizacion(
      id_cotizaciones: json['id_cotizaciones'],
      sucursal_id: json['sucursal_id'],
      moneda: json['moneda'],
      cotizacion_compra: json['cotizacion_compra'],
      cotizacion_venta: json['cotizacion_venta'],
      fchalta: json['fchalta'],
      desc_sucursal: json['desc_sucursal'],
    );
  }
}