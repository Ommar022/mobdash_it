import 'package:flutter/material.dart';
import 'package:mobdash_it/shared/color.dart';

class MyCustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final double height;
  final double radius;
  final Color backgroundColor;

  const MyCustomButton({super.key,
    required this.onPressed,
    required this.text,
    required this.fontSize,
    required this.height,
    required this.radius,
    required this.backgroundColor});

  @override
  State<MyCustomButton> createState() => _MyCustomButtonState();
}

class _MyCustomButtonState extends State<MyCustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(double.maxFinite,widget.height),
        backgroundColor: widget.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius)
        ),
      ),
      child: Text(widget.text,style: TextStyle(fontSize: widget.fontSize,color: kBlack),),
    );
  }
}
