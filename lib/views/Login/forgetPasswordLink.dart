import 'package:bibliotrack/views/Login/forgetPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPasswordLink extends StatelessWidget {
  const ForgetPasswordLink({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => forgetPassword()));
            },
            child: const Text(
              'Forgot password ? ',
              style: TextStyle(
                color: Color(0xff0092A2),
              ),
            ))
      ],
    );
  }
}
