import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irregly/code/data_code.dart';
import 'package:irregly/code/general_code.dart';
import 'package:irregly/core/navigation.dart';
import 'package:irregly/style/general_style.dart';
import 'data/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isUpdated = await isAppUpdated();
  await loadData();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(2560, 1600),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Irregly",
          home: NavigationPage(),
          theme: appTheme(),
        );
      },
    );
  }
}
