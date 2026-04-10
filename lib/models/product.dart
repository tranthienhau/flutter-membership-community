class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final bool isLimitedDrop;
  final String? dropDate;
  final int stock;
  final String category;
  final List<String> tags;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.isLimitedDrop,
    this.dropDate,
    required this.stock,
    required this.category,
    required this.tags,
  });
}
