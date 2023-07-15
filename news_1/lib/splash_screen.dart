import 'package:flutter/material.dart';
import 'package:news_1/component.dart';
import 'package:news_1/sign_up.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    backToHome();
  }

  void backToHome() async {
    Future.delayed(
      const Duration(seconds: 2),
      () {},
    );
    // ignore: use_build_context_synchronously
    await context.read<Component>().initDatabase();
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("assets/images/logo.png"),
    );
  }
}
