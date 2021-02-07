import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../blocs/main_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passFocusNode = FocusNode();

  final Color blackColor = Colors.blue;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  bool isValidating = false;

  Future<void> validate() async {
    final String email = emailController.value.text.trim();
    final String password = passController.value.text;
    final MainBloc mb = Provider.of<MainBloc>(context, listen: false);

    if (isValidating) {
      print('Already Running !');
      return;
    } else if (email.isEmpty) {
      mb.showToast('Enter email');
      return;
    } else if (!(email.contains('@') && email.contains('.'))) {
      mb.showToast('Enter a proper email');
      return;
    } else if (password.isEmpty) {
      mb.showToast('Enter password');
      return;
    }
    isValidating = true;

    _btnController.start();
    final String res = await mb.signInUser(
      email: email,
      password: password,
    );
    if (res != 'ok') {
      _btnController.error();
      await Future<Duration>.delayed(const Duration(seconds: 1));
      _btnController.reset();
      isValidating = false;
      await mb.showToast(res);
    } else {
      _btnController.success();
      await Future<Duration>.delayed(const Duration(seconds: 1));
      // _btnController.reset();
      isValidating = false;
      // Navigate !!!!
      Navigator.of(context).pushNamedAndRemoveUntil('/countries', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double height = MediaQuery.of(context).size.height - statusBarHeight;
    final double width = MediaQuery.of(context).size.width;
    final MainBloc mainBloc = Provider.of<MainBloc>(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.only(top: statusBarHeight),
          width: width,
          height: height,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0.15 * height,
                  ),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 0.2 * height,
                  ),
                  Container(
                    width: 0.85 * width,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.29),
                        ),
                      ],
                    ),
                    child: TextField(
                      onEditingComplete: () {
                        passFocusNode.requestFocus();
                      },
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Montserrat',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      focusNode: emailFocusNode,
                      cursorColor: Colors.grey[800],
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: 'Montserrat',
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: const Color(0xFFFFFFFF).withOpacity(0.31),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: const Color(0xFFFFFFFF).withOpacity(0.61),
                          ),
                        ),
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.61),
                          ),
                        ),
                        // alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 0.85 * width,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.29),
                        ),
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Montserrat',
                      ),
                      controller: passController,
                      focusNode: passFocusNode,
                      cursorColor: Colors.grey[800],
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: 'Montserrat',
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: const Color(0xFFFFFFFF).withOpacity(0.31),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: const Color(0xFFFFFFFF).withOpacity(0.61),
                          ),
                        ),
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.61),
                          ),
                        ),
                        // alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.3 * height,
                  ),
                  RoundedLoadingButton(
                    animateOnTap: false,
                    loaderSize: 55,
                    loaderStrokeWidth: 4,
                    height: 72,
                    width: 0.85 * width,
                    borderRadius: 0.85 * width / 2,
                    onPressed: validate,
                    controller: _btnController,
                    color: Colors.white.withOpacity(0.3),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Opacity(
                      opacity: 0.64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pushNamed('/forgotPassword');
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'Forgot Password ',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'Montserrat',
                                  // fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            '|',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Montserrat',
                              // fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/register');
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                ' Create an account',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'Montserrat',
                                  // fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
