import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: Stack(
        children: [
          // Movie list
          Positioned.fill(
            child: Consumer<MovieProvider>(
              builder: (context, movieProvider, child) {
                if (movieProvider.movies.isEmpty) {
                  movieProvider.fetchMovies();
                  return Center(child: CircularProgressIndicator());
                } else if (movieProvider.hasError) {
                  return Center(child: Text(movieProvider.error.toString()));
                } else {
                  return ListView.builder(
                    itemCount: movieProvider.movies.length,
                    itemBuilder: (context, index) {
                      final movie = movieProvider.movies[index];
                      return _MovieCard(movie);
                    },
                  );
                }
              },
            ),
          ),
          // Search bar
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Implement search functionality
                    print('Search clicked');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieProvider with ChangeNotifier {
  final String apiKey = '7e2888cb00457031860b026f0415280c';
  final String movieDetailsUrl = 'https://api.themoviedb.org/3/movie/popular';
  List<Movie> _movies = [];
  bool _hasError = false;
  String _error = '';

  List<Movie> get movies => _movies;
  bool get hasError => _hasError;
  String get error => _error;

  Future<void> fetchMovies() async {
    try {
      final response =
          await http.get(Uri.parse('$movieDetailsUrl?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _movies = List<Movie>.from(
            data['results'].map((movie) => Movie.fromJson(movie)));
      } else {
        _hasError = true;
        _error = 'Failed to fetch movies';
      }
    } catch (e) {
      _hasError = true;
      _error = e.toString();
    }
    notifyListeners();
  }
}

class Movie {
  final String title;
  final String posterPath;

  Movie({required this.title, required this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      posterPath: json['poster_path'],
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;

  const _MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          // Display movie poster image
          Image.network(
            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
            width: 100,
            height: 150,
          ),
          SizedBox(width: 16),
          Text(
            movie.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
