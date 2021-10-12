import 'package:bot_dashboard/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'model.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
        builder: (context, model, child) => Stack(children: [
              if (model.sessionId == null)
                IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () => {showLoginOptions(context)})
              else
                IconButton(icon: Icon(Icons.access_alarm), onPressed: () => {})
            ]));
  }

  showLoginOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(child: LoginOptions());
        });
  }
}

class LoginOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<APIInfo>(
        builder: (context, model, child) => ListView(
            scrollDirection: Axis.horizontal,
            children: model.entries.map((e) => e.getIcon()).toList()));
  }
}
