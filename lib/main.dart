import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './settings.dart';

import './widgets.dart';
import './timer.dart';
import './timermodel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Work Timer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  static const double buttonSize = 10;
  final CountDownTimer timer = CountDownTimer();
  final double defaultPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));
    timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (s) {
                if (s == 'Settings') {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => SettingsScreen()));
                }
              },
              itemBuilder: (BuildContext context) {
                return menuItems.toList();
              },
            )
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        size: buttonSize,
                        color: Color(0xff009688),
                        text: "Work",
                        onPressed: () => timer.startWork())),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        size: buttonSize,
                        color: Color(0xff607D8B),
                        text: "Short Break",
                        onPressed: () => timer.startBreak(true))),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        size: buttonSize,
                        color: Color(0xff455A64),
                        text: "Long Break",
                        onPressed: () => timer.startBreak(false))),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            StreamBuilder(
              stream: timer.stream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                TimerModel timer = (snapshot.data == '00:00')
                    ? TimerModel(time: '00:00', percent: 1)
                    : snapshot.data;
                return Expanded(
                    child: CircularPercentIndicator(
                  radius: availableWidth / 2,
                  lineWidth: 10.0,
                  percent: timer.percent,
                  progressColor: Color(0xff009688),
                  center: Text(
                    timer.time,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ));
              },
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        size: buttonSize,
                        color: Color(0xff212121),
                        text: 'Stop',
                        onPressed: () => timer.stopCounter())),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        size: buttonSize,
                        color: Color(0xff009688),
                        text: 'resume',
                        onPressed: () => timer.startCounter())),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
          ]);
        }));
  }

  emptymethod() {}
}
