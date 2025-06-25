import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pj_mobile/classes/review_database.dart';
import 'package:pj_mobile/classes/reviews.dart';

class TelaReview extends StatefulWidget {
  const TelaReview({super.key});

  @override
  State<StatefulWidget> createState() => _TelaReviewState();
}

class _TelaReviewState extends State<TelaReview> {
  //revies db
  final reviewsDatabase = ReviewDatabase();

  //text controller
  final reviewController = TextEditingController();

  //user wants to add a new review
  void addnewReview() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Nova Review'),
            content: TextField(controller: reviewController),
            actions: [
              //cancel button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  reviewController.clear();
                },
                child: const Text("Cancelar"),
              ),

              //save button
              TextButton(
                onPressed: () {
                  //create a new review and save on database
                  final newReview = Reviews(review: reviewController.text);
                  print(
                    'Enviando para o Supabase: ${newReview.toMap()}',
                  ); // Depuração
                  reviewsDatabase.createReview(newReview);

                  Navigator.pop(context);
                  reviewController.clear();
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
    );
  }

  //user wants to edit review
  void updateReview(Reviews reviews) {
    //pre-fill text controller with existing note
    reviewController.text = reviews.review;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Editar Review'),
            content: TextField(controller: reviewController),
            actions: [
              //cancel button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  reviewController.clear();
                },
                child: const Text("Cancelar"),
              ),

              //save button
              TextButton(
                onPressed: () {
                  reviewsDatabase.updateReview(reviews, reviewController.text);

                  Navigator.pop(context);
                  reviewController.clear();
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
    );
  }

  //user wants to delete review
  void deleteReview(Reviews review) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Excluir Review'),
            actions: [
              //cancel button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  reviewController.clear();
                },
                child: const Text("Cancelar"),
              ),

              //save button
              TextButton(
                onPressed: () {
                  reviewsDatabase.deleteReview(review);

                  Navigator.pop(context);
                  reviewController.clear();
                },
                child: const Text("Excluir"),
              ),
            ],
          ),
    );
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reviews")),

      //Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 150, 136),
        onPressed: addnewReview,
        child: const Icon(Icons.add),
      ),

      //Body => Streambuilder
      body: StreamBuilder(
        //listens to this
        stream: reviewsDatabase.stream,

        //to build a UI
        builder: (context, snapshot) {
          //loading..
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          //loaded
          final reviews = snapshot.data!;

          //list of notes UI
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              //get each note
              final review = reviews[index];

              //list tile UI
              return ListTile(
                title: Text(review.review),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      //edit button
                      IconButton(
                        onPressed: () => updateReview(review),
                        icon: const Icon(Icons.edit),
                      ),
                      //delete button
                      IconButton(
                        onPressed: () => deleteReview(review),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
