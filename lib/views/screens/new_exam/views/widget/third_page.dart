import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_block.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_state.dart';

import '../../../../../resources/base_url_resource.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  late NewExamBlock block;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    block = context.read<NewExamBlock>();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewExamBlock, NewExamState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _itemViewWidget(state),
            ],
          ),
        );
      },
    );
  }

  Widget _itemViewWidget(NewExamState state) {
    return SizedBox(
      height: 160.h,
      width: 320.w,
      child: PageView.builder(
        itemCount: state.examClips?.length,
        controller: controller,
        scrollBehavior: CupertinoScrollBehavior(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  '${state.examClips?[index].clipFileVideo}',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
