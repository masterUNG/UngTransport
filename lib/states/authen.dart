import 'package:flutter/material.dart';
import 'package:ungtransport/states/create_account.dart';
import 'package:ungtransport/utility/my_constant.dart';
import 'package:ungtransport/widges/show_button.dart';
import 'package:ungtransport/widges/show_form.dart';
import 'package:ungtransport/widges/show_image.dart';
import 'package:ungtransport/widges/show_text.dart';
import 'package:ungtransport/widges/show_text_button.dart';

class Authen extends StatelessWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newLeftSite(widget: newLogo(constraints)),
                  newLeftSite(widget: newText()),
                  newEmail(),
                  newPassword(),
                  newButton(),
                  newCreateAccount(context: context),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

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
                  builder: (context) => CreateAccount(),
                ));
          },
        )
      ],
    );
  }

  ShowButton newButton() => ShowButton(
        label: 'Login',
        pressFunc: () {},
      );

  ShowForm newPassword() {
    return ShowForm(
      label: 'Password :',
      iconData: Icons.lock_outline,
      obsecu: true,
      changeFunc: (String string) {},
    );
  }

  ShowForm newEmail() {
    return ShowForm(
      label: 'Email :',
      iconData: Icons.contact_mail_outlined,
      changeFunc: (String string) {},
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
}
