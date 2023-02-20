import 'package:flutter/material.dart';
import 'package:lettutor/const/image_path.dart';

import '../config/router.dart';
import '../const/custom_color.dart';
import 'common_widgets/validation_extension.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: size.height * .16),
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
              margin: const EdgeInsets.fromLTRB(36.0, 6.0, 36.0, 18.0),
              child: Text(
                'Become fluent faster through one one one video chat lessons tailored to your goals.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
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
                            vertical: 6, horizontal: 24),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            hintText: 'email@gmail.com',
                          ),
                          validator: (input) {
                            if (input != null && !input.isValidEmail) {
                              return 'Invalid email format.';
                            } else {
                              return null;
                            }
                          },
                        )),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, MyRouter.courses);
                          }
                        },
                        child: Text('Submit'))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
