import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mallang_project_v1/database/db/diarySetting_db_service.dart';
import 'package:mallang_project_v1/database/db/user_db_service.dart';
import 'package:mallang_project_v1/database/model/diary_setting.dart';
import 'package:mallang_project_v1/database/model/user.dart';
import 'package:mallang_project_v1/page/initial_setting/callschedule_page.dart';
import 'package:mallang_project_v1/page/initial_setting/complete_page.dart';
import 'package:mallang_project_v1/page/initial_setting/nickname_page.dart';
import 'package:mallang_project_v1/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InitialSettingPage extends StatefulWidget {
  @override
  _InitialSettingPageState createState() => _InitialSettingPageState();
}

class _InitialSettingPageState extends State<InitialSettingPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool _isNextButtonPressed = false;

  String nickname = '';
  String selectedDays = '';
  String selectedTime = '';

  final UserDBService _userService = UserDBService();
  final DiarySettingDBService _diarySettingService = DiarySettingDBService();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChange);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChange() {
    setState(() {
      currentPage = _pageController.page!.round();
    });
  }

  void _goToNextPage() {
    setState(() {
      _isNextButtonPressed = true;
    });
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _goToPreviousPage() {
    setState(() {
      _isNextButtonPressed = false;
    });
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  // Callback 핸들러
  void _handleScheduleChange(String days, String time) {
    setState(() {
      selectedDays = days;
      selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildPageIndicator(),
          SizedBox(height: 16),
          _buildPageView(),
          _buildNavigationButtons(screenWidth),
        ],
      ),
    );
  }

  /// SmoothPageIndicator 위젯
  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: SmoothPageIndicator(
          controller: _pageController,
          count: 3,
          effect: WormEffect(
            activeDotColor: Colors.black,
            dotColor: Colors.grey[400]!,
            dotHeight: 10,
            dotWidth: 10,
            spacing: 12,
          ),
        ),
      ),
    );
  }

  /// PageView 위젯
  Widget _buildPageView() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: PageView(
            controller: _pageController,
            children: [
              NickNamePage(
                onNickNameEntered: (value) {
                  setState(() {
                    nickname = value;
                  });
                },
              ),
              CallSchedulePage(
                nickname: nickname,
                onScheduleChanged: _handleScheduleChange,
              ),
              CompletePage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(double screenWidth) {
    if (currentPage == 0) {
      return Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(screenWidth, 50),
            backgroundColor: _isNextButtonPressed ? clickedButtonColorLightGrey : nextButtonColorDarkGrey,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: nickname.isNotEmpty ? _goToNextPage : null,
          child: Text("다음으로"),
        ),
      );
    }

    void _handleSaveData() async {

      print("DB 저장 ${nickname} - ${selectedDays} - ${selectedTime}");

      try {
        await _userService.insert(User(
          id: 1,
          nickname: nickname,
        ));  // User

        await _diarySettingService.insert(DiarySetting(
          userId: 1,
          dayOfWeek: selectedDays,
          alarmTime: selectedTime,
          alarmSound: "default",
          createdAt: DateTime.now().toIso8601String(),
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("저장 완료")),
        );

        // 2초 후에 메인 페이지로 이동
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/main_board');
        });
      } catch (e) {
        print("저장 실패 원인: $e"); // 에러 원인 출력
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("저장 실패")),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth * 0.4, 50),
              backgroundColor: beforeButtonColorGrey,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: _goToPreviousPage,
            child: Text("이전으로"),
          ),
        ),
        SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth * 0.6, 50),
              backgroundColor: nextButtonColorDarkGrey,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {
              if (currentPage == 2) {
              _handleSaveData(); // 마지막 페이지인 경우 저장
              } else {
              _goToNextPage(); // 나머지 페이지에서 다음으로 이동
              }
            },
            child: Text("다음으로"),
          ),
        ),
      ],
    );
  }
}

