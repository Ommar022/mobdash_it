class PostModel {
  final int id;
  final double price;
  final String title;
  final String? description;
  final String imagePath;
  final String attatchmentUrl;

  PostModel({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.attatchmentUrl,
  });

  factory PostModel.fromJson(final Map<String , dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] as double),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
     imagePath : json['image_path'],
      attatchmentUrl: json['attatchment_url'] ?? '',
    );

  }
}