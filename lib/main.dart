import 'package:flutter/material.dart';
import 'package:item_task/modules/inventory_transformation/presentation/transformation/transformation_router.dart';
import 'package:item_task/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          primary: const Color(0xFF6366F1),
        ),
        useMaterial3: true,
        fontFamily: 'Inter', // Assuming Inter or system default
      ),
      home: TransformationRouter.createModule(),
    );
  }
}
