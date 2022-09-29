import 'package:flutter/material.dart';
import 'API.dart';
import 'MainPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String _title = 'Les films les plus populaires';
  late Future<List<Movie>> futureMovie;

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovies('https://api.themoviedb.org/3/movie/popular?api_key=dca309ca9e7c31eeb41785f6cf541371&language=fr-FR&page=1');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: FutureBuilder<List<Movie>>(
            future: futureMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListViewCard(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
      ),
      ),
    );
  }
}