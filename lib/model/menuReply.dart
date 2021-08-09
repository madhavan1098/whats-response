import 'package:flutter/cupertino.dart';

class Menureply {
  final int id;
  final String message;

  Menureply({
    @required this.id,
    @required this.message,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Menureply{id: $id, message: $message}';
  }
}