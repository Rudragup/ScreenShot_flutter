import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot_flutter/core/di/injection_container.dart' as di;
import 'package:screenshot_flutter/core/theme/app_theme.dart';
import 'package:screenshot_flutter/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock portrait orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SecureAuth',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
