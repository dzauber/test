import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;

  const MenuButton({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.black),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.elliptical(10, 15)))), // rectangle border
        fixedSize:
            MaterialStatePropertyAll(Size(300.0, 100.0)), // size of button
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30.0, color: Colors.white),
          Text(text,
              style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
