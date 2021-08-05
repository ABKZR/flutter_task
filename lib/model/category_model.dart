class Category {
  Category({
    this.id,
    required this.name,
    required this.picture,
  });
  final int? id;
  final String name;
  final String picture;

  factory Category.fromMap(Map<String, dynamic> json) => new Category(
        id: json['id'],
        name: json['name'],
        picture: json['picture'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'picture': picture,
    };
  }
}
