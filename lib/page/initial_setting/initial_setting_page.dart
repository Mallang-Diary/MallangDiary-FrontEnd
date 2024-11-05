import 'package:flutter/material.dart';
import 'package:mallang_project_v1/page/initial_setting/callschedule_page.dart';
import 'package:mallang_project_v1/page/initial_setting/nickname_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InitialSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InitialSettingPageState();
  }
}

class _InitialSettingPageState extends State<InitialSettingPage> {
  final PageController _pageController = PageController();
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nickname & Schedule')),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                NickNamePage(onNickNameEntered: (value) {
                  setState(() {
                    nickname = value;  // 닉네임 업데이트
                  });
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }),
                CallSchedulePage(nickname: nickname),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: WormEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
