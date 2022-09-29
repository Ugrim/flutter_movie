import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Movie {
  final int id;
  final String title;
  final String date;
  final String description;
  final String image;
  final List<dynamic> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.image,
    this.genres = const <dynamic>[],
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      date: DateFormat('dd/MM/yyyy').format(DateTime.parse(json['release_date'])),
      description: json['overview'],
      image: json['poster_path'],
      genres: json['genre'] == null ? [] : json['genres'].map((e) => e['name']!).toList(),
    );
  }
}

Future<Movie> getMovieDetail(int id) async {
  final response = await http
      .get(Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=dca309ca9e7c31eeb41785f6cf541371&language=fr-FR'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Movie.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Movie>> fetchMovies(String imageUrl) async {
  final response = await http
      .get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Movie> movies = [];
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> entitlements = map['results'];
    for (var value in entitlements) {
      movies.add(Movie.fromJson(value));
    }
    return movies;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}