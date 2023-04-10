import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor/view/common_widgets/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/router.dart';
import '../../const/export_const.dart';
import '../../model/user/user_model.dart';
import '../../model/user/user_token.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validation_extension.dart';
import '../common_widgets/default_style.dart';
import '../common_widgets/elevated_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //FORM VALIDATION
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //UI STATE
  bool _hasAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    if (!_hasAuthenticated) {
      restorePreviousSession(authProvider);
    }

    return Scaffold(
      body: _hasAuthenticated
          ? const SizedBox()
          : SingleChildScrollView(
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
                    margin:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                    child: Text(
                      'Say hello to your English tutors',
                      style: headLineMedium(context)?.copyWith(
                        color: CustomColor.originalBlue,
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
                          Container(
                            margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                            alignment: Alignment.centerRight,
                            child: RichText(
                                text: TextSpan(
                                    text: 'Forgot your password?',
                                    style: bodyLarge(context)
                                        ?.copyWith(color: Colors.blueAccent),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, MyRouter.forgotPassword);
                                      })),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                              child: CustomElevatedButton(
                                  title: 'Login',
                                  callback: () {
                                    if (_formKey.currentState!.validate()) {
                                      _handleLoginByEmail(authProvider);
                                    }
                                  },
                                  buttonType: ButtonType.filledButton,
                                  radius: 10),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                              alignment: Alignment.center,
                              child: Text(
                                'Or continue with',
                                style: bodyLarge(context),
                              )),
                          Container(
                            padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: IconButton(
                                      icon: Image.asset(
                                        ImagesPath.google,
                                        fit: BoxFit.contain,
                                      ),
                                      iconSize: 36,
                                      onPressed: () {
                                        _handleLoginByGoogle(authProvider);
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: IconButton(
                                      icon: Image.asset(
                                        ImagesPath.facebook,
                                        fit: BoxFit.contain,
                                      ),
                                      iconSize: 36,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, MyRouter.home);
                                      },
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: IconButton(
                                        icon: const Icon(
                                          FontAwesomeIcons.mobileScreen,
                                        ),
                                        iconSize: 36,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, MyRouter.home);
                                        },
                                      )),
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                            alignment: Alignment.center,
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Not a member yet?',
                                  style: bodyLarge(context)),
                              TextSpan(
                                  text: ' Sign up',
                                  style: bodyLarge(context)
                                      ?.copyWith(color: Colors.blueAccent),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, MyRouter.signUp);
                                    })
                            ])),
                          ),
                          SizedBox(height: size.height * 0.02),
                        ],
                      ))
                ],
              ),
            ),
    );
  }

  void _handleLoginByEmail(AuthProvider authProvider) async {
    LoadingOverlay.of(context).show();
    try {
      await authProvider.authRepository.loginByMail(
          email: _emailController.text,
          password: _passwordController.text,
          onSuccess: (user, token) async {
            _onLoginSuccess(user, token, authProvider);
          },
          onFail: (e) {
            _onLoginFailed(e);
          });
    } finally {
      LoadingOverlay.of(context).hide();
    }
  }

  void _handleLoginByGoogle(AuthProvider authProvider) async {
    LoadingOverlay.of(context).show();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      ).signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final String? accessToken = googleAuth?.accessToken;
      print("GOOGLE ATOKEN: $accessToken");

      if (accessToken != null) {
        await authProvider.authRepository.loginByGoogle(
          accessToken: accessToken,
          onSuccess: (user, token) async {
            _onLoginSuccess(user, token, authProvider);
          },
        );
      } else {
        throw Exception("Null access token");
      }
    } catch (e) {
      _onLoginFailed(e);
    }
  }

  Future<void> _onLoginSuccess(
      UserModel user, UserToken token, AuthProvider authProvider) async {
    authProvider.saveLoginInfo(user, token);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'refresh_token',
      authProvider.token?.refresh?.token ?? "",
    );

    setState(() {
      _hasAuthenticated = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(
          context, MyRouter.home, (route) => false);
    });
  }

  Future<void> _onLoginFailed(Object error) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${error.toString()}')),
    );
  }

  Future<void> restorePreviousSession(AuthProvider authProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token') ?? "";

    if (refreshToken.isNotEmpty) {
      await authProvider.authRepository.refreshToken(
        refreshToken: refreshToken,
        onSuccess: (user, token) async {
          authProvider.saveLoginInfo(user, token);

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
            'refresh_token',
            authProvider.token!.refresh!.token!,
          );

          setState(() {
            _hasAuthenticated = true;
          });

          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
                context, MyRouter.home, (route) => false);
          });
        },
      );
    }
  }
}
