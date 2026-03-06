class Product {
  final int id;
  final String name;
  final String brand;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final String description;
  final String imagePath;
  final List<String> tags;
  final bool isNew;
  final bool isBestseller;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.imagePath,
    required this.tags,
    this.isNew = false,
    this.isBestseller = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      description: json['description'],
      imagePath: json['imagePath'],
      tags: List<String>.from(json['tags']),
      isNew: json['isNew'] ?? false,
      isBestseller: json['isBestseller'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'description': description,
      'imagePath': imagePath,
      'tags': tags,
      'isNew': isNew,
      'isBestseller': isBestseller,
    };
  }
}
