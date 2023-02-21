class TutorModel {
  late String? name;
  late String? description;
  late bool isFavorite = false;
  late bool? isOnline;
  late List<String?> specialities;
  late String? avatarUrl;
  late String? nationality;

  TutorModel(this.name, this.description, this.isFavorite, this.isOnline, this.specialities, this.avatarUrl, this.nationality);
}