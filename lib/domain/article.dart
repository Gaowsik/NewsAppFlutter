class Article {
  final String title;
  final String description;
  final String url;
  final String? imageUrl;
  final String publishedDate;
  bool isFavourite;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedDate,
    this.isFavourite = false,
  });

  Article copyWith({bool? isFavourite}) {
    return Article(
      title: title,
      description: description,
      imageUrl: imageUrl,
      url: url,
      publishedDate: publishedDate,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
