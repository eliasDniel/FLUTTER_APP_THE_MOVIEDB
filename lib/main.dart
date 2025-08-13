import 'package:app_flutter_the_movie/config/router/app_router.dart';
import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_flutter/adapters.dart';
import 'config/theme/app_theme.dart';

 // Importa hive_flutter

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Inicializa Hive aquí
  Hive.registerAdapter(MovieAdapter());
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
