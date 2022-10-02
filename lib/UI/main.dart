import 'package:flutter/material.dart';
import '../API/RemoteMovieAPI.dart';
import '../API/Models/Movie.dart';
import './List/List.dart';

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
    futureMovie = RemoteMovieAPI().getMovies();
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