import 'dart:convert';

Vote welcomeFromJson(String str) => Vote.fromJson(json.decode(str));

String welcomeToJson(Vote data) => json.encode(data.toJson());

class Vote {
  Vote({
    this.voteA,
    this.voteB,
  });

  int? voteA;
  int? voteB;

  factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        voteA: json["voteA"],
        voteB: json["voteB"],
      );

  Map<String, dynamic> toJson() => {
        "voteA": voteA,
        "voteB": voteB,
      };
}
