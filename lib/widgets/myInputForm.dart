import 'package:flutter/material.dart';

class MyFormText extends StatelessWidget {
  final Function(String x) onChanged;
  final String? Function(String? x)? validator;
  final String hint;
  final Icon icon;
  final bool hide;
  final TextInputType? type;

  int? maxLines;
  final TextEditingController? controller;
  MyFormText(
      {Key? key,
        this.controller,
        required this.onChanged,
        required this.hint,
        required this.icon,
        this.type,
        this.validator,

        this.hide=false,
        this.maxLines=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
          controller: controller,
          keyboardType: type,

          decoration: InputDecoration(


              hintText: hint,
              prefixIcon: icon,


              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              )),
          maxLines:maxLines,
          minLines: 1,
          obscureText: hide,
          onChanged: onChanged,
      validator: validator,),
    );
  }
}
