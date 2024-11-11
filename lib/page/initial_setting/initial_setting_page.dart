import 'package:flutter/material.dart';
import 'package:mallang_project_v1/page/initial_setting/callschedule_page.dart';
import 'package:mallang_project_v1/page/initial_setting/complete_page.dart';
import 'package:mallang_project_v1/page/initial_setting/nickname_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InitialSettingPage extends StatefulWidget {
  @override
  _InitialSettingPageState createState() => _InitialSettingPageState();
}

class _InitialSettingPageState extends State<InitialSettingPage> {
  final PageController _pageController = PageController();
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // SmoothPageIndicator to show the page progress
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    activeDotColor: Colors.black,
                  ),
                ),
                SizedBox(height: 16), // Spacer between the page indicator and buttons
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                // NickNamePage with callback to capture nickname and navigate to next page
                NickNamePage(onNickNameEntered: (value) {
                  setState(() {
                    nickname = value;  // Update nickname
                  });
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }),
                // CallSchedulePage showing the nickname
                CallSchedulePage(nickname: nickname),
                CompletePage(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_pageController.page! > 0) {
                    _pageController.previousPage(
                        duration: Duration(milliseconds: 300), curve: Curves.ease);
                  }
                },
                child: Text("이전으로"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_pageController.page! < 2) {
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 300), curve: Curves.ease);
                  }
                },
                child: Text("다음으로"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
