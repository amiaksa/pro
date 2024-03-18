import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:world_countries/world_countries.dart';

import 'firestore_service.dart';

List<Country> countries = [
  Country(
      name: "المملكة العربية السعودية",
      code: "saudi",
      icon: "assits/saudi_arabia_round_icon_256.png"),
  Country(
      name: "الكويت", code: "kuwait", icon: "assits/kuwait_round_icon_256.png"),
  Country(
      name: "البحرين",
      code: "bahrain",
      icon: "assits/bahrain_round_icon_256.png"),
  Country(name: "قطر", code: "qatar", icon: "assits/qatar_round_icon_256.png"),
  Country(
      name: "الامارات",
      code: "emirates",
      icon: "assits/united_arab_emirates_round_icon_256.png"),
  Country(name: "العراق", code: "iraq", icon: "assits/iraq_round_icon_256.png"),
  Country(
      name: "سلطنة عمان", code: "oman", icon: "assits/oman_round_icon_256.png"),
  Country(
      name: "الاردن", code: "jordan", icon: "assits/jordan_round_icon_256.png"),
];

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>
    with SingleTickerProviderStateMixin {
  List<WorldCountry> worldCountries = PhoneCodePicker().countries.toList();
  WorldCountry? selectedCode = null;
  WorldCountry? selectedCode2 = null;
  bool descending = false;
  String campaignIDEdit = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Country? selectedC = null;
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

  getCampaigns({bool descending = false}) async {
    FireStoreService fireStoreService = FireStoreService();
    campaigns = await fireStoreService.getAllCampaign(descending);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                            lable: "اسم الحملة",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل مطلوب";
                              }
                            },
                            controller: nameController)),
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                        child: formFild(
                            lable: "رقم هاتف الحملة",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل مطلوب";
                              }
                              return num.tryParse(value ?? "") != null
                                  ? null
                                  : "الرقم غير صحيح";
                            },
                            keyboardType: TextInputType.number,
                            suffixIcon: IconButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    // side:
                                    //     BorderSide(color: Colors.grey)
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: openView,
                              icon: SizedBox(
                                width: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: selectedCode == null
                                      ? [
                                          // const Icon(Icons.search),
                                          Text(
                                            "---",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ]
                                      : [
                                          Text(
                                            selectedCode!.codeNumeric ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                ),
                              ),
                            ),
                            controller: phoneController)),
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                        child: formFild(
                            lable: "البريد الالكتروني",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل مطلوب";
                              }
                              if (value.contains("@") == false) {
                                return "البريد الالكتروني غير صحيح";
                              }
                            },
                            controller: emailController)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: formFild(
                            lable: "رقم التصريح",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الرقم مطلوب";
                              }
                              return num.tryParse(value ?? "") != null
                                  ? null
                                  : "الرقم غير صحيح";
                            },
                            controller: numberLController)),
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                        child: DropdownButton<Country>(
                      value: selectedC == null ? null : selectedC,
                      items: countries.map((country) {
                        return DropdownMenuItem(
                          value: country,
                          child: Row(
                            children: [
                              CircleAvatar(
                                  backgroundImage: AssetImage(country!.icon)),
                              Text(country.name ?? "--"),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (Country? value) {
                        setState(() {
                          selectedC = value;
                        });
                      },
                    )),
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                      child: Container()
                      /* GestureDetector(
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
                              CircleAvatar(
                                  backgroundImage:
                                  AssetImage(selectedC!.icon)),
                              Text(
                                selectedC!.name ?? "",
                                style:
                                Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      )*/
                      ,
                    ),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل مطلوب";
                              }
                            },
                            controller: nameController2)),
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                        child: formFild(
                            lable: "رقم الهوية الوطنية/رقم الاقامة",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الرقم مطلوب";
                              }
                              return num.tryParse(value ?? "") != null
                                  ? null
                                  : "الرقم غير صحيح";
                            },
                            controller: userIDController)),
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                        child: formFild(
                            lable: "رقم مسؤول الحملة",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الرقم مطلوب";
                              }
                              return num.tryParse(value ?? "") != null
                                  ? null
                                  : "الرقم غير صحيح";
                            },
                            suffixIcon: IconButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    // side:
                                    //     BorderSide(color: Colors.grey)
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: openView2,
                              icon: SizedBox(
                                width: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: selectedCode2 == null
                                      ? [
                                          // const Icon(Icons.search),
                                          Text(
                                            "---",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ]
                                      : [
                                          Text(
                                            selectedCode2!.codeNumeric ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                ),
                              ),
                            ),
                            controller: phoneController2)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: formFild(
                            lable: "اسم المستخدم",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل مطلوب";
                              }
                            },
                            controller: usernameController)),
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                        child: formFild(
                            lable: "كلمة المرور",
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل مطلوب";
                              }
                              if (value.length < 8) {
                                return "كلمة المرور قصيرة";
                              }
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return "كلمة المرور غير متطابقة";
                              }
                            },
                            controller: passwordController)),
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                        child: formFild(
                            lable: "تاكيد كلمة المرور",
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل مطلوب";
                              }
                              if (value.length < 8) {
                                return "كلمة المرور قصيرة";
                              }
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return "كلمة المرور غير متطابقة";
                              }
                            },
                            controller: confirmPasswordController)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          CampaignModel campaignModel = CampaignModel();
                          campaignModel.name = nameController.text;
                          campaignModel.phone = phoneController.text;
                          campaignModel.email = emailController.text;
                          campaignModel.name2 = nameController2.text;
                          campaignModel.userID = userIDController.text;
                          campaignModel.phone2 = phoneController2.text;
                          campaignModel.username = usernameController.text;
                          campaignModel.password = passwordController.text;
                          campaignModel.numberL = numberLController.text;
                          campaignModel.confirmPassword =
                              confirmPasswordController.text;
                          campaignModel.id = campaignIDEdit;
                          campaignModel.country = selectedC?.code ?? "";
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
                        child: Text(campaignIDEdit.isNotEmpty
                            ? "حفظ التعديل"
                            : 'إنشاء')),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
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
                      PopupMenuButton(
                          child: Text("الترتيب" +
                              " : " +
                              (descending ? "حسب الأحدث" : "حسب الاقدم")),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  onTap: () {
                                    descending = true;
                                    getCampaigns(descending: descending);
                                  },
                                  child: Text("حسب الأحدث")),
                              PopupMenuItem(
                                onTap: () {
                                  descending = false;
                                  getCampaigns(descending: descending);
                                },
                                child: Text("حسب الاقدم"),
                              ),
                            ];
                          }),
                    ],
                  ),
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
                              child: element.country != null
                                  ? CircleAvatar(
                                      backgroundImage: AssetImage(countries
                                          .firstWhere((element2) =>
                                              element2.code == element.country)
                                          .icon),
                                    )
                                  : Icon(
                                      Icons.flag,
                                      color: Colors.white,
                                    ),
                            ),
                          )),
                          Expanded(
                              child: Text(element.name ?? "--",
                                  style:
                                      Theme.of(context).textTheme.bodyLarge)),
                          Expanded(
                              child: Text(
                                  countries
                                          .firstWhere((element2) =>
                                              element2.code == element.country)
                                          .name ??
                                      "--",
                                  style:
                                      Theme.of(context).textTheme.bodyLarge)),
                          Expanded(
                              child: Text(element.numberL ?? "--",
                                  style:
                                      Theme.of(context).textTheme.bodyLarge)),
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
                                    numberLController.text = element.numberL!;
                                    selectedC = countries.firstWhere(
                                      (element2) =>
                                          element2.code == element.country,
                                    );
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
                                  onPressed: () {},
                                  icon: Icon(Icons.more_vert))),
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
            ),
          )),
    );
  }

  final CountryPicker basicPicker =
      const CountryPicker(disabled: [CountryAbw()]);

  /// Highly customizable, for example use itemBuilder param. for custom tiles.
  late CountryPicker picker = basicPicker.copyWith(onSelect: onSelect);
  late CountryPicker picker2 = basicPicker.copyWith(onSelect: onSelect2);

  void onSelect(WorldCountry newCountry) {
    debugPrint("New country selected: $selectedCountry");
    // selectedC = newCountry;
    selectedCode = newCountry;
    setState(
      () => picker = picker.copyWith(
        // A copyWith methods in every picker.
        chosen: selectedCode == newCountry ? const [] : [newCountry],
      ),
    );
  }

  void onSelect2(WorldCountry newCountry) {
    // debugPrint("New country selected: $selectedCountry");
    selectedCode2 = newCountry;
    setState(
      () => picker2 = picker2.copyWith(
        // A copyWith methods in every picker.
        chosen: selectedCode2 == newCountry ? const [] : [newCountry],
      ),
    );
  }

  WorldCountry? get selectedCountry => picker.chosen?.firstOrNull;
  void openView() {
    /// Or for example: [LanguagePicker], [CurrencyPicker].
    final phonePicker = PhoneCodePicker.fromCountryPicker(picker);

    unawaited(phonePicker.showInDialog(context));
  }

  void openView2() {
    /// Or for example: [LanguagePicker], [CurrencyPicker].
    final phonePicker = PhoneCodePicker.fromCountryPicker(picker2);

    unawaited(phonePicker.showInDialog(context));
  }

  void resetForm() {
    campaignIDEdit = "";
    selectedC = null;
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
    Widget? suffixIcon,
    String? Function(String?)? validator,
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

          validator: validator == null ? null : validator!,

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
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: suffixIcon == null ? null : suffixIcon!,
          ),

          // onSaved: (PhoneNumber number) {
          //   print('On Saved: $number');
          // },
        ),
      ),
    ],
  );
}

class Country {
  String name;
  String icon;
  String code;
  Country({required this.name, required this.code, required this.icon});
}
