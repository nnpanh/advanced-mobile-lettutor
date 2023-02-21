import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../model/tutor_model.dart';

ThemeMode getDeviceThemeMode() {
  var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
  if (brightness == Brightness.light) {
    return ThemeMode.light;
  } else {
    return ThemeMode.dark;
  }
}

List<TutorModel> generateDummiesList() {
  List<TutorModel> tutorList = [];
  var sampleTutor = TutorModel('Shuumatsu no Valkyrie Shuumatsu no Valkyrie Shuumatsu no Valkyrie Shuumatsu no Valkyrie', "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      true,
      true,
      ['IELTS','TOEIC'],

      "https://www.linkpicture.com/q/306931717_180342937860292_6628553018679771531_n.jpg", 'Vietname');
  var sampleTutor2 = TutorModel('Shuumatsu no Valkyrie', "Very short intro",
      false,
      false,
      ['IELTS','TOEIC'],

      "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand", 'Vietname');
  for( var i = 3 ; i >= 1; i-- ) {
    tutorList.add(sampleTutor);
    tutorList.add(sampleTutor2);

  }
  return tutorList;
}