import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  Future addCampaign(CampaignModel campaignModel) async {
    if(campaignModel.id!.isNotEmpty){
      FirebaseFirestore.instance
          .collection("campaign").doc(campaignModel.id)
          .set(campaignModel.tojson());}
    else{
      FirebaseFirestore.instance.collection("campaign").add(campaignModel.tojson());
    }

  }

  getAllCampaign() async {
    List<CampaignModel> campaignList = [];
    var res = await FirebaseFirestore.instance.collection("campaign").get();
    res.docs.forEach((element) {
      print(element.data());
      CampaignModel camp = CampaignModel.fromjson(element.data());
      camp.id = element.id;
      campaignList.add(camp);
    });
    return campaignList;
  }

  Future<void> deleteCampaign(String s) async {
    await  FirebaseFirestore.instance.collection("campaign").doc(s).delete();
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
  CampaignModel(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.name2,
        this.userID,
        this.numberL,
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
        name2: json["name2"],
        userID: json["userID"],
        phone2: json["phone2"],
        username: json["username"],
        password: json["password"],
        confirmPassword: json["confirmPassword"]);
  }
}