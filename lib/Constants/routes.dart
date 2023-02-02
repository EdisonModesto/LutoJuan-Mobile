import 'package:go_router/go_router.dart';
import 'package:lutojuan/Features/0.%20Authentication/Login_View.dart';
import 'package:lutojuan/Features/0.%20Authentication/SignUp_View.dart';
import 'package:lutojuan/Features/NavBar/Nabar.dart';
import 'package:lutojuan/main.dart';

class AppRoutes{
  var routes = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AppRoot(),
      ),
      GoRoute(
        path: '/Login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/Signup',
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: '/UserNav',
        builder: (context, state) => const AppNavBar(),
      ),
    ],
  );
}