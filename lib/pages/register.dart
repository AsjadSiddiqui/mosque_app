import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../blocs/main_bloc.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();

  final Color blackColor = Colors.blue;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  bool checkedBox = false;
  bool isValidating = false;

  Future<void> validate() async {
    final String firstName = firstNameController.value.text.trim();
    final String lastName = lastNameController.value.text.trim();
    final String email = emailController.value.text.trim();
    final String password = passController.value.text;
    final MainBloc mb = Provider.of<MainBloc>(context, listen: false);

    // print('Validate !');
    if (isValidating) {
      print('Already Running !');
      return;
    } else if (firstName.isEmpty) {
      mb.showToast('Enter first name');
      return;
    } else if (lastName.isEmpty) {
      mb.showToast('Enter last name');
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
    } else if (password.length < 8) {
      mb.showToast('Password should be 8 characters long');
      return;
    } else if (!checkedBox) {
      mb.showToast('Please agree with the Terms and Conditions');
      return;
    }
    isValidating = true;

    _btnController.start();
    // await Future.delayed(Duration(seconds: 3));
    final String res = await mb.registerNewUser(
      firstName: firstName,
      lastName: lastName,
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
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: statusBarHeight),
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 0.15 * height,
                    ),
                    const Text(
                      'REGISTER',
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
                          lastNameFocusNode.requestFocus();
                        },
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: 'Montserrat',
                        ),
                        controller: firstNameController,
                        focusNode: firstNameFocusNode,
                        cursorColor: Colors.grey[800],
                        decoration: InputDecoration(
                          hintText: 'First Name',
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
                        onEditingComplete: () {
                          emailFocusNode.requestFocus();
                        },
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: 'Montserrat',
                        ),
                        controller: lastNameController,
                        focusNode: lastNameFocusNode,
                        cursorColor: Colors.grey[800],
                        decoration: InputDecoration(
                          hintText: 'Last Name',
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
                      height: 20,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.,
                      children: <Widget>[
                        SizedBox(
                          width: 0.075 * width,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              checkedBox = !checkedBox;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white.withOpacity(0.8),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 6,
                                  color: Colors.black.withOpacity(0.29),
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                color: Colors.grey[800].withOpacity(0.8),
                                child: checkedBox
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white.withOpacity(0.9),
                                        size: 30,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        const Text(
                          'I agree to the ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Terms and Conditions!');
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              'terms and conditions',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.04 * height,
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
                        'REGISTER',
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
                    Opacity(
                      opacity: 0.64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
