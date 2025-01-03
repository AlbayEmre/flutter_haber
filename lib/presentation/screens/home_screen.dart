import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_haber/bloc/news/news_bloc.dart';
import 'package:flutter_haber/bloc/news/news_event.dart';
import 'package:flutter_haber/bloc/news/news_state.dart';
import 'package:flutter_haber/data/Model/article_model.dart';
import 'package:flutter_haber/presentation/screens/detail_screen.dart';
import 'package:flutter_haber/presentation/widgets/news_list_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Kategori seçimi için ValueNotifier
  final ValueNotifier<String> selectedCategory = ValueNotifier<String>('general');

  // Arama metni için TextEditingController
  final TextEditingController searchController = TextEditingController();

  // Kullanmak istediğiniz kategori listesi
  final List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  Widget build(BuildContext context) {
    final newsBloc = BlocProvider.of<NewsBloc>(context);

    // Ekran boyutunu alalım (istenirse responsive tasarım için)
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Uygulama için genel bir arkaplan veriyoruz:
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          // Arkaplan için degrade (gradient) örneği
          gradient: LinearGradient(
            colors: [Color(0xFFEEF2F3), Color(0xFFE7EBEE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Üst Bar (AppBar yerine özelleştirilmiş container)
              _buildCustomAppBar(),

              // Kategori Butonları
              SizedBox(
                height: 60,
                child: ValueListenableBuilder<String>(
                  valueListenable: selectedCategory,
                  builder: (context, value, _) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = (value == category);

                        return GestureDetector(
                          onTap: () {
                            selectedCategory.value = category;
                            newsBloc.add(FetchNewsEvent(category: category));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blueAccent : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Arama Alanı
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        newsBloc.add(SearchNewsEvent(value));
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Haber ara...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Haber Listesi
              Expanded(
                child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    if (state is NewsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is NewsLoaded) {
                      final articles = state.articles;
                      return _buildNewsList(articles, context);
                    } else if (state is NewsError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('Haberler yükleniyor...'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Özel AppBar tasarımı
  Widget _buildCustomAppBar() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Center(
        child: Text(
          'Flutter News App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Haber listesi
  Widget _buildNewsList(List<Article> articles, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return NewsListItem(
          article: articles[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailScreen(article: articles[index]),
              ),
            );
          },
        );
      },
    );
  }
}
