import 'dart:convert';

import 'package:chess_family_club/models/convocatoria_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConvocatoriaService extends ChangeNotifier {
  final String _baseUrl = 'proyectoprueba-62052.firebaseio.com';

  List<Convocatoria> convocatoria = [];
  bool isLoading = true;
  bool isSaving = false;
  late Convocatoria selectedConvocatoria;
  final storage = const FlutterSecureStorage();

  ConvocatoriaService() {
    loadConvocatorias();
  }

  Future<List<Convocatoria>> loadConvocatorias() async {
    notifyListeners();
    isLoading = true;

    final url = Uri.https(_baseUrl, 'Convocatoria.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    final resp = await http.get(url);

    final Map<String, dynamic> convocatoriasMap = json.decode(resp.body);

    convocatoriasMap.forEach((key, value) {
      final tempConvocatoria = Convocatoria.fromMap(value);
      tempConvocatoria.id = key;
      convocatoria.add(tempConvocatoria);
    });

    notifyListeners();

    return convocatoria;
  }

  Future saveOrCreateProduct(Convocatoria convocatoria) async {
    isSaving = true;
    notifyListeners();

    if (convocatoria.id == null) {
      // Es necesario crear
      await createProduct(convocatoria);
    } else {
      // Actualizar
      await updateProduct(convocatoria);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Convocatoria convocatoria) async {
    final url = Uri.https(_baseUrl, 'Convocatoria/${convocatoria.id}.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    final resp = await http.put(url, body: convocatoria.toJson());
    final decodedData = resp.body;

    final index = this
        .convocatoria
        .indexWhere((element) => element.id == convocatoria.id);
    this.convocatoria[index] = convocatoria;

    return convocatoria.id!;
  }

  Future<String> createProduct(Convocatoria convocatoria) async {
    final url = Uri.https(_baseUrl, 'Convocatoria.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    final resp = await http.post(url, body: convocatoria.toJson());
    final decodedData = resp.body;

    //convocatoria.id = decodedData['name'];

    //this.convocatoria.add(convocatoria);

    print(decodedData);
    return '';

    //return convocatoria.id!;
  }
}
