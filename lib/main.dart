import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Constants/routes.dart';
import 'Features/0. Authentication/AuthViewModel.dart';
import 'Features/0. Authentication/Login_View.dart';
import 'Features/NavBar/Nabar.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes().routes,
      title: 'LutoJuan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}


class AppRoot extends ConsumerStatefulWidget {
  const AppRoot({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AppRootState();
}

class _AppRootState extends ConsumerState<AppRoot> {

  @override
  Widget build(BuildContext context) {
    var AuthState = ref.watch(AuthStateProvider);
    return AuthState.when(
      data: (data){
        if(data != null){
          return const AppNavBar();
        }else{
          return const LoginView();
        }
      },
      error: (error, stack){
        return const LoginView();
      },
      loading: (){
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
