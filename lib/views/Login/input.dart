import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class Input extends StatelessWidget {
  final BoxConstraints constraints;
  final Widget textField;

  const Input({Key? key, required this.constraints, required this.textField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxHeight * 0.15,
      decoration: BoxDecoration(
        color: const Color(0xffB4B4B4).withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: Center(
          child: textField,
        ),
      ),
    );
  }
}
