class CourseModel {
  final String? title;
  final String? description;
  final String? level;
  final List<String> chapterTitles;
  final String? illustrateUrl;
  final List<String> suggestedTutor;

  CourseModel(this.title, this.description, this.level, this.chapterTitles,
      this.illustrateUrl, this.suggestedTutor);
}
