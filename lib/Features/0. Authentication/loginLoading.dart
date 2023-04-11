import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Services/AuthService.dart';

class LoginLoading extends ConsumerStatefulWidget {
  const LoginLoading({
    required this.email,
    required this.pass,
    Key? key,
  }) : super(key: key);

  final String email;
  final String pass;

  @override
  ConsumerState createState() => _LoginLoadingState();
}

class _LoginLoadingState extends ConsumerState<LoginLoading> with SingleTickerProviderStateMixin {

  late FlutterGifController controller;

  void delay()async{
    await Future.delayed(const Duration(seconds: 3));
    print("done");
    AuthService().signIn(widget.email, widget.pass);
    Navigator.pop(context);
  }

  @override
  void initState() {
    controller = FlutterGifController(vsync: this);
    controller.repeat(min:0, max:190, period:const Duration(seconds: 1));
    delay();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: GifImage(
        controller: controller,
        image: const AssetImage("assets/images/flow1.gif"),
        fit: BoxFit.cover,
      )
    );
  }
}
