class Cotizacion {
  final String idCotizaciones;
  final String idSucursal;
  final String moneda;
  final String cotizacionCompra;
  final String cotizacionVenta;
  final String fchalta;
  final String descSucursal;

  Cotizacion({this.idCotizaciones, this.idSucursal, this.moneda, this.cotizacionCompra, this.cotizacionVenta, this.fchalta, this.descSucursal});

  factory Cotizacion.fromJson(Map<String, dynamic> json) {
    return Cotizacion(
      idCotizaciones: json['id_cotizaciones'],
      idSucursal: json['sucursal_id'],
      moneda: json['moneda'],
      cotizacionCompra: json['cotizacion_compra'],
      cotizacionVenta: json['cotizacion_venta'],
      fchalta: json['fchalta'],
      descSucursal: json['desc_sucursal'],
    );
  }
}