import 'package:flutter/material.dart';
import 'package:ungtransport/utility/my_constant.dart';
import 'package:ungtransport/widges/show_image.dart';
import 'package:ungtransport/widges/show_text.dart';

class ShowListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String path;
  const ShowListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 80,
        child: ShowImage(
          path: path,
        ),
      ),
      title: ShowText(
        label: title,
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowText(label: subTitle),
    );
  }
}
