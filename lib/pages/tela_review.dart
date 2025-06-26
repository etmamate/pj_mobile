import 'package:flutter/material.dart';
import 'package:pj_mobile/classes/review_database.dart';
import 'package:pj_mobile/classes/reviews.dart';
import 'package:pj_mobile/classes/tv_show.dart';
import 'package:pj_mobile/pages/tela_detalhes_serie.dart';
import 'package:pj_mobile/services/tv_show_service.dart';
import 'package:pj_mobile/core/constants.dart';
import 'package:pj_mobile/core/api_client.dart';

class TelaReview extends StatefulWidget {
  const TelaReview({super.key});

  @override
  State<StatefulWidget> createState() => _TelaReviewState();
}

class _TelaReviewState extends State<TelaReview> {
  final reviewsDatabase = ReviewDatabase();
  final reviewController = TextEditingController();
  final tvShowService = TvShowService();
  int? selectedTvShowId;
  final TextEditingController searchController = TextEditingController();
  List<TvShow> searchResults = [];

  Future<void> searchTvShows(String query) async {
    if (query.isEmpty) {
      setState(() => searchResults = []);
      return;
    }
    try {
      final endpoint =
          '/search/tv?query=$query&include_adult=false&language=pt-BR&page=1';
      final data = await ApiClient.get(endpoint);
      final List<dynamic> results = data['results'] as List<dynamic>;
      setState(() {
        searchResults =
            results
                .map((json) => TvShow.fromMap(json as Map<String, dynamic>))
                .toList();
      });
    } catch (e) {
      print('Erro ao buscar séries: $e');
    }
  }

  Future<void> selectTvShow() async {
    try {
      final tvShows = await tvShowService.getPopularTvShows();
      if (tvShows.isEmpty) {
        print('Nenhuma série retornada pela API.');
      }
      showDialog(
        context: context,
        builder:
            (BuildContext dialogContext) => AlertDialog(
              title: Text('Selecione uma Série'),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 300,
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: SingleChildScrollView(
                  child:
                      searchResults.isNotEmpty
                          ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                searchResults.length > searchLimit
                                    ? searchLimit
                                    : searchResults.length,
                            itemBuilder: (context, index) {
                              final tvShow = searchResults[index];
                              return ListTile(
                                title: Text(tvShow.name),
                                onTap: () {
                                  print(
                                    'Navegando para TelaDetalhesSerie com tvShowId: ${tvShow.id}',
                                  );
                                  Navigator.of(
                                        dialogContext,
                                        rootNavigator: true,
                                      )
                                      .push(
                                        MaterialPageRoute(
                                          builder:
                                              (_) => TelaDetalhesSerie(
                                                tvShowId: tvShow.id,
                                              ),
                                        ),
                                      )
                                      .then((_) => setState(() {}));
                                },
                              );
                            },
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                tvShows.length > searchLimit
                                    ? searchLimit
                                    : tvShows.length,
                            itemBuilder: (context, index) {
                              final tvShow = tvShows[index];
                              return ListTile(
                                title: Text(tvShow.name),
                                onTap: () {
                                  print(
                                    'Navegando para TelaDetalhesSerie com tvShowId: ${tvShow.id}',
                                  );
                                  Navigator.of(
                                        dialogContext,
                                        rootNavigator: true,
                                      )
                                      .push(
                                        MaterialPageRoute(
                                          builder:
                                              (_) => TelaDetalhesSerie(
                                                tvShowId: tvShow.id,
                                              ),
                                        ),
                                      )
                                      .then((_) => setState(() {}));
                                },
                              );
                            },
                          ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Fechar'),
                ),
              ],
            ),
      );
    } catch (e) {
      print('Erro ao carregar séries: $e');
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Erro'),
              content: Text('Falha ao carregar séries: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  void addnewReview() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Nova Review'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: reviewController),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: selectTvShow,
                  child: Text(
                    selectedTvShowId == null
                        ? 'Selecionar Série'
                        : 'Série: ${selectedTvShowId}',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  reviewController.clear();
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  if (selectedTvShowId != null) {
                    final newReview = Reviews(
                      review: reviewController.text,
                      tvShowId: selectedTvShowId,
                    );
                    reviewsDatabase.createReview(newReview);
                  }
                  Navigator.pop(context);
                  reviewController.clear();
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
    );
  }

  void editOrDeleteReview(Reviews review) {
    reviewController.text = review.review;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Editar ou Excluir Review'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: reviewController,
                  decoration: InputDecoration(labelText: 'Review'),
                ),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  reviewController.clear();
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  reviewsDatabase.updateReview(review, reviewController.text);
                  Navigator.pop(context);
                  reviewController.clear();
                  setState(() {}); // Atualiza a UI
                },
                child: const Text("Salvar"),
              ),
              TextButton(
                onPressed: () {
                  reviewsDatabase.deleteReview(review);
                  Navigator.pop(context);
                  reviewController.clear();
                  setState(() {}); // Atualiza a UI
                },
                child: const Text(
                  "Excluir",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void updateReview(Reviews reviews) {
    // Esta função pode ser removida ou integrada em editOrDeleteReview
    editOrDeleteReview(reviews);
  }

  void deleteReview(Reviews review) {
    // Esta função pode ser removida ou integrada em editOrDeleteReview
    editOrDeleteReview(review);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar série...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => searchTvShows(searchController.text),
                ),
              ),
              onSubmitted: searchTvShows,
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromARGB(255, 0, 150, 136),
      //   onPressed: addnewReview,
      //   child: const Icon(Icons.add),
      // ),
      body: Column(
        children: [
          if (searchResults.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount:
                    searchResults.length > searchLimit
                        ? searchLimit
                        : searchResults.length,
                itemBuilder: (context, index) {
                  final tvShow = searchResults[index];
                  return ListTile(
                    title: Text(tvShow.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => TelaDetalhesSerie(tvShowId: tvShow.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          Expanded(
            child: StreamBuilder(
              stream: reviewsDatabase.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final reviews = snapshot.data!;
                reviews.sort(
                  (a, b) => (b.createdAt ?? DateTime.now()).compareTo(
                    a.createdAt ?? DateTime.now(),
                  ),
                );
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3,
                  ),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return FutureBuilder<TvShow>(
                      future: tvShowService.getTvShowDetails(review.tvShowId!),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final tvShow = snapshot.data!;
                        return GestureDetector(
                          onTap: () => editOrDeleteReview(review),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tvShow.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Expanded(
                                    child: Text(
                                      review.review,
                                      maxLines: null,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
