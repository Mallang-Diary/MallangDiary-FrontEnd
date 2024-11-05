import 'package:flutter/material.dart';
import 'package:mallang_project_v1/page/initial_setting/nickname_page.dart';


class SettingPage extends StatelessWidget {
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
                  onPressed: () {
                    // NickNamePage로 이동하면서 onNickNameEntered 콜백을 전달
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NickNamePage(
                          onNickNameEntered: (nickname) {
                            // 입력된 닉네임을 처리하는 로직을 추가합니다.
                            print('입력된 닉네임: $nickname');
                            // 닉네임 입력 후 원하는 페이지로 이동하거나 상태를 업데이트합니다.
                            // 예를 들어, Navigator.pushNamed(context, '/page_indicator');
                            Navigator.pop(context); // 이전 페이지로 돌아가기
                          },
                        ),
                      ),
                    );
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