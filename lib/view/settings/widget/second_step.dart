import 'package:flutter/material.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/utils/default_style.dart';
import 'package:lettutor/view/common_widgets/elevated_button.dart';

class SecondStep extends StatefulWidget {
  const SecondStep({super.key});

  @override
  State<SecondStep> createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  bool hasUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: Text(
                'Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise and personality.',
                style: bodyLarge(context)?.copyWith(
                    height: ConstValue.courseNameTextScale,
                    color: Colors.black54))),
        Row(children: [
          Expanded(child: Image.asset(ImagesPath.video, fit: BoxFit.contain)),
        ]),
        Visibility(
          visible: hasUploaded? false:true,
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tips:',
                  style: bodyLargeBold(context)?.copyWith(
                      height: ConstValue.courseNameTextScale,
                      color: Colors.blue))),
        ),
        Visibility(
          visible: hasUploaded? false:true,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                  '1. Your video should last 1-3 minutes\n2. Smile and look at the camera\n3. Find a clear and quiet space\n4. Have fun!',
                  style: bodyLarge(context)?.copyWith(
                      height: ConstValue.courseNameTextScale,
                      color: Colors.blue))),
        ),
        Visibility(
          visible: hasUploaded? false:true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                    color: Colors.grey.shade200

                  ),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Text(
                        'File_name.mp4',
                          style: bodyLarge(context)?.copyWith(
                              height: ConstValue.courseNameTextScale,
                              color: Colors.black)),
                      const SizedBox(width: 8,),
                      const Icon(Icons.clear, color: Colors.black,size: 18,)
                    ],
                  )),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(child: CustomElevatedButton(callback: (){
              setState(() {
                hasUploaded = !hasUploaded;
              });
            }, title: 'Upload', radius: 15, buttonType: ButtonType.outlinedButton)),
          ],
        ),

      ],
    );
  }
}
