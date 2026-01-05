
import 'package:flutter/material.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> pushNamed(
    String routeName, {
    dynamic arguments,
  }) async {
    logV("Current Route:$routeName");
    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Route createFadeRoute(Widget widget, {int duration = 300}) {
    return PageRouteBuilder(
      pageBuilder: (_, a1, a2) => FadeTransition(opacity: a1, child: widget),
      transitionDuration: Duration(milliseconds: duration),
    );
  }

  static Future<dynamic> push(
    BuildContext context,
    Widget routeChild, {
    dynamic argument,
  }) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 220),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (context, animation, secondaryAnimation) {
          // Pass the argument to the routeChild
          return routeChild;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  static Future<dynamic> pushReplace(
    BuildContext context,
    Widget routeChild,
  ) async {
    await Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 220),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (context, animation, secondaryAnimation) => routeChild,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  static goBack<T extends Object?>([T? result]) {
    logV("goBack called");
   return Navigator.of(navigatorKey.currentState!.context).canPop()?
     navigatorKey.currentState?.pop<T>(result): null;
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    bool routePredicate = false,
    dynamic arguments,
  }) async {
    logV("Current Route:$routeName");

    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => routePredicate,
      arguments: arguments,
    );
  }

  static Future<dynamic> popAndPushNamed(
    String routeName, {
    dynamic arguments,
  }) async {
    logV("Current Route:$routeName");

    return navigatorKey.currentState?.popAndPushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic> pushReplaceName(
    String routeName, {
    dynamic arguments,
  }) async {
    logV("Current Route:$routeName");

    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic> popNamedAndRemoveUntil(
    String routeName, {
    bool routePredicate = false,
    dynamic arguments,
  }) async {
    logV("Current Route:$routeName");

    return navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }
}
