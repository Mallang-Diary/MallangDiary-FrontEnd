import 'package:flutter/material.dart';
import 'package:mallang_project_v1/page/caller/calling_page.dart';
import 'package:mallang_project_v1/page/diary_board/board1.dart';
import 'package:mallang_project_v1/page/diary_board/board2.dart';
import 'package:mallang_project_v1/page/initial_setting/initial_setting_page.dart';
import 'package:mallang_project_v1/page/main_page/call_setting_page_ml03.dart';
import 'package:mallang_project_v1/page/main_page/mypage_ml04.dart';
import 'package:mallang_project_v1/setting_page.dart';
import 'package:mallang_project_v1/page/caller/caller_screen.dart';
import 'package:mallang_project_v1/page/initial_setting/nickname_page.dart';
import 'package:mallang_project_v1/page_indicator.dart';
import 'package:mallang_project_v1/state/app_state.dart';
import 'package:supabase/supabase.dart';
import 'package:provider/provider.dart';

void main() async {
  // runApp 을 수행하기 전에 비동기 작업을 할 경우 추가해 주는 코드
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = SupabaseClient('https://ojrhvazskoihqvhjscev.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qcmh2YXpza29paHF2aGpzY2V2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA3Njk0MDQsImV4cCI6MjA0NjM0NTQwNH0.V2PynGINHY_yM-rqAmbvLLMoaFBfZay449luABbmkRA');
  runApp(MyApp(supabase: supabase));
}

class MyApp extends StatelessWidget {
  final SupabaseClient supabase;

  const MyApp({Key? key, required this.supabase}) : super(key: key);

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
        //home: CallerScreen(),
        home: MyHomePage(supabase: supabase),
        routes: {
          //'/initial_setting_origin': (context) => SettingPage(),
          '/call_setting_page_ml03': (context) => CallSettingsPage(),
          '/page_indicator': (context) => PageIndicator(),
          '/initial_setting': (context) => InitialSettingPage(),
          '/caller_screen': (context) => CallerPage(),
          '/calling_page': (context) => CallingPage(),
          '/board2_page': (context) => Board2Page(),
          '/board1_page': (context) => Board1Page(),
          '/mypage_ml04': (context) => MyPage(),
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
              Navigator.pushNamed(context, '/mypage_ml04');
            },
            child: Text('Go to Initial Setting Page')),
      ),
    );
  }
}
