import '../model/course_model.dart';
import '../model/tutor_model.dart';

class TutorDetailArguments {
  final TutorModel tutorModel;

  const TutorDetailArguments({required this.tutorModel});
}

class CourseDetailArguments {
  final CourseModel courseModel;

  const CourseDetailArguments({required this.courseModel});
}