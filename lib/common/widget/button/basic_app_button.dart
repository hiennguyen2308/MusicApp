import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final double? height;
  const BasicAppButton({super.key, required this.callback, required this.title,this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          minimumSize:Size.fromHeight(height ?? 80)
        ),
        child:Text(title,style: const TextStyle(color: Colors.white),)
    );
  }
}
