import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: 80,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/banner.png'),
            fit: BoxFit.fitHeight),
      ),
    );
  }
}
