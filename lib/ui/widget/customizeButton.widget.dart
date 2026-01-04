import 'package:flutter/material.dart';
class CustomizeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final Icon? icon;
  const CustomizeButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size.fromHeight(70),
      ),
      onPressed: onPressed, child: icon ==null ? Text(title,style: TextStyle(fontSize:18)) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: 10,),
          Text(title,
          style:TextStyle(fontSize:18)),
        ],
      )
    );
  }
}