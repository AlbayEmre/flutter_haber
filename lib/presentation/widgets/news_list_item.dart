import 'package:flutter/material.dart';
import 'package:flutter_haber/data/Model/article_model.dart';

class NewsListItem extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const NewsListItem({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: article.urlToImage != null
          ? Image.network(article.urlToImage!, width: 80, fit: BoxFit.cover)
          : const Icon(Icons.image),
      title: Text(article.title ?? 'Başlık Yok'),
      subtitle: Text(article.description ?? 'Açıklama Yok'),
    );
  }
}
