import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:world_countries/world_countries.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            // onLongPress: _onAppBarSearchPressed,
            child: IconButton(
              onPressed: openView,
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                Expanded(child: formFild(lable: "اسم الحملة")),
                SizedBox(
                  width: 48,
                ),
                Expanded(child: formFild(lable: "رقم هاتف الحملة")),
                SizedBox(
                  width: 48,
                ),
                Expanded(child: formFild(lable: "رقم التصريح")),
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
                Expanded(child: formFild(lable: "اسم مسؤول الحملة")),
                SizedBox(
                  width: 48,
                ),
                Expanded(
                    child: formFild(lable: "رقم الهوية الوطنية/رقم الاقامة")),
                SizedBox(
                  width: 48,
                ),
                Expanded(child: formFild(lable: "رقم مسؤول الحملة")),
              ],
            ),
            Row(
              children: [
                Expanded(child: formFild(lable: "اسم المستخدم")),
                SizedBox(
                  width: 48,
                ),
                Expanded(child: formFild(lable: "كلمة المرور")),
                SizedBox(
                  width: 48,
                ),
                Expanded(child: formFild(lable: "تاكيد كلمة المرور")),
              ],
            ),
            ElevatedButton(onPressed: () {}, child: Text('إنشاء')),
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
            Container(
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
                      child: Text("حملة النور",
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      child: Text("المملكة العربية السعودية",
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      child: Text("1234567",
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.more_vert))),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
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
                      child: Text("حملة النور",
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      child: Text("المملكة العربية السعودية",
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      child: Text("1234567",
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.more_vert))),
                ],
              ),
            ),
          ])),
    );
  }

  final CountryPicker basicPicker =
      const CountryPicker(disabled: [CountryAbw()]);

  /// Highly customizable, for example use itemBuilder param. for custom tiles.
  late CountryPicker picker = basicPicker.copyWith(onSelect: onSelect);

  void onSelect(WorldCountry newCountry) {
    debugPrint("New country selected: $selectedCountry");
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
}

Widget formFild(
    {String? lable,
    String initialValue = "",
    bool isLoading = false,
    double height = 60,
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
          minLines: height > 60 ? 4 : 1,
          maxLines: height > 60 ? 8 : 1,

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
