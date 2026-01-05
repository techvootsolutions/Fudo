import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudo/injection_container.dart';
import 'package:fudo/src/core/router/app_routes.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/core/utils/sharedpref/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies(sl);
    await SharedPref.instance.getUserData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          title: 'Flutter Provider Login',
          theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
          initialRoute: AppRoutes.splashScreen,
            routes: AppRoutes.routes,
        );
      },
    );
  }
}
