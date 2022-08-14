import 'dart:convert';

NftMetaData nftMetaDataFromJson(String str) =>
    NftMetaData.fromJson(json.decode(str));

String nftMetaDataToJson(NftMetaData data) => json.encode(data.toJson());

class NftMetaData {
  NftMetaData({
    required this.name,
    required this.date,
    required this.attributes,
    required this.description,
    required this.image,
  });

  String name;
  String date;
  String attributes;
  String description;
  String image;

  factory NftMetaData.fromJson(Map<String, dynamic> json) => NftMetaData(
        name: json["name"],
        date: json["date"],
        attributes: json["attributes"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "attributes": attributes,
        "description": description,
        "image": image,
      };
}
