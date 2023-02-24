class CourseModel {
  final String? title;
  final String? description;
  final String? level;
  final List<String> chapterTitles;
  final String? illustrateUrl;

  CourseModel(this.title, this.description, this.level, this.chapterTitles,
      this.illustrateUrl);
}
