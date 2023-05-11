import 'package:chess_family_club/models/convocatoria_model.dart';
import 'package:flutter/material.dart';

class ConvocatoriaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Convocatoria convocatoria;

  ConvocatoriaFormProvider(this.convocatoria);

  bool isValidForm() {
    print(convocatoria.nombre);
    print(convocatoria.fecha);

    return formKey.currentState?.validate() ?? false;
  }
}
