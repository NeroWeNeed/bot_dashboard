import 'package:bot_dashboard/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'login.dart';
import 'model.dart';

const API_INFO = 'assets/apis.json';
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserModel()),
    Provider(create: (context) => {APIInfo().init(File(API_INFO))})
  ], child: Main()));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: <String, WidgetBuilder>{
      '/': (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            actions: [Login()],
          ),
          drawer: Drawer(
              child: ListView(
            children: [
              const DrawerHeader(
                child: Text("Sample"),
              ),
              ListTile(
                title: Text("Sample2"),
              )
            ],
          )),
        );
      }
    });
  }
}
