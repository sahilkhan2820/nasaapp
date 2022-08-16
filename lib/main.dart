import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nasa/src/providers/pictures_provider.dart';
import 'package:nasa/src/screens/nasapage.dart';

import 'package:nasa/src/screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((_) {});
  SchedulerBinding.instance.addPostFrameCallback((_) {});
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PicturesProvider(), lazy: false),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
      title: 'SAHIL KHAN',
      initialRoute: 'home',
      routes: {
        'home': (context) => const NasaScreen(), // redirect to home screen
        'details': (context) =>
            const DetailsScreen() // redirect to detail screen
      },
    );
  }
}
