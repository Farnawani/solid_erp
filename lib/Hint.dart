import 'dart:convert';

Hint hintFromJson(String str) => Hint.fromJson(json.decode(str));

String hintToJson(Hint data) => json.encode(data.toJson());

class Hint {
  int id;
  String hint;

  Hint({this.id, this.hint});

  factory Hint.fromJson(Map<String, dynamic> json) => Hint(
    id: json["id"],
    hint: json["hint"],
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "hint": hint,
  };
}