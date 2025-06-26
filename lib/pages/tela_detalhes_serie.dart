import 'package:flutter/material.dart';
import 'package:pj_mobile/classes/review_database.dart';
import 'package:pj_mobile/classes/reviews.dart';
import 'package:pj_mobile/classes/tv_show.dart';
import 'package:pj_mobile/services/tv_show_service.dart';
import 'package:pj_mobile/core/constants.dart'; // Para usar tmdbBaseUrl, se necessário

class TelaDetalhesSerie extends StatefulWidget {
  final int tvShowId;

  const TelaDetalhesSerie({super.key, required this.tvShowId});

  @override
  State<TelaDetalhesSerie> createState() => _TelaDetalhesSerieState();
}

class _TelaDetalhesSerieState extends State<TelaDetalhesSerie> {
  final reviewController = TextEditingController();
  final tvShowService = TvShowService();
  final reviewsDatabase = ReviewDatabase();

  void addReview() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Adicionar Review'),
            content: TextField(controller: reviewController),
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
                  final newReview = Reviews(
                    review: reviewController.text,
                    tvShowId: widget.tvShowId,
                  );
                  reviewsDatabase.createReview(newReview);
                  Navigator.pop(context);
                  reviewController.clear();
                  setState(() {}); // Atualiza a lista de reviews
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes da Série")),
      body: FutureBuilder<TvShow>(
        future: tvShowService.getTvShowDetails(widget.tvShowId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final tvShow = snapshot.data!;
          return FutureBuilder<List<Reviews>>(
            future: reviewsDatabase.getReviewsByTvShowId(widget.tvShowId),
            builder: (context, reviewSnapshot) {
              if (!reviewSnapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final reviews = reviewSnapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner da série
                    if (tvShow.backdropPath != null)
                      Container(
                        height: 200, // Altura fixa para o banner
                        width: double.infinity,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${tvShow.backdropPath}',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                            ); // Placeholder em caso de erro
                          },
                        ),
                      ),
                    // Conteúdo existente
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tvShow.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Estreia: ${tvShow.firstAirDate?.toLocal().toString().split(' ')[0] ?? 'Não disponível'}',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            tvShow.overview ?? 'Sem descrição disponível',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: addReview,
                            child: Text('Adicionar Review'),
                          ),
                          SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              final review = reviews[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(title: Text(review.review)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
