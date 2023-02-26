import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/config/router.dart';
import 'package:lettutor/model/user_model.dart';
import 'package:lettutor/utils/default_style.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:lettutor/utils/validation_extension.dart';
import 'package:lettutor/view/settings/widget/required_label.dart';

import '../../const/const_value.dart';
import '../common_widgets/elevated_button.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final UserModel userModel = testUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(MyRouter.account, context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16,24,16,16),
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
                        radius: 80,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          radius: 78,
                          foregroundImage:
                              NetworkImage(userModel.avatarUrl ?? ""),
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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                        padding: const EdgeInsets.only(left:12, right: 4),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Account id: ',
                            style:
                                bodyLarge(context)?.copyWith(color: Colors.grey),
                          ),
                          TextSpan(
                              text: '${userModel.id}',
                              style: bodyLarge(context)
                                  ?.copyWith(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Clipboard.setData(
                                          ClipboardData(text: userModel.id))
                                      .then((value) {
                                    //only if ->
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.blue,
                                            content: Text('Copied to clipboard',style: TextStyle(color: Colors.white),)));
                                  });
                                })
                        ])),
                      ),
                    ),
                  ]),
              const SizedBox(height: 16,),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: const RequiredLabel(label: 'Name',)),
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
                              suffixIcon: Icon(Icons.check,color: Colors.green,)
                            ),
                            readOnly: true,
                            enabled: false,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 26),
                          width: double.infinity,
                          child: const RequiredLabel(label: 'Country',)),
                      //https://stackoverflow.com/questions/49780858/flutter-dropdown-text-field
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                          child: CustomElevatedButton(
                              title: 'Send link',
                              callback: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushNamed(context, MyRouter.login);
                                }
                              },
                              buttonType: ButtonType.filledButton,
                              radius: 10),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Don't remember your email?",
                              style: bodyLarge(context)),
                          TextSpan(
                              text: ' Ask for help',
                              style: bodyLarge(context)
                                  ?.copyWith(color: Colors.blueAccent),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, MyRouter.login);
                                })
                        ])),
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
