import 'package:flutter/material.dart';
import 'package:flutter_haber/data/Model/article_model.dart';

class DetailScreen extends StatelessWidget {
  final Article article;
  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Arka plan rengi veya degrade
      body: SafeArea(
        child: Stack(
          children: [
            // Arka Plan
            Positioned.fill(
              child: Container(
                color: const Color(0xFFF2F3F5),
              ),
            ),

            // Üstteki fotoğraf veya resim
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Resim
                  if (article.urlToImage != null)
                    Hero(
                      tag: article.urlToImage!, // List -> Detail geçişinde animasyon için
                      child: Image.network(
                        article.urlToImage!,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Başlık
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      article.title ?? 'Başlık Yok',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // İçerik
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      article.content ?? 'İçerik Bulunamadı',
                      style: const TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ),

                  // Tarih
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          article.publishedAt?.split('T').first ?? 'Bilinmiyor',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Geri butonu
            Positioned(
              top: 10,
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
