import 'dart:convert';

import 'package:flutter/material.dart';

MoreModel moreModelFromJson(String str) => MoreModel.fromJson(json.decode(str));

String moreModelToJson(MoreModel data) => json.encode(data.toJson());

class MoreModel {
  MoreModel({
    this.name,
    this.icon,
  });

  String name;
  IconData icon;

  factory MoreModel.fromJson(Map<String, dynamic> json) => MoreModel(
        name: json["name"] == null ? null : json["name"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "icon": icon == null ? null : icon,
      };
}
