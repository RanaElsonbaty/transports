import 'package:flutter/material.dart';

void showAppSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = Colors.black,
  Duration duration = const Duration(seconds: 2),
  IconData? icon,
}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), 
    backgroundColor: backgroundColor,
    duration: duration,
    content: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
        ],
        Expanded(child: Text(message, style: const  TextStyle(color: Colors.white))),
      ],
    ),
  );

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
