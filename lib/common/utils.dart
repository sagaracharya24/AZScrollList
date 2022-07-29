import 'package:custom_scroll/common/models.dart';
import 'package:custom_scroll/ui/contacts_page.dart';
import 'package:flutter/material.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static Widget getSusItem(BuildContext context, String tag, {double susHeight = 40}) {
    if (tag == '★') {
      tag = '★';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  static Widget getListItem(BuildContext context, CityModel model, {double susHeight = 40}) {
    return ListTile(
      title: Text(model.name),
      onTap: () {
        Utils.showSnackBar(context, 'onItemClick : ${model.name}');
      },
    );
  }
}
