class IMC {
  double peso = 0.0;
  double altura = 0.0;
  String resultado = "";
  String dataRegistro = "";

  IMC({
    required this.peso,
    required this.altura,
    required this.resultado,
    required this.dataRegistro,
  });

  Map<String, dynamic> toJson() => {
        'peso': peso,
        'altura': altura,
        'resultado': resultado,
        'dataRegistro': dataRegistro,
      };

  factory IMC.fromJson(Map<String, dynamic> json) => IMC(
        peso: json['peso'],
        altura: json['altura'],
        resultado: json['resultado'],
        dataRegistro: json['dataRegistro'],
      );
}
