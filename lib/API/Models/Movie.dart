import 'package:intl/intl.dart';

class Movie {
  final int id;
  final String title;
  final String date;
  final String description;
  final String image;
  final String duration;
  final List<dynamic> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.image,
    this.duration = '',
    this.genres = const <dynamic>[],
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      date: DateFormat('dd/MM/yyyy').format(DateTime.parse(json['release_date'])),
      description: json['overview'],
      image: json['poster_path'],
      duration: json['runtime'] != null ? '${(json['runtime']/60).floor()}h${json['runtime']%60 < 10 ? '0' : ''}${json['runtime']%60}' : '',
      genres: json['genres'] == null ? [] : json['genres'].map((e) => e['name']!).toList(),
    );
  }
}