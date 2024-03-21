import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro/create.dart';

class FireStoreService {
  Future addCampaign(CampaignModel campaignModel) async {
    if (campaignModel.id!.isNotEmpty) {
      campaignModel.edit = true;
      campaignModel.updatedAt = Timestamp.now();
      FirebaseFirestore.instance
          .collection("campaign")
          .doc(campaignModel.id)
          .set(campaignModel.tojson());
    } else {
      campaignModel.edit = false;
      FirebaseFirestore.instance
          .collection("campaign")
          .add(campaignModel.tojson());
    }
  }

  getAllCampaign(bool descending) async {
    List<CampaignModel> campaignList = [];
    var res = await FirebaseFirestore.instance
        .collection("campaign")
        .orderBy("createdAt", descending: descending)
        .get();
    res.docs.forEach((element) {
      print(element.data());
      CampaignModel camp = CampaignModel.fromjson(element.data());
      camp.id = element.id;
      campaignList.add(camp);
    });
    return campaignList;
  }

  Future<int> getCampaignCounts() async {
    var res = await FirebaseFirestore.instance.collection("campaign").get();
    return res.docs.length;
  }

  Future<int> getPilgrimsCounts() async {
    var res = await FirebaseFirestore.instance.collection("pilgrims").get();
    return res.docs.length;
  }

  Future<void> deleteCampaign(String s) async {
    await FirebaseFirestore.instance.collection("campaign").doc(s).delete();
  }

  Future<bool> login(String s, String t) async {
    var res = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: s)
        .where("password", isEqualTo: t)
        .get();
    Map<String, dynamic> map = res.docs.length > 0 ? res.docs[0].data() : {};
    if (map.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

class CampaignModel {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? name2;
  String? userID;
  String? numberL;
  String? phone2;
  String? username;
  String? password;
  String? confirmPassword;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  // Timestamp? deletedAt;
  bool edit = false;

  String? country;
  CampaignModel(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.name2,
      this.country,
      this.userID,
      this.numberL,
      this.createdAt,
      this.updatedAt,
      // this.deletedAt,
      this.edit = false,
      this.phone2,
      this.username,
      this.password,
      this.confirmPassword});

  save() {}
  tojson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "name2": name2,
        "updatedAt": updatedAt,
        // "deletedAt": deletedAt,
        "edit": edit,
        "country": country,
        "createdAt": createdAt,
        "userID": userID,
        "numberL": numberL,
        "phone2": phone2,
        "username": username,
        "password": password,
        "confirmPassword": confirmPassword
      };
  factory CampaignModel.fromjson(Map<String, dynamic> json) {
    return CampaignModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        numberL: json["numberL"],
        country: json["country"],
        createdAt: json["createdAt"] ?? Timestamp.now(),
        updatedAt: json["updatedAt"] == null ? Timestamp.now() : json["updatedAt"],
        // deletedAt: json["deletedAt"] == null ? null: json["deletedAt"],
        edit: json["edit"] ?? false,
        name2: json["name2"],
        userID: json["userID"],
        phone2: json["phone2"],
        username: json["username"],
        password: json["password"],
        confirmPassword: json["confirmPassword"]);
  }
}
