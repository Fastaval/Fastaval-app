import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.dart';
import 'package:fastaval_app/screens/home.dart';
import 'package:fastaval_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/notification.dart';

class LoginScreen extends StatefulWidget {
  final HomePageState parent;
  const LoginScreen(this.parent, {Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: backgroundBoxDecorationStyle,
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 120.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        tr('login.signIn'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildUserIdInput(),
                      const SizedBox(height: 30.0),
                      _buildPasswordInput(),
                      // _buildForgotPasswordBtn(),
                      const SizedBox(height: 30.0),
                      _buildLoginButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
        onPressed: () =>
            fetchUser(userIdController.text, passwordController.text)
                .then((newUser) => scheduleMicrotask(() {
                      newUser.password = passwordController.text;
                      UserService().setUser(newUser);
                      UserService().registerToInfosys(context, newUser);
                      UserNotification(loggedIn: true, user: newUser)
                          .dispatch(context);
                    }))
                .onError((error, stackTrace) =>
                    Fluttertoast.showToast(msg: tr('error.login'))),
        child: Text(
          tr('login.signIn'),
          style: const TextStyle(
            color: Colors.deepOrange,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(tr('login.password'), style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kTextBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            keyboardType: TextInputType.number,
            obscureText: true,
            style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(Icons.lock, color: Colors.white),
              hintText: tr('login.enterPassword'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserIdInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(tr('login.participantNumber'), style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kTextBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: userIdController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(Icons.portrait, color: Colors.white),
              hintText: tr('login.enterParticipantNumber'),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
