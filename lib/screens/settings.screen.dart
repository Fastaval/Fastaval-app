import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/controllers/settings.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  SettingsScreen(this.appContext, {super.key});
  final store = Get.find<SettingsController>();

  final BuildContext appContext;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorOrangeDark,
        foregroundColor: colorWhite,
        toolbarHeight: 40,
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle,
        title: Text(tr('settings.title')),
      ),
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
                  child: Column(
                    children: [
                      settingsCard(
                          tr('common.language'), Icons.language, appContext)
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

  Widget settingsCard(String title, IconData icon, BuildContext context) {
    return Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        margin: kMenuCardMargin,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black12, width: 1)),
        elevation: 1,
        child: Column(children: [
          ListTile(
            trailing: DropdownButton(
                items: [
                  DropdownMenuItem(value: 'da', child: Text('Dansk')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                ],
                value: store.language.value,
                onChanged: (Object? value) => {
                      context.setLocale(Locale(value as String)),
                      store.updateLanguage(value)
                    }),
            title: Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Icon(icon)),
                Text(title, style: kMenuCardHeaderStyle),
                Text(' (${store.language.value})')
              ],
            ),
          )
        ]));
  }
}
