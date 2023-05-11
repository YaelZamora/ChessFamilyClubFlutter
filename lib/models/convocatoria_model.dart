// To parse this JSON data, do
//
//     final convocatoria = convocatoriaFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Convocatoria {
  Convocatoria({
    required this.fecha,
    required this.imagen,
    required this.info,
    required this.link,
    required this.lugar,
    required this.nombre,
  });

  String fecha;
  String imagen;
  String info;
  String link;
  String lugar;
  String nombre;
  String? id;

  factory Convocatoria.fromRawJson(String str) =>
      Convocatoria.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Convocatoria.fromMap(Map<String, dynamic> json) => Convocatoria(
        fecha: json["Fecha"],
        imagen: json["Imagen"],
        info: json["Info"],
        link: json["Link"],
        lugar: json["Lugar"],
        nombre: json["Nombre"],
      );

  factory Convocatoria.fromJson(Map<String, dynamic> json) => Convocatoria(
        fecha: json["Fecha"],
        imagen: json["Imagen"],
        info: json["Info"],
        link: json["Link"],
        lugar: json["Lugar"],
        nombre: json["Nombre"],
      );

  Map<String, dynamic> toJson() => {
        "Fecha": fecha,
        "Imagen": imagen,
        "Info": info,
        "Link": link,
        "Lugar": lugar,
        "Nombre": nombre,
      };
}
