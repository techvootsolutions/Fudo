// lib/src/features/splash/presentation/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fudo/src/core/utils/constants/app_images.dart';
import 'package:fudo/src/features/splash/presentation/provider/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashProvider()..initializeApp(),
      child: Consumer<SplashProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.fudoLogo,
                    height: 150,
                    width: 150,
                    errorBuilder: (context, error, stackTrace) =>
                        const FlutterLogo(size: 150),
                  ),
                  const SizedBox(height: 20),
                
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}