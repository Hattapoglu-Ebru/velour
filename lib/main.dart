import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Durum çubuğunu şeffaf yap
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const VelourApp());
}

class VelourApp extends StatelessWidget {
  const VelourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Velour – Beauty & Fragrance',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,

      // Named Routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/detail': (context) => const ProductDetailScreen(),
      },

      // Bilinmeyen route'lar için fallback
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }
}
