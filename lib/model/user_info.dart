import 'dart:convert';

List<UserInfoRes> userInfoResFromJson(String str) => List<UserInfoRes>.from(
    json.decode(str).map((x) => UserInfoRes.fromJson(x)));

String userInfoResToJson(List<UserInfoRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserInfoRes {
  UserInfoRes({
    this.id,
    this.userName,
    this.password,
    this.profileImg,
    this.name,
    this.email,
    this.phone,
    this.direction,
    this.lat,
    this.lon,
    this.storeId,
  });

  String? id;
  String? userName;
  String? password;
  String? profileImg;
  String? name;
  String? email;
  String? phone;
  String? direction;
  String? lat;
  String? lon;
  String? storeId;

  factory UserInfoRes.fromJson(Map<String, dynamic> json) => UserInfoRes(
        id: json["id"],
        userName: json["userName"],
        password: json["password"],
        profileImg: json["profileImg"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        direction: json["direction"],
        lat: json["lat"],
        lon: json["lon"],
        storeId: json["storeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "password": password,
        "profileImg": profileImg,
        "name": name,
        "email": email,
        "phone": phone,
        "direction": direction,
        "lat": lat,
        "lon": lon,
        "storeId": storeId,
      };
}
