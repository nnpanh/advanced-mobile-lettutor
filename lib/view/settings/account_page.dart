import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/data/repositories/user_repository.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:lettutor/utils/validation_extension.dart';
import 'package:lettutor/view/common_widgets/chip_dropdown.dart';
import 'package:lettutor/view/common_widgets/circle_network_image.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/settings/widget/required_label.dart';
import 'package:provider/provider.dart';

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
  final _txtName = TextEditingController();
  final _txtCountry = TextEditingController();
  final _txtBirthday = TextEditingController();
  File? imageFile;
  String? _txtLevel;
  final List<DropdownMenuItem<String>> _levelList = [];
  late UserModel userModel;
  late bool hasInitValue = false;

  void initValues(AuthProvider authProvider) {
    setState(() {
      userModel = authProvider.currentUser!;
      //Set values for form
      _txtLevel = userModel.level;
      _txtName.text = userModel.name ?? "";
      _txtCountry.text = userModel.country ?? "";
      if (userModel.birthday != null) {
        _txtBirthday.text = formatDateStringFromApi(userModel.birthday);
      }
      if (hasInitValue == false) {
        for (var element in ConstValue.levelList) {
          _levelList.add(DropdownMenuItem(
            value: element,
            child: Text(element),
          ));
        }
      }
      hasInitValue = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    if (hasInitValue == false) {
      initValues(authProvider);
    }

    return !hasInitValue
        ? const SizedBox()
        : Scaffold(
            appBar: appBarDefault(
                AppLocalizations.of(context)!.editAccount, context),
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
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: CircleNetworkImage(
                                  url: userModel.avatar,
                                  size: size.width * 0.3),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.blue, width: 2)),
                                margin: const EdgeInsets.only(left: 100),
                                child: IconButton(
                                  onPressed: () {
                                    _getFromGallery(authProvider);
                                  },
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
                              padding:
                                  const EdgeInsets.only(left: 24, right: 4),
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
                                  Clipboard.setData(
                                          ClipboardData(text: userModel.id))
                                      .then((value) {
                                    //only if ->
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            duration: Duration(seconds: 2),
                                            backgroundColor: Colors.blue,
                                            content: Text(
                                              'Copied to clipboard',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                child: RequiredLabel(
                                  label: AppLocalizations.of(context)!.name,
                                )),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 24),
                                child: TextFormField(
                                  controller: _txtName,
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter your name',
                                  ),
                                  validator: (input) {
                                    if (input != null &&
                                        !input.trim().isValidName) {
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
                                child: RequiredLabel(
                                  label:
                                      AppLocalizations.of(context)!.nationality,
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
                                        showPhoneCode: false,
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
                                child: RequiredLabel(
                                    label: AppLocalizations.of(context)!
                                        .phoneNumber)),
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
                                child: RequiredLabel(
                                  label: AppLocalizations.of(context)!.birthday,
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
                                child: RequiredLabel(
                                  label: AppLocalizations.of(context)!.myLevel,
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
                                child: RequiredLabel(
                                  label:
                                      AppLocalizations.of(context)!.wantToLearn,
                                )),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 24),
                                padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
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
                                  AppLocalizations.of(context)!.studySchedule,
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
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: AppLocalizations.of(context)!
                                          .noteTheTime),
                                )),
                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(24, 12, 24, 24),
                                child: CustomElevatedButton(
                                    title: AppLocalizations.of(context)!
                                        .saveChanges,
                                    callback: () {
                                      if (_formKey.currentState!.validate()) {
                                        callAPIUpdateProfile(
                                            UserRepository(), authProvider);
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

  Future<void> callAPIUpdateProfile(
      UserRepository userRepository, AuthProvider authProvider) async {
    await userRepository.updateUserInfo(
        accessToken: authProvider.token?.access?.token ?? "",
        input: UserModel(
            name: _txtName.text,
            phone: userModel.phone,
            country: _txtCountry.text,
            birthday: formatDateStringToApi(_txtBirthday.text),
            level: _txtLevel,
            learnTopics: userModel.learnTopics,
            testPreparations: userModel.testPreparations),
        onSuccess: (user) async {
          authProvider.saveLoginInfo(user, authProvider.token);
          initValues(authProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  _getFromGallery(AuthProvider authProvider) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      callAPIUpdateAvatar(UserRepository(), authProvider, pickedFile.path);
    }
  }

  Future<void> callAPIUpdateAvatar(UserRepository userRepository,
      AuthProvider authProvider, String avatar) async {
    await userRepository.uploadAvatar(
        accessToken: authProvider.token?.access?.token ?? "",
        imagePath: avatar,
        onSuccess: (user) async {
          authProvider.saveLoginInfo(user, authProvider.token);
          initValues(authProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}
