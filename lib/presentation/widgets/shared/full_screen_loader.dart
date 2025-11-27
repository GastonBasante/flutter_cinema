import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> streamLoaderMessages() {
    final messages = <String>[
      'Cargando peliculas',
      'Comprando palomitas',
      'Cargando populares',
      'Llamando a mi novia',
      'Ya casi termina...',
      'Esto ya esta tardando mas de lo esperado :(',
    ];

    return Stream.periodic(
      Duration(milliseconds: 1200),
      (step) => messages[step],
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor '),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: streamLoaderMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Cargando...');
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
