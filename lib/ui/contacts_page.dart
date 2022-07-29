import 'dart:convert';
import 'package:custom_scroll/alphabet_scroll_listview/az_common.dart';
import 'package:custom_scroll/alphabet_scroll_listview/custom_scroll_listview.dart';
import 'package:custom_scroll/alphabet_scroll_listview/index_bar.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<ContactInfo> contactList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    List list = json.decode(stringData);
    for (var v in list) {
      contactList.add(ContactInfo.fromJson(v));
    }
    _handleList(contactList);
  }

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String tag = list[i].name.substring(0, 1).toUpperCase();
      list[i].namePinyin = list[i].name;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(contactList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(contactList);

    setState(() {});
  }

  static Widget getWeChatListItem(
    BuildContext context,
    ContactInfo model, {
    double susHeight = 40,
    Color? defHeaderBgColor,
  }) {
    return getWeChatItem(context, model, defHeaderBgColor: defHeaderBgColor);
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static Widget getWeChatItem(
    BuildContext context,
    ContactInfo model, {
    Color? defHeaderBgColor,
  }) {
    DecorationImage? image;
    return Container(
      margin: const EdgeInsets.only(right: 30),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4.0),
            color: model.bgColor ?? defHeaderBgColor,
            image: image,
          ),
          child: model.iconData == null
              ? null
              : Icon(
                  model.iconData,
                  color: Colors.white,
                  size: 20,
                ),
        ),
        title: Text(model.name),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFEDEDED),
        title: const Text(
          'List items',
          style: TextStyle(color: Color(0xFF171717)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Text('Sample'),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(onPressed: () {}, child: Text('Next Page')),
            ),
            AzListView(
              data: contactList,
              itemCount: contactList.length,
              itemBuilder: (BuildContext context, int index) {
                ContactInfo model = contactList[index];
                return getWeChatListItem(
                  context,
                  model,
                  defHeaderBgColor: const Color(0xFFE5E5E5),
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              indexBarData: SuspensionUtil.getTagIndexList(contactList),
              indexBarOptions: IndexBarOptions(
                needRebuild: true,
                ignoreDragCancel: true,
                downTextStyle: const TextStyle(fontSize: 12, color: Colors.white),
                downItemDecoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                indexHintWidth: 120 / 2,
                indexHintHeight: 100 / 2,
                indexHintDecoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(getImgPath('ic_index_bar_bubble_gray')),
                    fit: BoxFit.contain,
                  ),
                ),
                indexHintAlignment: Alignment.centerRight,
                indexHintChildAlignment: const Alignment(-0.25, 0.0),
                indexHintOffset: const Offset(-20, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final String stringData = '''[
  {
    "name": "Alice",
    "phone": [
      "18221338086"
    ]
  },
  {
    "name": "Stacy",
    "phone": [
      "18221338086"
    ]
  },
  {
    "name": "Bob",
    "phone": [
      "18221338086"
    ]
  },
  {
    "name": "David",
    "phone": [
      "18221338086"
    ]
  },
  {
    "name": "Jenny",
    "phone": [
      "18221338086"
    ]
  },
  {
    "name": "Zara",
    "phone": [
      "18221338086"
    ]
  },
  {
    "name": "Milly",
    "phone": [
      "18221338086"
    ]
  },
  {
    "name": "Yasmin",
    "phone": [
      "18221338086"
    ]
  }
]
''';

class ContactInfo extends ISuspensionBean {
  String name;
  String? tagIndex;
  String? namePinyin;

  Color? bgColor;
  IconData? iconData;

  String? img;
  String? id;
  String? firstletter;

  ContactInfo({
    required this.name,
    this.tagIndex,
    this.namePinyin,
    this.bgColor,
    this.iconData,
    this.img,
    this.id,
    this.firstletter,
  });

  ContactInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        img = json['img'],
        id = json['id']?.toString(),
        firstletter = json['firstletter'];

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);
}
