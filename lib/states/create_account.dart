import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungtransport/utility/my_constant.dart';
import 'package:ungtransport/utility/my_dialog.dart';
import 'package:ungtransport/widges/show_button.dart';
import 'package:ungtransport/widges/show_form.dart';
import 'package:ungtransport/widges/show_icon_button.dart';
import 'package:ungtransport/widges/show_image.dart';
import 'package:ungtransport/widges/show_text.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  var typeUsers = MyConstant.typeUsers;
  String? typeUser;
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ShowText(
          label: 'Create New Account',
          textStyle: MyConstant().h2Style(),
        ),
        elevation: 0,
        foregroundColor: MyConstant.dark,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          newCenter(
            widget: newAvatar(),
          ),
          newCenter(
            widget: ShowForm(
              label: 'Name :',
              iconData: Icons.fingerprint,
              changeFunc: (String string) {},
            ),
          ),
          newCenter(widget: newTypeUser()),
          newCenter(
            widget: ShowForm(
              label: 'Email :',
              iconData: Icons.email_outlined,
              changeFunc: (String string) {},
            ),
          ),
          newCenter(
            widget: ShowForm(
              obsecu: true,
              label: 'Password :',
              iconData: Icons.lock_outline,
              changeFunc: (String string) {},
            ),
          ),
          newCenter(
            widget: ShowForm(
              obsecu: true,
              label: 'Re-Password :',
              iconData: Icons.lock,
              changeFunc: (String string) {},
            ),
          ),
          newCenter(
            widget: ShowButton(
              label: 'Create New Account',
              pressFunc: () {
                if (file == null) {
                  MyDialog(context: context).normalDialog(
                      title: 'Non Avatar ?', subTitle: 'Please Take Agatar');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget newTypeUser() {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.only(top: 16),
      decoration: MyConstant().curveBorderBox(),
      width: 250,
      height: 40,
      child: DropdownButton<dynamic>(
          hint: const ShowText(label: 'Please Choose TypeUser'),
          value: typeUser,
          items: typeUsers
              .map(
                (e) => DropdownMenuItem(
                  child: ShowText(label: e),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              typeUser = value.toString();
            });
          }),
    );
  }

  Widget newAvatar() {
    return Container(
      margin: const EdgeInsets.only(top: 36, bottom: 16),
      width: 250,
      height: 250,
      child: Stack(
        children: [
          file == null
              ? const ShowImage(
                  path: 'images/avatar.png',
                )
              : CircleAvatar(
                  radius: 200,
                  backgroundImage: FileImage(file!),
                ),
          Positioned(
            right: 0,
            bottom: 0,
            child: ShowIconButton(
              size: 48,
              iconData: Icons.add_a_photo,
              pressFunc: () {
                MyDialog(context: context).twoWayDialog(
                    title: 'Choose Avatar ?',
                    subTitle: 'Please tap Camera or Gallery',
                    label1: 'Camera',
                    pressFunc1: () {
                      Navigator.pop(context);
                      processTakePhoto(source: ImageSource.camera);
                    },
                    label2: 'Gallery',
                    pressFunc2: () {
                      Navigator.pop(context);
                      processTakePhoto(source: ImageSource.gallery);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> processTakePhoto({required ImageSource source}) async {
    var result = await ImagePicker().pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (result != null) {
      file = File(result.path);
      setState(() {});
    }
  }

  Row newCenter({required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget,
      ],
    );
  }
}
