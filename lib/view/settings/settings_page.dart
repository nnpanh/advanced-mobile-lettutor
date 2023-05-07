import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor/providers/settings_provider.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:lettutor/view/common_widgets/circle_network_image.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/settings/widget/menu_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/router.dart';
import '../../const/const_value.dart';
import '../../providers/auth_provider.dart';
import '../common_widgets/dialogs/base_dialog/confirm_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLightMode = true;
  bool _hasLoadedMode = false;
  final List<bool> _notifications = [true, true, false];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    if (!_hasLoadedMode) {
      _isLightMode = settingsProvider.themeMode == ThemeMode.light;
      _hasLoadedMode = true;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      width:  48,
                      height: 48,
                      child: CircleNetworkImage(
                          url: authProvider.currentUser?.avatar, size: 48.0),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authProvider.currentUser?.name ?? "Unknown name",
                              style: bodyLargeBold(context)
                                  ?.copyWith(color: Colors.white, fontSize: 18),
                              maxLines: 1,
                            ),
                            Text(
                              authProvider.currentUser?.country ?? "EN",
                              style: bodyLarge(context)
                                  ?.copyWith(color: Colors.white),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            shape: BoxShape.rectangle,
                            // border: Border.all(width: 2, color: Colors.white,)
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 24,
                          )),
                      onTap: () {
                        Navigator.of(context).pushNamed(MyRouter.account);
                      },
                    ),
                    InkWell(
                      child: Container(
                          margin: const EdgeInsets.only(left: 16),
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            shape: BoxShape.rectangle,
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.blue,
                            size: 24,
                          )),
                      onTap: () {
                        onPressedLogOut(context, size, authProvider);
                      },
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.account,
                    style: headLineSmall(context)?.copyWith(
                        height: ConstValue.courseNameTextScale, fontSize: 18),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                  MenuWidget(
                      title: AppLocalizations.of(context)!.myWallet,
                      callback: () {}),
                  MenuWidget(
                      title: AppLocalizations.of(context)!.becomeATutor,
                      callback: () {
                        Navigator.of(context).pushNamed(MyRouter.becomeTutor);
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    AppLocalizations.of(context)!.application,
                    style: headLineSmall(context)?.copyWith(
                        height: ConstValue.courseNameTextScale, fontSize: 18),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                  ExpansionTile(
                    title: Text(
                      AppLocalizations.of(context)!.notifications,
                      style: bodyLarge(context),
                    ),
                    tilePadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                    childrenPadding: const EdgeInsets.fromLTRB(12, 0, 2, 0),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            AppLocalizations.of(context)!.receiveInAppNoti,
                            style: bodyLarge(context)),
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        trailing: Switch(
                          value: _notifications[0],
                          activeColor: Colors.blue,
                          onChanged: (bool value) {
                            setState(() {
                              _notifications[0] = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.receiveEmail,
                            style: bodyLarge(context)),
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        trailing: Switch(
                          value: _notifications[1],
                          activeColor: Colors.blue,
                          onChanged: (bool value) {
                            setState(() {
                              _notifications[1] = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                            AppLocalizations.of(context)!.receiveSMSText,
                            style: bodyLarge(context)),
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        trailing: Switch(
                          value: _notifications[2],
                          activeColor: Colors.blue,
                          onChanged: (bool value) {
                            setState(() {
                              _notifications[2] = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      AppLocalizations.of(context)!.language,
                      style: bodyLarge(context),
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(12, 0, 2, 0),
                    tilePadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                    children: <Widget>[
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.vietnamese,
                            style: bodyLarge(context)),
                        contentPadding: const EdgeInsets.fromLTRB(2, 0, 4, 0),
                        leading: Image.asset(
                          ImagesPath.vietnam,
                          fit: BoxFit.fitHeight,
                          height: 18,
                        ),
                        trailing: settingsProvider.locale.languageCode == "vi"
                            ? const Icon(Icons.radio_button_checked,
                                color: Colors.blue, size: 18)
                            : const Icon(Icons.radio_button_off,
                                color: Colors.black45, size: 18),
                        onTap: () {
                          setState(() {
                            if (settingsProvider.locale.languageCode != "vi") {
                              settingsProvider.setLocale(const Locale("vi"));
                            }
                          });
                        },
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.english,
                            style: bodyLarge(context)),
                        contentPadding: const EdgeInsets.fromLTRB(2, 0, 4, 0),
                        leading: Image.asset(
                          ImagesPath.english,
                          fit: BoxFit.fitHeight,
                          height: 18,
                        ),
                        trailing: settingsProvider.locale.languageCode != "vi"
                            ? const Icon(
                                Icons.radio_button_checked,
                                color: Colors.blue,
                                size: 18,
                              )
                            : const Icon(Icons.radio_button_off,
                                color: Colors.black45, size: 18),
                        onTap: () {
                          setState(() {
                            if (settingsProvider.locale.languageCode == "vi") {
                              settingsProvider.setLocale(const Locale("en"));
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      AppLocalizations.of(context)!.themeMode,
                      style: bodyLarge(context),
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(12, 0, 2, 0),
                    tilePadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                    children: <Widget>[
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.lightMode,
                            style: bodyLarge(context)),
                        contentPadding: const EdgeInsets.fromLTRB(2, 0, 4, 0),
                        leading: const Icon(Icons.sunny, color: Colors.yellow),
                        trailing: _isLightMode
                            ? const Icon(Icons.radio_button_checked,
                                color: Colors.blue, size: 18)
                            : const Icon(Icons.radio_button_off,
                                color: Colors.black45, size: 18),
                        onTap: () {
                          setState(() {
                            _isLightMode = true;
                            settingsProvider.toggleTheme(false);
                          });
                        },
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.darkMode,
                            style: bodyLarge(context)),
                        contentPadding: const EdgeInsets.fromLTRB(2, 0, 4, 0),
                        leading: const Icon(
                          Icons.nights_stay,
                          color: Colors.lightBlue,
                        ),
                        trailing: !_isLightMode
                            ? const Icon(
                                Icons.radio_button_checked,
                                color: Colors.blue,
                                size: 18,
                              )
                            : const Icon(Icons.radio_button_off,
                                color: Colors.black45, size: 18),
                        onTap: () {
                          setState(() {
                            _isLightMode = false;
                            settingsProvider.toggleTheme(true);
                          });
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      AppLocalizations.of(context)!.applicationInfo,
                      style: bodyLarge(context),
                    ),
                    tilePadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                    children: <Widget>[
                      ListTile(
                        title: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: AppLocalizations.of(context)!.version,
                              style: bodyLargeBold(context)),
                          TextSpan(text: " 1.0.0", style: bodyLarge(context))
                        ])),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    AppLocalizations.of(context)!.overview,
                    style: headLineSmall(context)?.copyWith(
                        height: ConstValue.courseNameTextScale, fontSize: 18),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                  ExpansionTile(
                    title: Text(
                      AppLocalizations.of(context)!.privacyPolicies,
                      style: bodyLarge(context),
                    ),
                    tilePadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: ListTile(
                          title: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: AppLocalizations.of(context)!
                                    .forFurtherInfo,
                                style: bodyLarge(context)?.copyWith(
                                    height: ConstValue.courseNameTextScale)),
                            TextSpan(
                                text: " Privacy & Policies page",
                                style: bodyLarge(context)
                                    ?.copyWith(color: Colors.blue)
                                    .copyWith(
                                        height: ConstValue.courseNameTextScale),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final uri = Uri.parse(
                                        "https://www.privacypolicies.com/live/000c9d07-af97-4158-88a8-05c24a8617fe");
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri);
                                    }
                                  })
                          ])),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      AppLocalizations.of(context)!.termsAndConditions,
                      style: bodyLarge(context),
                    ),
                    tilePadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: ListTile(
                          title: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: AppLocalizations.of(context)!
                                    .forFurtherInfo,
                                style: bodyLarge(context)?.copyWith(
                                    height: ConstValue.courseNameTextScale)),
                            TextSpan(
                                text: " Terms & conditions page",
                                style: bodyLarge(context)
                                    ?.copyWith(color: Colors.blue)
                                    .copyWith(
                                        height: ConstValue.courseNameTextScale),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final uri = Uri.parse(
                                        "https://www.privacypolicies.com/live/000c9d07-af97-4158-88a8-05c24a8617fe");
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri);
                                    }
                                  })
                          ])),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      AppLocalizations.of(context)!.contactForSupport,
                      style: bodyLarge(context),
                    ),
                    tilePadding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                    children: <Widget>[
                      ListTile(
                        visualDensity:
                            const VisualDensity(vertical: -4, horizontal: 0),
                        title: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Email:", style: bodyLargeBold(context)),
                          TextSpan(
                              text: " lettutor@edu.com.vn",
                              style: bodyLarge(context))
                        ])),
                      ),
                      ListTile(
                        visualDensity:
                            const VisualDensity(vertical: -4, horizontal: 0),
                        title: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Official website:  ",
                              style: bodyLargeBold(context)),
                          TextSpan(
                              text: "sandbox.app.lettutor.com",
                              style: bodyLarge(context)
                                  ?.copyWith(color: Colors.blue)
                                  .copyWith(
                                      height: ConstValue.courseNameTextScale),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final uri = Uri.parse(
                                      "https://sandbox.app.lettutor.com/");
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                }),
                        ])),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: NavigationIndex.settingsPage,
        context: context,
      ),
    );
  }

  void onPressedLogOut(
      BuildContext context, Size size, AuthProvider authProvider) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            size: size,
            content: AppLocalizations.of(context)!.doYouWantLogout,
            title: AppLocalizations.of(context)!.logout,
            onRightButton: () {
              _logOut(authProvider);
              pushUntilLogin(context);
            },
            onLeftButton: () {
              Navigator.of(context).pop();
            },
            leftButton: AppLocalizations.of(context)!.no,
            rightButton: AppLocalizations.of(context)!.yes,
            hasLeftButton: true,
          );
        });
  }

  Future<void> _logOut(AuthProvider authProvider) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    authProvider.clearUserInfo();
  }
}
