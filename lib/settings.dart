import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double buttonSize = 20;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime;
  int shortBreak;
  int longBreak;
  SharedPreferences prefs;
  TextEditingController txWork;
  TextEditingController txShort;
  TextEditingController txLong;
  @override
  void initState() {
    txWork = TextEditingController();
    txShort = TextEditingController();
    txLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Container(
            child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          children: <Widget>[
            Text("Work", style: textStyle),
            Text(""),
            Text(""),
            SettingsButton(Color(0xff455A64), "-", buttonSize, -1, WORKTIME,
                updateSetting),
            TextField(
                controller: txWork,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingsButton(
                Color(0xff009688), "+", buttonSize, 1, WORKTIME, updateSetting),
            Text("Short", style: textStyle),
            Text(""),
            Text(""),
            SettingsButton(Color(0xff455A64), "-", buttonSize, -1, SHORTBREAK,
                updateSetting),
            TextField(
                controller: txShort,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingsButton(Color(0xff009688), "+", buttonSize, 1, SHORTBREAK,
                updateSetting),
            Text(
              "Long",
              style: textStyle,
            ),
            Text(""),
            Text(""),
            SettingsButton(Color(0xff455A64), "-", buttonSize, -1, LONGBREAK,
                updateSetting),
            TextField(
                controller: txLong,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingsButton(Color(0xff009688), "+", buttonSize, 1, LONGBREAK,
                updateSetting),
          ],
          childAspectRatio: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: const EdgeInsets.all(20),
        )));
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    int shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    int longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txWork.text = workTime.toString();
      txShort.text = shortBreak.toString();
      txLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK);
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK);
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
