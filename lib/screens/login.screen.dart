import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/controllers/app.controller.dart';
import 'package:fastaval_app/controllers/notification.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final appController = Get.find<AppController>();
  final notificationController = Get.find<NotificationController>();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorOrangeDark,
        foregroundColor: colorWhite,
        toolbarHeight: 25,
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle,
        title: Text(tr('screenTitle.login')),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: backgroundBoxDecorationStyle,
          child: Padding(
            padding: EdgeInsets.fromLTRB(48, 100, 48, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildUserIdInput(),
                SizedBox(height: 16.0),
                _buildPasswordInput(),
                SizedBox(height: 48.0),
                _buildLoginButton(),
                SizedBox(height: 16.0),
                Text(tr('login.helpTitle'), style: kLabelStyle),
                Text(textAlign: TextAlign.center, tr('login.helpText')),
              ],
            ),
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
        onPressed: () async => {
          await appController.login(
              userIdController.text, passwordController.text),
          if (appController.loggedIn.value == true)
            notificationController.getNotificationsAndSetWaiting(),
        },
        child: Text(
          tr('login.signIn'),
          style: const TextStyle(
            color: Colors.deepOrange,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
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
            style: const TextStyle(color: Colors.white),
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
            style: const TextStyle(color: Colors.white),
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
