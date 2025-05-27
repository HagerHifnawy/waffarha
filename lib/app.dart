import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theme/colors.dart';
import 'core/theme/themes.dart';
import 'features/home/presentation/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void configLoading(BuildContext context) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.secondaryColor
      ..indicatorColor = Theme.of(context).primaryColor
      ..textColor = Theme.of(context).primaryColor
      ..maskColor = AppColors.secondaryTextColor
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
            ),
            child: Builder(builder: (context) {
              return MaterialApp(
                onGenerateRoute: AppRouter().generateRoute,
                initialRoute: Routes.homeScreen,
                theme: lightTheme,
                navigatorKey: navigatorKey,
                themeMode: ThemeMode.light,
                title: 'Waffarha',
                debugShowCheckedModeBanner: false,
                supportedLocales: const [Locale('en')],
                locale: const Locale('en'),
                builder: (context, myWidget) {
                  myWidget = EasyLoading.init()(context, myWidget);
                  configLoading(context);
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Theme.of(context).scaffoldBackgroundColor,
                    systemNavigationBarColor:
                    Theme.of(context).scaffoldBackgroundColor,
                    systemNavigationBarDividerColor:
                    Theme.of(context).scaffoldBackgroundColor,
                    systemNavigationBarContrastEnforced: true,
                    systemStatusBarContrastEnforced: true,
                    systemNavigationBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.dark,
                  ));
                  myWidget = MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: Material(
                        child: Material(
                          child: Stack(children: [
                            myWidget,
                          ]),
                        ),
                      ));
                  return myWidget;
                },
              );
            })));
  }
}