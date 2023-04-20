import 'package:lettutor/model/course/course_model.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';

class TutorDetailArguments {
  final TutorModel tutorModel;

  const TutorDetailArguments({required this.tutorModel});
}

class CourseDetailArguments {
  final CourseModel courseModel;

  const CourseDetailArguments({required this.courseModel});
}

class LessonDetailArguments {
  final String title;
  final String pdfUrl;

  const LessonDetailArguments({required this.title, required this.pdfUrl});
}

class SearchResultArguments {
  final int nationality;
  final String searchKey;
  final List<String> specialities;

  const SearchResultArguments(this.nationality, this.searchKey, this.specialities);
}