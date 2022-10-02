import 'package:flutter/material.dart';
import '../../API/Models/Movie.dart';
import '../../API/RemoteMovieAPI.dart';

class DetailMovie extends StatelessWidget {
  DetailMovie({super.key, required this.id});
  late Future<Movie> futureMovie = RemoteMovieAPI().getMovieDetail(id);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Description'),
        ),
        body: FutureBuilder<Movie> (
          future: futureMovie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          snapshot.data!.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        )
                    ),
                    Expanded(
                        flex: 4,
                        child: Stack(
                          children: <Widget>[
                            const Center(child: CircularProgressIndicator()),
                            Center(
                                child: Image(
                                  image: NetworkImage('https://image.tmdb.org/t/p/original/${snapshot.data!.image}'),
                                )
                            ),
                          ],
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${snapshot.data!.date} - ${snapshot.data!.duration}'),
                              Text(snapshot.data!.genres.join(', '))
                            ],
                          ),
                        )
                    ),
                    Expanded(
                        flex: 5,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Synopsis",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(snapshot.data!.description),
                                )
                              ],
                            )
                        )
                    )
                  ],
                ),
              );
              return
                Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )
    );
  }
}