import 'package:flutter/material.dart';

import 'package:flutter_cinema/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_cinema/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async{ // Accedemos a nuestro .env para obtener variables de entorno
  await dotenv.load(fileName: '.env');
  runApp(
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter, 
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
