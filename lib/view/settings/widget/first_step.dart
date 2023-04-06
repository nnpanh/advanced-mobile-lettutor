import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/model/user/user_model.dart';
import 'package:lettutor/utils/validation_extension.dart';
import 'package:lettutor/view/settings/widget/required_label.dart';

import '../../../const/const_value.dart';
import '../../../utils/utils.dart';
import '../../common_widgets/chip_dropdown.dart';
import '../../common_widgets/default_style.dart';
import '../../common_widgets/elevated_button.dart';

class FirstStep extends StatefulWidget {
  const FirstStep({super.key});

  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  final _formKey = GlobalKey<FormState>();
  final _txtCountry = TextEditingController();
  final _txtBirthday = TextEditingController();
  String? _txtLevel;
  bool hasUploaded = false;
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
    return Container(
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
          const SizedBox(
            height: 16,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 0),
                      width: double.infinity,
                      child: const RequiredLabel(
                        label: 'Tutoring name',
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
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
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: const RequiredLabel(
                        label: 'Nationality',
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
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
                              showPhoneCode: false,
                              // optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  _txtCountry.text = country.name;
                                });
                              });
                        },
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: const RequiredLabel(
                        label: 'Birthday',
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
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
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: const RequiredLabel(
                        label: 'Teaching level',
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: DropdownButtonFormField(
                        items: _levelList,
                        value: _txtLevel,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
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
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: const RequiredLabel(
                        label: 'My speciality',
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
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
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: const RequiredLabel(
                        label: 'Introduction',
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'What the student will see first when they see your profile',
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: const RequiredLabel(
                        label: 'Certificates',
                      )),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  color: Colors.grey.shade200),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                children: [
                                  Text('File_name.mp4',
                                      style: bodyLarge(context)?.copyWith(
                                          height:
                                              ConstValue.courseNameTextScale,
                                          color: Colors.black)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                    size: 18,
                                  )
                                ],
                              )),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomElevatedButton(
                                    callback: () {
                                      setState(() {
                                        hasUploaded = !hasUploaded;
                                      });
                                    },
                                    title: 'Upload',
                                    radius: 15,
                                    buttonType: ButtonType.outlinedButton)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: Text(
                        'Interests',
                        style: bodyLargeBold(context),
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'Write about your side-hobby like reading or traveling.',
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: Text(
                        'Education',
                        style: bodyLargeBold(context),
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'Write about your achievements and education level.',
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: Text(
                        'Experience',
                        style: bodyLargeBold(context),
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      width: double.infinity,
                      child: Text(
                        'Current/Previous Profession',
                        style: bodyLargeBold(context),
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
//https://educity.app/flutter/how-to-pick-an-image-from-gallery-and-display-it-in-flutter
