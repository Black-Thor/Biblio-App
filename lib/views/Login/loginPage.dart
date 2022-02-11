import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isVisible = false;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: deviceHeight * 0.30,
            child: Container(
                child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/Logo.png'),
              )),
            )),
          ),
          Container(
            height: deviceWidth * 0.65,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login Now',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.01,
                  ),
                  const Text('Please enter the details below to continue'),
                  SizedBox(
                    height: constraints.maxHeight * 0.08,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.11,
                    decoration: BoxDecoration(
                      color: const Color(0xffB4B4B4).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'test@gmail.com'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.11,
                    decoration: BoxDecoration(
                      color: const Color(0xffB4B4B4).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Center(
                        child: TextField(
                          obscureText: _isVisible ? false : true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                                icon: Icon(
                                  _isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                )),
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password ? ',
                            style: TextStyle(
                              color: Color(0xffF80849),
                            ),
                          ))
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: constraints.maxHeight * 0.11,
                    margin: EdgeInsets.only(
                      top: constraints.maxHeight * 0.01,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffF80849),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Don\'t have an Account ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          children: [
                        TextSpan(
                            text: 'Register',
                            style: const TextStyle(
                              color: Color(0xffF80849),
                              fontSize: 18,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ]))
                ],
              );
            }),
          )
        ],
      ),
    ));
  }
}
