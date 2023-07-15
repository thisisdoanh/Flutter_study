import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateLaterNotify extends StatelessWidget {
  const UpdateLaterNotify({super.key, required this.nameIcon});
  final String nameIcon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This feature will be updated later!"),
            duration: Duration(seconds: 2),
          ),
        );
      },
      icon: buttonSignInWith(nameIcon),
    );
  }

  Container buttonSignInWith(String nameIcon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: SvgPicture.asset('assets/icons/$nameIcon'),
    );
  }
}
