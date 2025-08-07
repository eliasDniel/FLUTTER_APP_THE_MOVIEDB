import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingStream() {
    final messages = [
      'Cargando datos...',
      'Por favor, espere un momento...',
      'Estamos preparando todo para ti...',
      'Cargando, casi listo...',
      'Un momento, por favor...',
    ];
    return Stream.periodic(Duration(milliseconds: 500), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Espere un momento'),
          SizedBox(height: 10),
          CircularProgressIndicator(),
          SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              }
              return const Text('Cargando...');
            },
          ),
        ],
      ),
    );
  }
}
