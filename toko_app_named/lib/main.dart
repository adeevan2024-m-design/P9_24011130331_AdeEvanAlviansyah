import 'package:flutter/material.dart';

import 'models/product.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/product_list_page.dart';
import 'pages/splash_screen.dart';
import 'routes/app_routes.dart';
import 'theme/app_colors.dart';

void main() => runApp(const TokoApp());

Route<dynamic>? generateTokoRoute(RouteSettings settings) {
  if (settings.name == AppRoutes.productDetail) {
    return MaterialPageRoute<Product?>(
      settings: settings,
      builder: (context) => const ProductDetailPage(),
    );
  }
  return null;
}

class TokoApp extends StatelessWidget {
  const TokoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.surface,
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.products: (context) => const ProductListPage(),
      },
      onGenerateRoute: generateTokoRoute,
    );
  }
}
