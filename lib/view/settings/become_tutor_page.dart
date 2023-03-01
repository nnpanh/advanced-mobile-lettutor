import 'package:flutter/material.dart';
import 'package:lettutor/config/router.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/utils/default_style.dart';
import 'package:lettutor/view/common_widgets/elevated_button.dart';
import 'package:lettutor/view/settings/widget/first_step.dart';
import 'package:lettutor/view/settings/widget/second_step.dart';

class BecomeTutorPage extends StatefulWidget {
  const BecomeTutorPage({super.key});

  @override
  State<BecomeTutorPage> createState() => _BecomeTutorPageState();
}

class _BecomeTutorPageState extends State<BecomeTutorPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(MyRouter.becomeTutor, context),
      body: Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 1) {
            setState(() {
              _index += 1;
            });
          } else {
            setState(() {
              _index -= 1;
            });
          }
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          final isLastStep = _index == 2;
          return Container(
              margin: const EdgeInsets.fromLTRB(0, 24, 0, 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 100),
                      child: CustomElevatedButton(
                        callback: details.onStepContinue ?? () {},
                        title: isLastStep ? 'Return' : 'Next',
                        radius: 15,
                        buttonType: ButtonType.filledButton,
                      ),
                    ),
                    if (_index == 1)
                      const SizedBox(
                        width: 24,
                      ),
                    if (_index == 1)
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 100),
                        child: CustomElevatedButton(
                          callback: details.onStepCancel ?? () {},
                          title: 'Back',
                          radius: 15,
                          buttonType: ButtonType.filledWhiteButton,
                        ),
                      ),
                  ]));
        },
        steps: <Step>[
          Step(
              state: _index > 2 ? StepState.complete : StepState.indexed,
              title: const Text('Step 1: Complete your profile'),
              content: const FirstStep(),
              isActive: _index >= 0),
          Step(
              state: _index > 2 ? StepState.complete : StepState.indexed,
              title: const Text('Step 2: Video introduction'),
              content: const SecondStep(),
              isActive: _index >= 1),
          Step(
              title: const Text('Step 3: Approval'),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24),
                    child: Image.asset(
                      ImagesPath.thanks,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Thank you for joining LetTutor team. Please kindly wait for our approval process. The final result "
                    "shall be sent through your email.",
                    style: bodyLarge(context)?.copyWith(
                        height: ConstValue.courseNameTextScale,
                        color: Colors.black45),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              isActive: _index >= 2),
        ],
      ),
    );
  }
}
