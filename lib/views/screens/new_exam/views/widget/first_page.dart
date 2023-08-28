import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [_itemSelection()],
      ),
    );
  }

  _itemSelection() {
    return DottedBorder(
      color: Colors.black,
      strokeWidth: 1,
      child: FlutterLogo(size: 148),
    );
  }
}
