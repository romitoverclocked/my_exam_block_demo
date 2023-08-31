import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_block.dart';
import 'package:my_exam_block_demo/views/screens/new_exam/block/new_exam_state.dart';
import 'package:my_exam_block_demo/views/screens/my_exam/block/my_exam_state.dart';

import '../../block/new_exam_block.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late NewExamBlock block;
  late NewExamState state;
  late MyExamBlock myExamBlock;
  late MyExamState myExamState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    block = context.read<NewExamBlock>();
    myExamBlock = context.read<MyExamBlock>();
    state = context.read<NewExamBlock>().state;
    myExamState = context.read<MyExamBlock>().state;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Scan file(s)',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
            Text(
              'First select the uploaded file(s) to create the exam',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            allScans(),
          ],
        ),
      ),
    );
  }

  Widget allScans() {
    return GridView.builder(
      itemCount: myExamBlock.state.allScans?.data?.length ?? 0,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    myExamBlock.state.allScans?.data?[index].categoryImage ??
                        "",
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// Widget _allPhotos() {
//   return GridView.builder(
//     itemCount: state.examClips?.length ?? 0,
//     padding: EdgeInsets.symmetric(
//       horizontal: 20.w,
//       vertical: 20.h,
//     ),
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
//     itemBuilder: (context, index) {
//       return Stack(
//         children: [
//           state.examClips.isVideo ?? false
//               ? Container(
//                   margin: EdgeInsets.all(3),
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     image: DecorationImage(
//                       image: MemoryImage(
//                         itemsList[index].videoImage ?? Uint8List(0),
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(
//                   margin: EdgeInsets.all(3),
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     image: DecorationImage(
//                       image:
//                           FileImage(File(itemsList[index].file?.path ?? "")),
//                     ),
//                   ),
//                 ),
//           if (itemsList[index].isVideo ?? false)
//             Center(
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 12,
//                 child: Icon(
//                   Icons.play_arrow,
//                   size: 20,
//                   color: ColorResource.appColor,
//                 ),
//               ),
//             ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: GestureDetector(
//               child: CircleAvatar(
//                 radius: 15,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 14,
//                   backgroundColor: Colors.black,
//                   child: Icon(
//                     Icons.close,
//                     size: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
}
