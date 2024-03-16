import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:world_countries/world_countries.dart';

import 'firestore_service.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>
    with SingleTickerProviderStateMixin {
  List<WorldCountry> worldCountries = PhoneCodePicker().countries.toList();
  String campaignIDEdit = '';
  WorldCountry? selectedC = null;
  List<CampaignModel> campaigns = [];
  TextEditingController usernameController = TextEditingController();
  TextEditingController userIDController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberLController = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCampaigns();
  }

  getCampaigns() async {
    FireStoreService fireStoreService = FireStoreService();
    campaigns = await fireStoreService.getAllCampaign();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("إنشاء حساب الحملة",
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              Row(
                children: [
                  Text("معلومات الحملة",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: formFild(
                          lable: "اسم الحملة", controller: nameController)),
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                      child: formFild(
                          lable: "رقم هاتف الحملة",
                          controller: phoneController)),
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                      child: formFild(
                          lable: "البريد الالكتروني",
                          controller: emailController)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: formFild(
                          lable: "رقم التصريح", controller: numberLController)),

                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: GestureDetector(
                      // onLongPress: _onAppBarSearchPressed,
                      child: IconButton(
                        onPressed: openView,
                        icon: Row(
                          children: selectedC == null
                              ? [
                                  const Icon(Icons.search),
                                  Text(
                                    "الدولة",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ]
                              : [
                                  Text(selectedC!.emoji),
                                  Text(
                                    selectedC!.name.fullName??"",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                      child:Container()
                    /*DropdownButton<WorldCountry>(
                        value: selectedC == null ? null : selectedCountry,
                        items: worldCountries.map((country) {
                          return DropdownMenuItem(
                            value: country,
                            child: Row(
                              children: [
                                Text(country.emoji ?? "--"),
                                Text(country.name.fullName ?? "--"),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (WorldCountry? value) {
                          setState(() {
                            selectedC = value;
                          });
                        },
                      )*/),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text("معلومات مسؤول الحملة",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: formFild(
                          lable: "اسم مسؤول الحملة",
                          controller: nameController2)),
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                      child: formFild(
                          lable: "رقم الهوية الوطنية/رقم الاقامة",
                          controller: userIDController)),
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                      child: formFild(
                          lable: "رقم مسؤول الحملة",
                          controller: phoneController2)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: formFild(
                          lable: "اسم المستخدم",
                          controller: usernameController)),
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                      child: formFild(
                          lable: "كلمة المرور",
                          obscureText: true,
                          controller: passwordController)),
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                      child: formFild(
                          lable: "تاكيد كلمة المرور",
                          obscureText: true,
                          controller: confirmPasswordController)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        CampaignModel campaignModel = CampaignModel();
                        campaignModel.name = nameController.text;
                        campaignModel.phone = phoneController.text;
                        campaignModel.email = emailController.text;
                        campaignModel.name2 = nameController2.text;
                        campaignModel.userID = userIDController.text;
                        campaignModel.phone2 = phoneController2.text;
                        campaignModel.username = usernameController.text;
                        campaignModel.password = passwordController.text;
                        campaignModel.confirmPassword =
                            confirmPasswordController.text;
                        campaignModel.id = campaignIDEdit;
                        // campaignModel.save().then((value) {
                        //
                        // }
                        FireStoreService()
                            .addCampaign(campaignModel)
                            .then((value) {
                          resetForm();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("تم اضافة الحملة بنجاح"),
                          ));
                          getCampaigns();
                        });
                      },
                      child: Text(
                          campaignIDEdit.isNotEmpty ? "حفظ التعديل" : 'إنشاء')),
                  if (campaignIDEdit.isNotEmpty)
                    ElevatedButton(
                        onPressed: () {
                          resetForm();
                        },
                        child: Text("الغاء التعديل"))
                ],
              ),
              Divider(),
              Text("إدارة حسابات الحملات"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "ابحث هنا",
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Row(children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.grid_view_rounded)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.list_outlined))
                  ])
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                      child: Text("اسم الحملة",
                          style: Theme.of(context).textTheme.bodySmall)),
                  Expanded(
                      child: Text("الدولة",
                          style: Theme.of(context).textTheme.bodySmall)),
                  Expanded(
                      child: Text("رقم التصريح",
                          style: Theme.of(context).textTheme.bodySmall)),
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ...campaigns.map((element) => Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.teal.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.flag,
                              color: Colors.white,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Text(element.name ?? "--",
                                style: Theme.of(context).textTheme.bodyLarge)),
                        Expanded(
                            child: Text(element.name2 ?? "--",
                                style: Theme.of(context).textTheme.bodyLarge)),
                        Expanded(
                            child: Text(element.phone ?? "--",
                                style: Theme.of(context).textTheme.bodyLarge)),
                        PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                onTap: () {
                                  campaignIDEdit = element.id!;
                                  nameController.text = element.name!;
                                  phoneController.text = element.phone!;
                                  emailController.text = element.email!;
                                  nameController2.text = element.name2!;
                                  userIDController.text = element.userID!;
                                  phoneController2.text = element.phone2!;
                                  usernameController.text = element.username!;
                                  passwordController.text = element.password!;
                                  confirmPasswordController.text =
                                      element.confirmPassword!;
                                  setState(() {});
                                },
                                child: Text("تعديل")),
                            PopupMenuItem(
                              onTap: () {
                                FireStoreService()
                                    .deleteCampaign(element.id!)
                                    .then((value) => setState(() {
                                          campaigns.remove(element);
                                        }));
                              },
                              child: Text("حذف"),
                            ),
                          ];
                        }),
                        Expanded(
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.more_vert))),
                      ],
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(color: Colors.teal.withAlpha(50)),
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: CircleAvatar(
              //           backgroundColor: Colors.green,
              //           child: Icon(
              //             Icons.flag,
              //             color: Colors.white,
              //           ),
              //         ),
              //       )),
              //       Expanded(
              //           child: Text("حملة النور",
              //               style: Theme.of(context).textTheme.bodyLarge)),
              //       Expanded(
              //           child: Text("المملكة العربية السعودية",
              //               style: Theme.of(context).textTheme.bodyLarge)),
              //       Expanded(
              //           child: Text("1234567",
              //               style: Theme.of(context).textTheme.bodyLarge)),
              //       Expanded(
              //           child: IconButton(
              //               onPressed: () {}, icon: Icon(Icons.more_vert))),
              //     ],
              //   ),
              // ),
            ]),
          )),
    );
  }

  final CountryPicker basicPicker =
      const CountryPicker(disabled: [CountryAbw()]);

  /// Highly customizable, for example use itemBuilder param. for custom tiles.
  late CountryPicker picker = basicPicker.copyWith(onSelect: onSelect);

  void onSelect(WorldCountry newCountry) {
    debugPrint("New country selected: $selectedCountry");
    selectedC = newCountry;
    setState(
      () => picker = picker.copyWith(
        // A copyWith methods in every picker.
        chosen: selectedCountry == newCountry ? const [] : [newCountry],
      ),
    );
  }

  WorldCountry? get selectedCountry => picker.chosen?.firstOrNull;
  void openView() {
    /// Or for example: [LanguagePicker], [CurrencyPicker].
    final phonePicker = PhoneCodePicker.fromCountryPicker(picker);

    unawaited(phonePicker.showInDialog(context));
  }

  void resetForm() {
    campaignIDEdit = "";
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    numberLController.clear();
    nameController2.clear();
    userIDController.clear();
    phoneController2.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    setState(() {});
  }
}

