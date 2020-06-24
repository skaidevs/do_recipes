class Recipe {
  final String id;
  final String title;
  final String time;
  final String difficulty;
  final String calories;
  final String imageUri;
  final List ingredients;
  final List method;
  bool isFavorite;

  Recipe(
    this.id,
    this.title,
    this.time,
    this.difficulty,
    this.calories,
    this.imageUri,
    this.ingredients,
    this.method,
  );

  /*factory Recipe.fromJson(Map<String, dynamic> parsedJson) {
    return Recipe(
      id,
      title,
      time,
      difficulty,
      calories,
      imageUri,
      ingredients,
      method,
    );
  }*/
}
