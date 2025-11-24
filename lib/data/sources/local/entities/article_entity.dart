import 'package:hive_flutter/adapters.dart';

import '../../../../domain/article.dart';

part 'article_entity.g.dart';

@HiveType(typeId: 0)
class ArticleEntity extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final String? imageUrl;

  @HiveField(4)
  final String publishedDate;

  ArticleEntity({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedDate,
  });

  factory ArticleEntity.fromDomain(Article a) => ArticleEntity(
    title: a.title,
    description: a.description,
    url: a.url,
    imageUrl: a.imageUrl,
    publishedDate: a.publishedDate,
  );

  Article toDomain() => Article(
    title: title,
    description: description,
    url: url,
    imageUrl: imageUrl,
    publishedDate: publishedDate,
    isFavourite: true,
  );
}
