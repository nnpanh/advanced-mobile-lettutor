import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/view/common_widgets/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/router.dart';
import '../../const/export_const.dart';
import '../../utils/validation_extension.dart';
import '../common_widgets/default_style.dart';
import '../common_widgets/elevated_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.06),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
            child: Text(
              'Sign Up',
              style: headLineMedium(context)?.copyWith(
                color: CustomColor.originalBlue,
              ),
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
                        controller: _emailController,
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
                      margin: const EdgeInsets.fromLTRB(26, 8, 26, 0),
                      width: double.infinity,
                      child: Text(
                        'Password',
                        style: bodyLargeBold(context),
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      child: TextFormField(
                        controller: _passwordController,
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
                            return 'Password must have at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                      )),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                      child: CustomElevatedButton(
                          title: 'Create account',
                          callback: () {
                            if (_formKey.currentState!.validate()) {
                              _handleCreateAccount(authProvider);
                            }
                          },
                          buttonType: ButtonType.filledButton,
                          radius: 10),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    alignment: Alignment.center,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Already a member?', style: bodyLarge(context)),
                      TextSpan(
                          text: ' Login',
                          style: bodyLarge(context)
                              ?.copyWith(color: Colors.blueAccent),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pop();
                            })
                    ])),
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ))
        ],
      ),
    );
  }

  void _handleCreateAccount(AuthProvider authProvider) async {
    LoadingOverlay.of(context).show();
    try {
      await authProvider.authRepository.signUpByMail(
          email: _emailController.text,
          password: _passwordController.text,
          onSuccess: (user, token) async {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MyRouter.login, (route) => false);
            });
          },
          onFail: (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.toString()}')),
            );
          });
    } finally {
      LoadingOverlay.of(context).hide();
    }
  }
}
