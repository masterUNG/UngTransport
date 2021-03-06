// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ungtransport/utility/my_constant.dart';
import 'package:ungtransport/widges/show_text.dart';

class ShowFormPhone extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool? obsecu;
  final Function(String) changeFunc;
  const ShowFormPhone({
    Key? key,
    required this.label,
    required this.iconData,
    this.obsecu,
    required this.changeFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: TextFormField(keyboardType: TextInputType.phone,
        maxLength: 10,
        onChanged: changeFunc,
        obscureText: obsecu ?? false,
        style: MyConstant().h3Style(),
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          suffixIcon: Icon(
            iconData,
            color: MyConstant.dark,
          ),
          label: ShowText(label: label),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
