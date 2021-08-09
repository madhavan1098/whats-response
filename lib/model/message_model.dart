import 'dart:convert';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(
    json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  MessageModel({
    this.message,
    this.time,
    this.name
  });

  String message;
  String time;
  String name;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"] == null ? null : json["message"],
        time: json["time"] == null ? null : json["time"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "time": time == null ? null : time,
        "name": name == null ? null : name,
      };
}
