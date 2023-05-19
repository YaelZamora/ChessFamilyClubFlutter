import 'package:chess_family_club/providers/convocatoria_form_provider.dart';
import 'package:chess_family_club/services/convocatoria_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NuevaConvocatoriaScreen extends StatelessWidget {
  NuevaConvocatoriaScreen({super.key});

  final _nombre = TextEditingController();
  final _lugar = TextEditingController();
  final _fecha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final convocatoriaService = Provider.of<ConvocatoriaService>(context);

    return ChangeNotifierProvider(
      create: (_) =>
          ConvocatoriaFormProvider(convocatoriaService.selectedConvocatoria),
      child: _NuevaConvocatoriaBody(
        nombre: _nombre,
        lugar: _lugar,
        fecha: _fecha,
        convocatoriaService: convocatoriaService,
      ),
    );
  }
}

class _NuevaConvocatoriaBody extends StatelessWidget {
  const _NuevaConvocatoriaBody({
    required TextEditingController nombre,
    required TextEditingController lugar,
    required TextEditingController fecha,
    required this.convocatoriaService,
  })  : _nombre = nombre,
        _lugar = lugar,
        _fecha = fecha;

  final TextEditingController _nombre;
  final TextEditingController _lugar;
  final TextEditingController _fecha;

  final ConvocatoriaService convocatoriaService;

  @override
  Widget build(BuildContext context) {
    final convocatoriaForm = Provider.of<ConvocatoriaFormProvider>(context);
    final convocatoria = convocatoriaForm.convocatoria;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Convocatoria'),
      ),
      body: Column(
        children: [
          CampoTexto(
            valor: convocatoria.nombre,
            hint: 'Nombre torneo',
            info: TextInputType.name,
          ),
          CampoTexto(
            valor: convocatoria.lugar,
            hint: 'Lugar torneo',
            info: TextInputType.streetAddress,
          ),
          CampoTexto(
            valor: convocatoria.fecha,
            hint: 'Fecha torneo',
            info: TextInputType.datetime,
          ),
          CampoTexto(
            hint: 'Link',
            info: TextInputType.url,
            valor: convocatoria.link,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            child: MaterialButton(
              onPressed: () {},
              color: Colors.indigo,
              minWidth: 300,
              height: 60,
              child: const Text(
                'Subir imagen',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!convocatoriaForm.isValidForm()) return;

          await convocatoriaService
              .saveOrCreateProduct(convocatoriaForm.convocatoria);
        },
        child: const Icon(Icons.save_outlined),
      ),
    );
  }
}

class CampoTexto extends StatelessWidget {
  CampoTexto({
    super.key,
    required this.hint,
    required this.info,
    required this.valor,
  });
  final String hint;
  final TextInputType info;
  String valor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade300,
      ),
      child: TextFormField(
        initialValue: valor,
        onChanged: (value) => valor = value,
        keyboardType: info,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
