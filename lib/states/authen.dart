// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungtransport/models/authen_model.dart';
import 'package:ungtransport/models/response_false_model.dart';
import 'package:ungtransport/models/success_authen_model.dart';
import 'package:ungtransport/states/regester.dart';
import 'package:ungtransport/utility/my_constant.dart';
import 'package:ungtransport/utility/my_dialog.dart';
import 'package:ungtransport/widges/show_button.dart';
import 'package:ungtransport/widges/show_form.dart';
import 'package:ungtransport/widges/show_image.dart';
import 'package:ungtransport/widges/show_text.dart';
import 'package:ungtransport/widges/show_text_button.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? rollerid, username, password;

  TextEditingController rollerIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    forTestAuthen();
  }

  void forTestAuthen() {
    rollerIdController.text = '6510000078';
    userNameController.text = '0818595305';
    passwordController.text = '864586';

    rollerid = rollerIdController.text;
    username = userNameController.text;
    password = passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Container(
            decoration: MyConstant().imageBox(),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    newLeftSite(widget: newLogo(constraints)),
                    newLeftSite(widget: newText()),
                    newRollerId(),
                    newUser(),
                    newPassword(),
                    newButton(),
                    newCreateAccount(context: context),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  ShowForm newRollerId() => ShowForm(
      controller: rollerIdController,
      textInputType: TextInputType.number,
      label: 'RollerId :',
      iconData: Icons.account_box_outlined,
      changeFunc: (String string) {
        rollerid = string.trim();
      });

  Row newLeftSite({required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: widget,
        ),
      ],
    );
  }

  Row newCreateAccount({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ShowText(label: 'Non Account ? '),
        ShowTextButton(
          label: 'Create Account',
          pressFunc: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Register(),
                ));
          },
        )
      ],
    );
  }

  ShowButton newButton() => ShowButton(
        label: 'Login',
        pressFunc: () {
          if ((rollerid?.isEmpty ?? true) ||
              (username?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            MyDialog(context: context).normalDialog(
                title: 'Have Space ?', subTitle: 'Please Fill Every Blank');
          } else {
            processCheckAuthen();
          }
        },
      );

  ShowForm newPassword() {
    return ShowForm(
      controller: passwordController,
      label: 'Password :',
      iconData: Icons.lock_outline,
      obsecu: true,
      changeFunc: (String string) {
        password = string.trim();
      },
    );
  }

  ShowForm newUser() {
    return ShowForm(
      controller: userNameController,
      textInputType: TextInputType.number,
      label: 'UserName :',
      iconData: Icons.contact_mail_outlined,
      changeFunc: (String string) {
        username = string.trim();
      },
    );
  }

  ShowText newText() {
    return ShowText(
      label: 'Login :',
      textStyle: MyConstant().h1Style(),
    );
  }

  Row newLogo(BoxConstraints constraints) {
    return Row(
      children: [
        SizedBox(
          width: constraints.maxWidth * 0.3,
          child: const ShowImage(),
        ),
      ],
    );
  }

  Future<void> processCheckAuthen() async {
    AuthenModel authenModel = AuthenModel(
        rollerid: rollerid!, username: username!, password: password!);
    print('authan ==> ${authenModel.toMap()}');
    await Dio()
        .post(MyConstant.pathAuthen, data: authenModel.toMap())
        .then((value) {
      print('value authen ==> ${value}');

      ResponseFalseModel responseFalseModel =
          ResponseFalseModel.fromMap(value.data);
      print('ResponseStatus ==>> ${responseFalseModel.ResponseStatus}');

      if (responseFalseModel.ResponseStatus == 'Failed') {
        MyDialog(context: context).normalDialog(
            title: 'Login False',
            subTitle: responseFalseModel.ResponseMessages);
      } else {
        SuccessAuthenModel successAuthenModel =
            SuccessAuthenModel.fromJson(value.data);
        processSaveUser(successAuthenModel: successAuthenModel);
      }
    }).catchError((onError) {
      print('onError Authen ==> ${onError.toString()}');
    });
  }

  Future<void> processSaveUser(
      {required SuccessAuthenModel successAuthenModel}) async {
    String token = successAuthenModel.responseData![0].token.toString();
    print('token ==>> $token');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(MyConstant.keyRollerId, rollerid!);
    preferences.setString(MyConstant.keyUserName, username!);
    preferences.setString(MyConstant.keyPassword, password!);
    preferences.setString(MyConstant.keyToken, token);

    Navigator.pushNamedAndRemoveUntil(context, '/myService', (route) => false);
  }
}
