import 'package:fastaval_app/config/models/food.dart';
import 'package:fastaval_app/config/models/scheduling.dart';
import 'package:fastaval_app/config/models/user.dart';
import 'package:fastaval_app/utils/services/rest_api_service.dart';
import 'package:fastaval_app/utils/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.appUser}) : super(key: key);
  final User appUser;
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
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          const SizedBox(height: 30.0),
                          buildIdIcon(),
                          buildUsermessages(),
                          buildUserProgram(),
                          buildFoodtimes(),
                          const Padding(padding: EdgeInsets.only(bottom: 80))
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

  Widget buildIdIcon() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Container(
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
        ),
        Text(
          'Deltager nummer',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildUsermessages() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            leading: const Icon(Icons.mail),
            title: const Text(
              'Beskeder Fra Fastaval',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            subtitle: Column(
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
                        messagesfromfastaval(),
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
    );
  }

  String messagesfromfastaval() {
    if (widget.appUser.messages == '') {
      return 'Fastaval har ingen beskeder til dig i nu';
    } else {
      return widget.appUser.messages.toString();
    }
  }

  buildUserProgram() => SizedBox(
        child: Card(
          margin: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: const Icon(Icons.food_bank),
              title: const Text(
                'Dit Program',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              subtitle: buildUsersProgram(widget.appUser.scheduling!),
            ),
          ),
        ),
      );

  Widget buildUsersProgram(List<Scheduling> schedul) {
    initializeDateFormatting('da_DK', null);

    return Container(
      padding: const EdgeInsets.only(top: 2, left: 10),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Hvornår',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Hvad',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Hvor',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                Spacer(),
                Spacer()
              ],
            ),
            Divider(height: 3),
            ListView.separated(
              shrinkWrap: true,
              itemCount: schedul.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                Scheduling item = schedul[index];
                return Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        DateFormat.EEEE('da_DK')
                                .format(unixtodatetime(item.start!)) +
                            ' ' +
                            DateFormat.Hm().format(unixtodatetime(item.start!)),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                        maxLines: 2,
                      ),
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
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Expanded(
                      flex: 3,
                      child: Text(
                        item.roomDa!,
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

  buildFoodtimes() => SizedBox(
        width: double.infinity,
        child: Card(
          margin: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.food_bank),
              title: const Text(
                'Mad tider',
                style: TextStyle(
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

  buildUserFood(List food) {
    return Container(
      padding: const EdgeInsets.only(top: 2, left: 10),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: food.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                Food item = food[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                          DateFormat.Hm().format(unixtodatetime(item.time!)) +
                              ' - ' +
                              DateFormat.Hm()
                                  .format(unixtodatetime(item.timeEnd!)),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                          )),
                    ),
                    // Expanded(
                    //   flex: 3,
                    //   child: Text(
                    //       DateFormat.Hm().format(unixtodatetime(item.timeEnd!)),
                    //       style: const TextStyle(
                    //         fontSize: 16,
                    //         color: Colors.black,
                    //         fontFamily: 'OpenSans',
                    //       )),
                    // ),
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
}

DateTime unixtodatetime(int timeInUnixTime) {
  return DateTime.fromMillisecondsSinceEpoch(timeInUnixTime * 1000);
}
