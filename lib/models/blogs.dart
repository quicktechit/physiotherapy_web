class Blog {
  final int id;
  final String image;
  final String title;
  final String shortDescription;
  final String longDescription;
  final String createdAt;

  Blog({
    required this.id,
    required this.image,
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.createdAt,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      shortDescription: json['short_description'],
      longDescription: json['long_description'],
      createdAt: json['created_at'],
    );
  }
}