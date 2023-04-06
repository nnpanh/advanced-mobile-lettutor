import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/config/router.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:lettutor/utils/validation_extension.dart';
import 'package:lettutor/view/common_widgets/chip_dropdown.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/settings/widget/required_label.dart';

import '../../const/const_value.dart';
import '../../model/user/user_model.dart';
import '../common_widgets/elevated_button.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _txtCountry = TextEditingController();
  final _txtBirthday = TextEditingController();
  String? _txtLevel;
  final List<DropdownMenuItem<String>> _levelList = [];
  final UserModel userModel = testUser();

  @override
  void initState() {
    super.initState();
    _txtCountry.text = userModel.country ?? "";
    if (userModel.birthday != null) {
      _txtBirthday.text = userModel.birthday!;
    }
    for (var element in ConstValue.levelList) {
      _levelList.add(DropdownMenuItem(
        value: element,
        child: Text(element),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarDefault(MyRouter.account, context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          radius: 62,
                          foregroundImage: NetworkImage(userModel.avatar ?? ""),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 2)),
                          margin: const EdgeInsets.only(left: 100),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.photo_camera,
                              color: Colors.blue,
                            ),
                            iconSize: 24,
                          )),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: Text(
                  '${userModel.name}',
                  style: headLineSmall(context),
                  // textAlign: TextAlign.start,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 24, right: 4),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'ID: ',
                            style: bodyLarge(context)?.copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: '${userModel.id}',
                            style: bodyLarge(context)
                                ?.copyWith(color: Colors.grey),
                          )
                        ])),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 18),
                      child: IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: userModel.id))
                                .then((value) {
                              //only if ->
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.blue,
                                      content: Text(
                                        'Copied to clipboard',
                                        style: TextStyle(color: Colors.white),
                                      )));
                            });
                          },
                          icon: const Icon(
                            Icons.copy,
                            color: Colors.blue,
                          )),
                    )
                  ]),
              const SizedBox(
                height: 16,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: const RequiredLabel(
                            label: 'Name',
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: TextFormField(
                            initialValue: userModel.name,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your name',
                            ),
                            validator: (input) {
                              if (input != null && !input.trim().isValidName) {
                                return 'Name must follow standard format';
                              } else {
                                return null;
                              }
                            },
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: Text(
                            'Email',
                            style: bodyLargeBold(context),
                            textAlign: TextAlign.start,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: TextFormField(
                            initialValue: hiddenEmail(userModel.email),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )),
                            readOnly: true,
                            enabled: false,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: const RequiredLabel(
                            label: 'Nationality',
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: TextFormField(
                            controller: _txtCountry,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  showPhoneCode:
                                      false, // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    setState(() {
                                      _txtCountry.text = country.name;
                                    });
                                  });
                            },
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: const RequiredLabel(label: 'Phone number')),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: TextFormField(
                            initialValue: userModel.phone,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.black12,
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )),
                            readOnly: true,
                            enabled: false,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: const RequiredLabel(
                            label: 'Birthday',
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: TextFormField(
                            controller: _txtBirthday,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                size: 18,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                            onTap: () {
                              Future<DateTime?> birthday = showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.utc(1900),
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      dialogTheme: DialogTheme(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              16.0), // this is the border radius of the picker
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              birthday.then((value) {
                                if (value != null) {
                                  setState(() {
                                    _txtBirthday.text = getDateString(
                                        value, TimeFormat.getDateOnly);
                                  });
                                }
                              });
                            },
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: const RequiredLabel(
                            label: "My level",
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: DropdownButtonFormField(
                            items: _levelList,
                            value: _txtLevel,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _txtLevel = value;
                              });
                            },
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: const RequiredLabel(
                            label: 'Want to learn',
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ChipDropdown(
                            size: size,
                            options: ConstValue.specialityList,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: Text(
                            'Study schedule',
                            style: bodyLargeBold(context),
                            textAlign: TextAlign.start,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            maxLines: 5,
                            minLines: 3,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  'Note the time of week you want to study',
                            ),
                          )),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                          child: CustomElevatedButton(
                              title: 'Save changes',
                              callback: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.of(context).pop();
                                }
                              },
                              buttonType: ButtonType.filledButton,
                              radius: 10),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
