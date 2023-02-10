import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_box/const/jiujitsuVideos.dart';
import 'package:video_box/const/videos.dart';
import 'package:video_box/database/video_database.dart';
import 'package:video_box/screen/knowledge_screen.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:video_box/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDataBase();

  GetIt.I.registerSingleton<LocalDataBase>(database);

  final VideoContents = await database.getVideoContentList();

  if(VideoContents.isEmpty) {
    for(List videoContent in initJiujitsuVideoContentList) {
      await database.createVideoContentList(
        VideoContentCompanion(
          videoTitle: Value(videoContent[0]),
          videoDetail: Value(videoContent[1]),
          videoUrl: Value(videoContent[2]),
          videoSource: Value(videoContent[3]),
          isChecked: Value(videoContent[4]),
        ),
      );
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (_, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'gmarketSans',
              scaffoldBackgroundColor: Color(0xFFFFFFFF),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/knowledge': (context) => KnowledgeScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        }
    );
  }
}