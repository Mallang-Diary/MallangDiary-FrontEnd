import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InitialSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Initial Setting Page'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(0.5),
          ),
          Center(
            child: Padding(padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "세상과 연결하세요",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "친구와 소통하고, 최신 트렌드를 확인하고, 내가 좋아하는 콘텐츠를 즐겨보세요!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/page_indicator');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  child: Text(
                      "시작하기",
                      style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),),
          )
        ],
      )
    );
  }

}