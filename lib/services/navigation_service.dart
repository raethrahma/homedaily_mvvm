import 'package:flutter/material.dart';

// Global navigator key for app-wide navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Navigation service class for handling navigation
class NavigationService {
  static NavigationService? _instance;
  
  NavigationService._();
  
  static NavigationService get instance {
    _instance ??= NavigationService._();
    return _instance!;
  }

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName, 
      arguments: arguments
    );
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}