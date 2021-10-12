import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class APIInfo {
  Set<APIInfoEntry> _entries = Set();
  bool _initialized = false;
  late UnmodifiableSetView<APIInfoEntry> entries;

  Future<Iterable<APIInfoEntry>> _loadEntries(File file) async {
    return await file
        .readAsString()
        .then((value) => {(jsonDecode(value) as Map<String, dynamic>)['apis']})
        .then((value) =>
            value.map((e) => APIInfoEntry.fromJson(e as Map<String, dynamic>)));
  }

  APIInfo init(File file) {
    if (!_initialized) {
      var loadedEntries = _loadEntries(file);
      loadedEntries.then((value) => _entries.addAll(value));
      entries = UnmodifiableSetView(_entries);
      _initialized = true;
    }
    return this;
  }
}

enum APIType { discord, slack }

class APIInfoEntry {
  final String name;
  final String clientId;
  final String clientSecret;
  final String oauthUrl;
  final APIType type;
  APIInfoEntry(
      this.name, this.clientId, this.clientSecret, this.oauthUrl, this.type);
  APIInfoEntry.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        clientId = json['client_id'],
        clientSecret = json['client_secret'],
        oauthUrl = json['oauth'],
        type = json['type'];
  String _getIconPath() {
    switch (type) {
      case APIType.discord:
        return 'assets/discord.svg';
      case APIType.slack:
        return 'assets/slack.svg';
    }
  }

  Widget getIcon() {
    return SvgPicture.asset(_getIconPath(), semanticsLabel: type.toString());
  }
}