Widget formFild(
    {String? lable,
    String? initialValue,
    bool isLoading = false,
    bool obscureText = false,
    double height = 50,
    TextEditingController? controller,
    TextInputType? keyboardType}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (lable != null) Text(lable ?? ""),
      if (lable != null)
        SizedBox(
          height: 8,
        ),
      Container(
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0x80C9C9C9)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 7,
              )
            ],
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: controller,
          minLines: height > 60 ? 4 : 1,
          maxLines: height > 60 ? 8 : 1,
obscureText: obscureText,
          onChanged: (String input) {
            // print(inputNumber);
            // phoneNumber = number;
            // number = inputNumber;

            // getPhoneNumber(number);
          },

          validator: (value) {
            // print(value);
            //  number = value;
          },

          // inputDecoration: InputDecoration(
          //   // labelText: 'Password',
          //   errorText: _errorMsg,
          // ),
          enabled: !isLoading,

          // autovalidateMode: AutovalidateMode.disabled,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
          initialValue: initialValue,
          // textFieldController: _mobileController,
          // formatInput: true,
          keyboardType: keyboardType ?? TextInputType.text,
          // inputBorder: const OutlineInputBorder(),
          // inputBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.black, width: 2)),
          decoration: const InputDecoration(border: InputBorder.none),

          // onSaved: (PhoneNumber number) {
          //   print('On Saved: $number');
          // },
        ),
      ),
    ],
  );
}
