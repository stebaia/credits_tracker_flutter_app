import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../provider/dark_theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Preferenze'.toUpperCase(),
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              letterSpacing: 1.6,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      Container(
        height: 50,
        color: themeChange.darkTheme ? Colors.black : CupertinoColors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.person,
                  color: themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.label,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Modifica utente',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: themeChange.darkTheme
                        ? Colors.white
                        : CupertinoColors.black,
                  ),
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.label,
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        height: 50,
        color: themeChange.darkTheme ? Colors.black : CupertinoColors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.wifi_slash,
                  color: themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.label,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Offline Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: themeChange.darkTheme
                        ? Colors.white
                        : CupertinoColors.black,
                  ),
                ),
                Spacer(),
                CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        height: 50,
        color: themeChange.darkTheme ? Colors.black : CupertinoColors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.moon,
                  color: themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.label,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: themeChange.darkTheme
                        ? Colors.white
                        : CupertinoColors.black,
                  ),
                ),
                Spacer(),
                CupertinoSwitch(
                  value: themeChange.darkTheme,
                  onChanged: (value) {
                    themeChange.darkTheme = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        child: Container(
          height: 50,
          color: themeChange.darkTheme ? Colors.black : CupertinoColors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.rocket,
                    color: themeChange.darkTheme
                        ? CupertinoColors.white
                        : CupertinoColors.label,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Root Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: themeChange.darkTheme
                          ? Colors.white
                          : CupertinoColors.black,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    color: themeChange.darkTheme
                        ? CupertinoColors.white
                        : CupertinoColors.label,
                  ),
                ],
              ),
            ),
          ),
        ),
        onDoubleTap: () {
          //Navigator.push(
          //context,
          //CupertinoPageRoute(builder: (context) => RootScreen()),
          //);
        },
      ),
    ]);
  }
}
