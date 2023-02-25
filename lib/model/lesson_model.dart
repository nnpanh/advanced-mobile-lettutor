class LessonModel {
  final String? tutorName;
  final String? learnerName;
  final DateTime lessonStart;
  final DateTime lessonEnd;
  final String? tutorAvatarUrl;
  final String? lessonNotes;

  LessonModel(this.tutorName, this.learnerName, this.lessonStart, this.lessonEnd, this.tutorAvatarUrl, this.lessonNotes);
}
