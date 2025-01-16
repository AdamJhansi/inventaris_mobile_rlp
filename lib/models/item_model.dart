class Items {
  final int? id;
  final String category;
  final String label;
  final int price;
  final String imagePath;

  Items({
    this.id,
    required this.category,
    required this.label,
    required this.price,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'label': label,
      'price': price,
      'imagePath': imagePath,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      id: map['id'],
      category: map['category'],
      label: map['label'],
      price: map['price'],
      imagePath: map['imagePath'],
    );
  }
}
