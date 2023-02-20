import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/const/image_path.dart';

import '../config/router.dart';
import '../const/custom_color.dart';
import 'common_widgets/app_bar.dart';
import 'common_widgets/validation_extension.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.06),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Image.asset(
                  ImagesPath.intro,
                  fit: BoxFit.contain,
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
              child: Text(
                'Say hello to your English tutors',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: CustomColor.darkBlue,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(36, 6, 36, 18),
              child: Text(
                'Become fluent faster through one one one video chat lessons tailored to your goals.',
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
                        )
                    ),
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
                            if (input != null && !input.isValidEmail) {
                              return 'Email must follow standard format';
                            } else {
                              return null;
                            }
                          },
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(26,8,26,0),
                        width: double.infinity,
                        child: Text(
                          'Password',
                          style: bodyLargeBold(context),
                          textAlign: TextAlign.start,
                        )
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        child: TextFormField(
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            errorMaxLines: 4,
                            suffixIcon: IconButton(
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                            hintText: '******',
                          ),
                          validator: (input) {
                            if (input != null && !input.isValidPassword) {
                              return 'Password must have at least 8 characters (A-z) and 1 number (0-9)';
                            } else {
                              return null;
                            }
                          },
                        )),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16),
                                elevation: 3,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, MyRouter.courses);
                              }
                            },
                            child: const Text('Login')),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(24,12,24,12),
                        alignment: Alignment.center,
                        child: Text('Or continue with',
                          style: bodyLarge(context),
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24,12,24,0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                              child: Image.asset(
                                ImagesPath.google,
                                fit: BoxFit.contain,
                                height: 36,
                                width: 36,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                              child: Image.asset(
                                ImagesPath.facebook,
                                fit: BoxFit.contain,
                                height: 36,
                                width: 36,
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: const Icon(
                                    FontAwesomeIcons.mobileScreen,
                                    size: 36
                                )
                            ),
                          ]
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(24,24,24,24),
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Already a member?', style: bodyLarge(context)),
                                TextSpan(
                                    text: ' Login',
                                    style: bodyLarge(context)
                                        ?.copyWith(color: Colors.blueAccent),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, MyRouter.login);
                                      })
                              ]
                          )
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
