import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/sizes/sizes.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_block.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/views/my_exam_screen.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_block.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MyExamBlock(),
        ),
        BlocProvider(
          create: (context) => NewExamBlock(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyExamScreen(),
        ),
      ),
    );
  }
}
