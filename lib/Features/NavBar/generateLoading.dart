import "package:flutter/material.dart";
import "package:flutter_gif/flutter_gif.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../Services/AuthService.dart";

class GenerateLoading extends ConsumerStatefulWidget {
  const GenerateLoading({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GenerateLoadingState();
}

class _GenerateLoadingState extends ConsumerState<GenerateLoading> with SingleTickerProviderStateMixin {
  late FlutterGifController controller;

  void delay()async{
    await Future.delayed(const Duration(seconds: 2));
    print("done");
    Navigator.pop(context);
  }

  @override
  void initState() {
    controller = FlutterGifController(vsync: this);
    controller.repeat(min:0, max:160, period:const Duration(seconds: 1));
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
          image: const AssetImage("assets/images/flow2.gif"),
          fit: BoxFit.cover,
        )
    );
  }
}
