import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../config/router.dart';
import '../../const/export_const.dart';
import '../../utils/default_style.dart';
import '../../utils/validation_extension.dart';
import '../common_widgets/elevated_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
              child: Text(
                'Reset Password',
                style: headLineMedium(context)?.copyWith(
                  color: CustomColor.originalBlue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 6, 40, 18),
              child: Text(
                'Please enter your account email to receive a reset password link.',
                style: bodyLarge(context),
                textAlign: TextAlign.center,
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
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
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'E.g. email@gmail.com',
                          ),
                          validator: (input) {
                            if (input != null && !input.trim().isValidEmail) {
                              return 'Email must follow standard format';
                            } else {
                              return null;
                            }
                          },
                        )),
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
    );
  }
}
