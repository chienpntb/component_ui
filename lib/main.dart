import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/base/account_helper.dart';
import 'package:flutter_application_2/base/storage_service.dart';
import 'package:flutter_application_2/model/user/user_info_dto.dart';
import 'package:flutter_application_2/screen/ExpendTypeManagement/%C4%90M/dm_view.dart';
import 'package:flutter_application_2/screen/ExpendTypeManagement/KB/kb_view.dart';
import 'package:flutter_application_2/screen/ExpendTypeManagement/XL/xen_lo_view.dart';
import 'package:flutter_application_2/screen/ExpendTypeManagement/ZH/zh_view.dart';
import 'package:flutter_application_2/screen/login/login_view.dart';
import 'package:se_gay_components/common/sg_text.dart';
import 'package:se_gay_components/web_base/sg_sidebar/sg_sidebar.dart';
import 'package:se_gay_components/web_base/sg_web_base.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: MyHomePage(
        //   title: 's',
        // ));
        home: const LoginView());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int selectedIndex = 0;
  int subSelectedIndex = -1; // -1 means no sub menu selected

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Widget _getBodyWidget() {
    switch (selectedIndex) {
      case 0: // Home
        return const NewWidget();
      case 1: // Category
        switch (subSelectedIndex) {
          case 0: // H
            return const NewWidget();
          case 1: // M
            return const NewWidget2();
          default:
            return const Center(
              child: SGText(text: "Please select a sub category"),
            );
        }
      case 2: // Category
        switch (subSelectedIndex) {
          case 0: // H
            return const ZHView();
          case 1: // M
            return const KBView();
          case 2: // M
            return const DMView();
          case 3: // M
            return const XenLoView();
          default:
            return const Center(
              child: SGText(text: "Please select a sub category"),
            );
        }
      default:
        return const NewWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final menuItems =  [
      const MenuItem(icon: Icons.abc, label: "Home", idMenu: "Home"),
      const MenuItem(icon: Icons.cabin, label: "Category", children: [
        MenuItem(icon: Icons.abc, label: "Home", idMenu: "H"),
        MenuItem(icon: Icons.abc, label: "Home", idMenu: "M")
      ]),
      const MenuItem(icon: Icons.cabin, label: "ExpendType Management", children: [
        MenuItem(icon: Icons.abc, label: "ZH", idMenu: "ZH"),
        MenuItem(icon: Icons.abc, label: "KB", idMenu: "KB"),
        MenuItem(icon: Icons.abc, label: "ĐM", idMenu: "ĐM"),
        MenuItem(icon: Icons.abc, label: "Xén lò", idMenu: "XL"),
      ]),
    ];
    UserInfoDTO? userInfoDTO = AccountHelper.instance.getUserInfo();
    if (userInfoDTO != null && userInfoDTO.role == "ADMIN") {
      menuItems.insert(0, const MenuItem(icon: Icons.ac_unit_sharp, label: "User"));
    }
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SGWebBase(
          name: "SGDash",
          menuItems: menuItems,
          selectedIndex: selectedIndex,
          onItemSelected: (index, [subIndex]) {
            selectedIndex = index;
            subSelectedIndex = subIndex ?? -1;
            log('message: $selectedIndex $subSelectedIndex');
            setState(() {});
          },
          body: _getBodyWidget(),
        ));
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SGText(
        text: "HelloWorld",
      ),
    );
  }
}

class NewWidget2 extends StatelessWidget {
  const NewWidget2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SGText(
        text: "HelloWorld",
      ),
    );
  }
}
