import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import './Models/Movie.dart';

class RemoteMovieAPI {

  Future<Movie> getMovieDetail(int id) async {
    String apiKey = await getApiKey();
    final response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=fr-FR'));

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

  Future<List<Movie>> getMovies() async {
    String apiKey = await getApiKey();
    final response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=fr-FR&page=1'));
    print('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=fr-FR&page=1');
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

// Fetch content from the json file
  Future<String> getApiKey() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final data = await json.decode(response);
    return data['API_KEY'];
  }
}