class Items {
  final int? id;
  final String category;
  final String name;
  final double price;
  final String imagePath;

  Items({
    this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'price': price,
      'imagePath': imagePath,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      id: map['id'],
      category: map['category'],
      name: map['name'],
      price: map['price'],
      imagePath: map['imagePath'],
    );
  }
}
