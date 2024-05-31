class StoreItem {
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final int price;
  final int oldPrice;

  StoreItem(
      {required this.title,
      required this.description,
      required this.rating,
      required this.imageUrl,
      required this.price,
      required this.oldPrice});
}
