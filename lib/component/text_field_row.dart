import 'package:flutter/material.dart';

class TextFieldRow extends StatelessWidget {
  const TextFieldRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextFormField(
          decoration: InputDecoration(
            helperText: "",
            hintText: "ROW",
            labelText: "2 In a row",
            contentPadding: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: 150),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            helperText: "",
            hintText: "ROW",
            labelText: "2 In a row",
            contentPadding: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: 150),
          ),
        ),
      ],
    );
  }
}
