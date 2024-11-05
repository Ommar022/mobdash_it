import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobdash_it/shared/index.dart';

import '../color.dart';

class MyTextFiled extends StatefulWidget {
  final String textFiledType;
  final String? hintText;
  final Color? color;
  final double? height;
  final bool obscureText;
  final TextInputType? textInputType;
  final TextEditingController? controller;

  const MyTextFiled({super.key,
    required this.textFiledType,
    this.hintText,
    this.textInputType,
    this.controller,
    this.obscureText = false,
    this.color, this.height});

  @override
  State<MyTextFiled> createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  late bool _obscureText;
  late TextEditingController _controller;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if(widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kPadding / 4,),
        Container(
          height: widget.height ?? 90,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: widget.color ?? kLightSkyBlue,
            borderRadius: BorderRadius.circular(kRadius * 1.5)
          ),
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Row(
              children: [
                if(widget.textFiledType == 'username')...[
                  const Icon(Icons.person ,size: 32,),
                ],
                if(widget.textFiledType == 'email')...[
                  const Icon(Icons.email ,size: 32,),
                ],
                if(widget.textFiledType == 'password')...[
                  const Icon(Icons.password ,size: 32,),
                ],
                if(widget.textFiledType == 'phone number')...[
                  const Icon(Icons.phone ,size: 32,),
                ],
                const SizedBox(width: kPadding / 2,),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                  
                    },
                    controller: _controller,
                    obscureText: _obscureText,
                    keyboardType: widget.textInputType,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      border: InputBorder.none
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      ],
    );
  }
}
