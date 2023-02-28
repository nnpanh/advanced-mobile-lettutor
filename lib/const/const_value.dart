class ImagesPath {
  static const logo = "assets/images/logo.png";
  static const intro = "assets/images/intro.png";
  static const facebook = "assets/images/facebook.png";
  static const google = "assets/images/google.png";
  static const resetPassword = "assets/images/reset_pass.png";
  static const youtube = "assets/images/youtube.jpeg";
  static const error = "assets/images/error_mascot.png";
  static const thanks = "assets/images/thanks.png";
}

class ConstValue {
  static const descriptionTextScale = 1.5;
  static const courseNameTextScale = 1.75;
  static const levelList = ["Pre A1 (Beginner)", "A1 (Higher Beginner)", "A2 (Pre-intermediate)",
    "B1 (Intermediate)", "B2 (Upper-intermediate","C1 (Advanced)","C2 (Proficiency)"];
  static const specialityList = ["For kids", "For Business", "Conversational","Starters", "Movers","Flyers","KET/PET","TOEIC","IELTS","TOEFL"];

}

class ButtonType {
  static const outlinedButton = "outlinedButton";
  static const filledButton = "filledButton";
  static const filledWhiteButton = "filledWhiteButton";
}

class NavigationIndex {
  static const homePage = 0;
  static const schedulePage = 1;
  static const studyPage = 2;
  static const settingsPage = 3;
}

class CourseOverView {
  static const takenReason = "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.";
  static const achievement = "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.";
}

class TimeFormat {
  static const getDateNo = "getDateNo";
  static const getTime = "getTime";
  static const getDateAndTime = "getDateAndTime";
  static const getDateOnly = "getDateOnly";
}

// enum Speciality {
//   forKids, forBusiness, conversational, starters, movers, flyers, ketPet, toeic, ielts, toefl, }
//
// extension SpecialityExtension on Speciality {
//   List<String> get getList {
//     return ["For kids", "For Business", "Conversational","Starters", "Movers","Flyers","KET/PET","TOEIC","IELTS","TOEFL"];
//   }
//
//   String get name {
//     return getList[index];
//   }
// }

class Nationality {
  static const nationVN = 'Vietnamese';
  static const nationNative = 'Native speaker';
  static const nationForeign = 'Foreign speaker';
}