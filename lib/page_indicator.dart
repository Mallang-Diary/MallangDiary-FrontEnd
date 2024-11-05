import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: _PageIndicator(),
    );
  }
}

class _PageIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageIndicatorState();
  }
}

class _PageIndicatorState extends State<_PageIndicator> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                Center(child: Text("Page 1")),
                Center(child: Text("Page 2")),
                Center(child: Text("Page 3")),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Colors.blue,
              dotColor: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}