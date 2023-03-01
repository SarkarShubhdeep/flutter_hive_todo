import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key, required this.buttonName, required this.onPressed,
  });

  final String buttonName;
  final Function() onPressed;
  

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(buttonName),
    );
  }
}
