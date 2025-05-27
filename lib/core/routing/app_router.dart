import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waffarha/core/di.dart';
import 'package:waffarha/core/routing/routes.dart';
import 'package:waffarha/features/home/cubit/home_cubit.dart';
import 'package:waffarha/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    PageTransition transition<T extends Cubit<Object>>({
      required Widget screen,
      T? cubit,
      Object? arguments,
    }) {
      final child = cubit != null
          ? BlocProvider<T>(
              create: (context) => cubit,
              child: screen,
            )
          : screen;

      return PageTransition(
        child: child,
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        settings: settings,
      );
    }

    switch (settings.name) {
      case Routes.homeScreen:
        return transition(
            screen: const HomeScreen(), cubit: HomeCubit(getIt())..getHome());
      default:
        return null;
    }
  }
}
