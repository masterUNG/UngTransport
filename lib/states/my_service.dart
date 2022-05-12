import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungtransport/utility/my_constant.dart';
import 'package:ungtransport/utility/my_dialog.dart';
import 'package:ungtransport/widges/show_listtile.dart';
import 'package:ungtransport/widges/show_text.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String? token;

  @override
  void initState() {
    super.initState();
    findToken();
  }

  Future<void> findToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString(MyConstant.keyToken);
    print('token ที่ใช้งาน ==> $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                InkWell(
                  child: const ShowListTile(
                    title: 'ReadAPI',
                    subTitle: 'Read API by Token',
                    path: 'images/logo.png',
                    size: 36,
                  ),
                ),
                 InkWell(
                  child: const ShowListTile(
                    title: 'GetLocation',
                    subTitle: 'Get Location and show Map',
                    path: 'images/register.png',
                    size: 36,
                  ),
                ),
              ],
            ),
            newSignOut(context: context),
          ],
        ),
      ),
      body: ShowText(label: 'This is my Service'),
    );
  }

  Column newSignOut({required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            MyDialog(context: context).twoWayDialog(
                title: 'Confirm SignOut',
                subTitle: 'Are You Sure ?',
                label1: 'SignOut',
                label2: 'Cancel',
                pressFunc1: () {
                  processSignOut(context: context);
                },
                pressFunc2: () {
                  Navigator.pop(context);
                });
          },
          child: const ShowListTile(
              size: 48,
              title: 'SignOut',
              subTitle: 'Sign Out and Move To Authen',
              path: 'images/avatar.png'),
        ),
      ],
    );
  }

  Future<void> processSignOut({required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/authen', (route) => false);
    });
  }
}
