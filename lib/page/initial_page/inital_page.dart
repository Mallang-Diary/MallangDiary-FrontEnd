import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment(0, -1 / 3),
        child: Text(
          '말로하는 쉬운 일기\n말랑일기',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToInitialSetting() {
    Navigator.pushReplacementNamed(context, '/initial_setting');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
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
                controller: _controller,
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
          ),
          Expanded(
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (_controller.page == 2 &&
                    notification.direction == ScrollDirection.reverse) {
                  navigateToInitialSetting();
                  return true;
                }
                return false;
              },
              child: PageView(
                controller: _controller,
                children: [
                  OnboardingPage(
                    title: '매일 일정한 시간에\n전화를 드려요',
                    imagePath: 'assets/images/image1.jpg',
                  ),
                  OnboardingPage(
                    title: '전화를 하듯\n오늘 하루를 얘기해보세요',
                    imagePath: 'assets/images/image2.jpg',
                  ),
                  OnboardingPage(
                    title: '일기를\n자동으로 써드릴게요',
                    imagePath: 'assets/images/image3.jpg',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String imagePath;

  OnboardingPage({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Align(
            alignment: Alignment(0, -1 / 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 50, left: 50, right: 50),
            color: Colors.grey,
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
