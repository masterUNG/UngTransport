// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungtransport/models/response_false_model.dart';
import 'package:ungtransport/models/response_true_model.dart';
import 'package:ungtransport/models/user_model.dart';
import 'package:ungtransport/utility/my_constant.dart';
import 'package:ungtransport/utility/my_dialog.dart';
import 'package:ungtransport/widges/show_button.dart';
import 'package:ungtransport/widges/show_form_phone.dart';
import 'package:ungtransport/widges/show_image.dart';
import 'package:ungtransport/widges/show_text.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? yearRegis, phoneNumber;
  String gentype = 'M', infriendid = '';

  @override
  void initState() {
    super.initState();
    findYear();
  }

  void findYear() {
    DateTime dateTime = DateTime.now();
    int year = dateTime.year + 543;
    yearRegis = year.toString();
    // print('yearRegis = $yearRegis');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ShowText(
          label: 'สมัครสมาชิค ผ่าน Server',
          textStyle: MyConstant().h2Style(),
        ),
        elevation: 0,
        foregroundColor: MyConstant.dark,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: Container(
          decoration: MyConstant().imageBox(),
          child: Center(
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // const SizedBox(height: 48,),
                    SizedBox(
                      width: constraints.maxWidth * 0.75,
                      child: const ShowImage(
                        path: 'images/register.png',
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ShowText(
                        label: 'Year = $yearRegis',
                        textStyle: MyConstant().h2Style(),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ShowText(
                        label: 'GenType = $gentype',
                        textStyle: MyConstant().h2Style(),
                      ),
                    ),
                    ShowFormPhone(
                      label: 'Phone :',
                      iconData: Icons.phone_android,
                      changeFunc: (String string) {
                        phoneNumber = string.trim();
                      },
                    ),
                    ShowButton(
                        label: 'Register',
                        pressFunc: () {
                          if (phoneNumber?.isEmpty ?? true) {
                            MyDialog(context: context).normalDialog(
                                title: 'Phone ?',
                                subTitle: 'Please Fill Phone');
                          } else if (phoneNumber!.length != 10) {
                            MyDialog(context: context).normalDialog(
                                title: 'Phone 10 digi',
                                subTitle: 'Please Fill Phone 10 digi');
                          } else if (phoneNumber!.contains('')) {
                            MyDialog(context: context).normalDialog(
                                title: 'มีช่องว่างแทรก',
                                subTitle: 'ห้ามมีช่องว่างแทรก');
                          } else {
                            processRegister();
                          }
                        }),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> processRegister() async {
    // print('phoneNumber ==> $phoneNumber');

    UserModel userModel = UserModel(
        year: yearRegis!,
        gentype: gentype,
        phonenumber: phoneNumber!,
        infriendid: infriendid);

    Map<String, dynamic> map = userModel.toMap();
    // print('map ==> $map');

    await Dio().post(MyConstant.pathRegister, data: map).then((value) {
      print('Success Register value ==> $value');

      ResponseFalseModel responseFalseModel =
          ResponseFalseModel.fromMap(value.data);

      // print('responseFalseModel ==> ${responseFalseModel.toMap()}');

      if (responseFalseModel.ResponseStatus == 'Failed') {
        MyDialog(context: context).normalDialog(
            title: 'Cannot Register',
            subTitle: responseFalseModel.ResponseMessages);
      } else {
        //Register Success
        print('Register Success valuet ==> $value');
        ResponseTrueModel responseTrueModel =
            ResponseTrueModel.fromJson(value.data);

        print('responsTrueModel ==> ${responseTrueModel.toJson()}');

        MyDialog(context: context).normalDialog(
            title: 'Your Login',
            subTitle: 'โปรดเก็บค่านี่ไว้ Login in',
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShowText(
                    label:
                        'rollerid ==> ${responseTrueModel.responseData![0].rollerid}'),
                ShowText(
                    label:
                        'username ==> ${responseTrueModel.responseData![0].username}'),
                ShowText(
                    label:
                        'password ==> ${responseTrueModel.responseData![0].password}'),
              ],
            ),
            pressFunc: () {
              Navigator.pop(context);
              Navigator.pop(context);
            });
      }
    }).catchError((onError) {
      print('onError ==> ${onError.toString()}');
    });
  }
}
