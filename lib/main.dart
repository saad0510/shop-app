import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'core/router/routes.dart';
import 'core/themes/app_theme.dart';
import 'dependencies.dart';

void main() {
  setupDependencies();
  runApp(
    ScreenUtilInit(
      designSize: const Size(376, 738),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      title: "Shopping App",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: Routes.initial,
      getPages: Routes.getPages,
    );
  }
}
