import 'package:flutter/material.dart';

import 'movieDetail.dart';
import 'API.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.movie,
    required this.thumbnail,
  });

  final Widget thumbnail;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 2), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          )
        ]
      ),
      child: InkWell(
        highlightColor: Colors.grey.withOpacity(0.3),
        splashColor: Colors.black.withOpacity(0.3),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailMovie(id: movie.id)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: thumbnail,
              ),
              Expanded(
                flex: 3,
                child: _MovieDescription(
                  movie: movie,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class _MovieDescription extends StatelessWidget {
  const _MovieDescription({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              movie.title,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Text(
              movie.date,
              style: const TextStyle(
                fontSize: 10.0,
                color: Colors.grey,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
            SizedBox(
              height: 80,
              child: Text(
                movie.description,
                overflow: TextOverflow.fade,
                style: const TextStyle(fontSize: 10.0),
              ),
            )

          ],
        ),
      );
  }
}

class ListViewCard extends StatelessWidget {
  final List<Movie> movies;
  const ListViewCard (this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    List<CustomListItem> moviesWidget = <CustomListItem>[];
    movies.forEach((element) {
      moviesWidget.add(CustomListItem(
        movie: element,
        thumbnail: Container(
          child: Image(
            image: NetworkImage('https://image.tmdb.org/t/p/original/${element.image}'),
          ),
        ),
      ));
    });

    return ListView(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        itemExtent: 150,
        children: moviesWidget
    );
  }
}

