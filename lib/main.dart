import 'package:flutter/material.dart';
import 'package:mallang_project_v1/database/db/user_service.dart';
import 'package:mallang_project_v1/page/caller/caller_screen.dart';
import 'package:mallang_project_v1/page/caller/calling_page.dart';
import 'package:mallang_project_v1/page/dev/dev_page.dart';
import 'package:mallang_project_v1/page/diary_board/board1.dart';
import 'package:mallang_project_v1/page/diary_board/board2.dart';
import 'package:mallang_project_v1/page/initial_page/inital_page.dart';
import 'package:mallang_project_v1/page/initial_setting/initial_setting_page.dart';
import 'package:mallang_project_v1/page/main_page/call_setting_page_ml03.dart';
import 'package:mallang_project_v1/page/main_page/mypage_ml04.dart';
import 'package:mallang_project_v1/page_indicator.dart';
import 'package:mallang_project_v1/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:supabase/supabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 사용자 가입 여부 확인
  bool userExist = false;
  try {
    userExist = await UserService().userExists();
    print("userExist 상태 확인: $userExist");

    // 임시 방편 코드
    //====================================================
    /*if ( userExist ) {
      // DB 데이터 조회
      final users = await UserService().getAllUsers();
      if ( users.isNotEmpty ) {
        print("현재 DB 사용자 데이터 출력 : ");
        for ( var user in users ){
          print("User ID: ${user.id}, Nickname: ${user.nickname}");
        }
      } else {
        print("DB에 저장된 사용자 데이터가 없습니다.");
      }

      // DB 삭제
      await UserService().clearUsers();
      print("DB 내 모든 사용자 데이터를 삭제하였습니다.");
    } else {
      print("DB에 사용자 데이터가 존재하지 않습니다.");
    }*/

    //====================================================
  } catch (e) {
    print("Error while checking user existence: $e");
  }

  runApp(MyApp(initialRoute: '/dev_page'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'FlutterDemo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        initialRoute: initialRoute,
        routes: {
          '/initial_page': (context) => InitialPage(),
          '/initial_setting': (context) => InitialSettingPage(),
          '/call_setting_page_ml03': (context) => CallSettingsPage(),
          '/page_indicator': (context) => PageIndicator(),
          '/caller_screen': (context) => CallerPage(),
          '/calling_page': (context) => CallingPage(),
          '/main_board': (context) => Board2Page(),
          '/board1_page': (context) => Board1Page(),
          '/mypage_ml04': (context) => MyPage(),
          '/dev_page': (context) => DevPage(), // 오픈 시에는 삭제 필요
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final SupabaseClient supabase;

  const MyHomePage({Key? key, required this.supabase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/initial_page');
            },
            child: Text('Go to Initial Setting Page')),
      ),
    );
  }
}
