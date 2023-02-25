import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/models/food.dart';
import 'package:fastaval_app/config/models/scheduling.dart';
import 'package:fastaval_app/config/models/user.dart';
import 'package:fastaval_app/constants/styleconstants.dart';
import 'package:fastaval_app/modules/notifications/login_notification.dart';
import 'package:fastaval_app/utils/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

Widget buildThreeSideBySideTexts(String left, String center, String right) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Text(
          left,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          maxLines: 2,
        ),
      ),
      Expanded(
        flex: 3,
        child: Text(
          center,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Text(
          right,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          maxLines: 2,
        ),
      ),
    ],
  );
}

Widget buildUserProgramRow(Scheduling item) {
  return buildThreeSideBySideTexts(
      '${DateFormat.EEEE('da_DK').format(unixToDateTime(item.start!))} ${DateFormat.Hm().format(unixToDateTime(item.start!))}',
      item.titleDa!,
      item.roomDa!);
}

DateTime unixToDateTime(int timeInUnixTime) {
  return DateTime.fromMillisecondsSinceEpoch(timeInUnixTime * 1000);
}

class ProfileScreen extends StatefulWidget {
  final User appUser;
  const ProfileScreen({Key? key, required this.appUser}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFF9800),
                      Color(0xFFFB8c00),
                      Color(0xFFF57C00),
                      Color(0xFFEF6c00),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          buildIdIcon(),
                          buildUserMessages(),
                          buildUserProgram(),
                          if (widget.appUser.food!.isNotEmpty) buildFoodTimes(),
                          const SizedBox(height: 30.0),
                          buildLogoutBtn(),
                          const SizedBox(height: 30.0),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFoodTimes() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: kCardMargin,
        elevation: 5,
        child: Padding(
          padding: kCardPadding,
          child: ListTile(
            trailing: const Icon(Icons.fastfood),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            title: Text(
              tr('profile.foodTimes'),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            subtitle: buildUserFood(widget.appUser.food!),
          ),
        ),
      ),
    );
  }

  Widget buildIdIcon() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Text(
            widget.appUser.id.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 58,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        Text(
          tr('profile.participantNumber'),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildUserFood(List food) {
    return Container(
      padding: const EdgeInsets.only(top: 2, left: 10),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: food.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                Food item = food[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                          '${DateFormat.Hm().format(unixToDateTime(item.time!))} - ${DateFormat.Hm().format(unixToDateTime(item.timeEnd!))}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                          )),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Expanded(
                      flex: 3,
                      child: Text(
                        item.titleDa!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildUserMessages() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: kCardMargin,
        elevation: 5,
        child: Padding(
          padding: kCardPadding,
          child: ListTile(
            trailing: const Icon(Icons.speaker_notes),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            title: Text(
              tr('profile.messagesFromFastaval'),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 2, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          messagesFromFastaval(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserProgram() {
    return SizedBox(
      child: Card(
        margin: kCardMargin,
        elevation: 5,
        child: Padding(
          padding: kCardPadding,
          child: ListTile(
            trailing: const Icon(Icons.calendar_view_day),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            title: Text(
              tr('profile.yourProgram'),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 2, left: 10),
              child: buildUsersProgram(widget.appUser.scheduling!),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUsersProgram(List<Scheduling> schedule) {
    initializeDateFormatting('da_DK', null);

    return SafeArea(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          buildThreeSideBySideTexts(
              tr('profile.when'), tr('profile.what'), tr('profile.where')),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: schedule.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              Scheduling item = schedule[index];
              return buildUserProgramRow(item);
            },
          )
        ],
      ),
    );
  }

  String messagesFromFastaval() {
    return widget.appUser.messages ?? tr('profile.noMessagesRightNow');
  }

  Widget buildLogoutBtn() {
    return Padding(
        padding: const EdgeInsets.all(40),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () => {
              UserService().removeUser(),
              LoginNotification(loggedIn: false, user: null).dispatch(context)
            },
            child: Text(
              tr('login.signOut'),
              style: const TextStyle(
                color: Colors.deepOrange,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ));
  }
}
