import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Trending Movies'),
            SizedBox(height: 8.0),
            TrendingMovieSection(),
            SizedBox(height: 16.0),
            SectionTitle(title: 'Recently Added'),
            SizedBox(height: 8.0),
            RecentlyAddedMovieSection(),
            SizedBox(height: 16.0),
            SectionTitle(title: 'Your Recommendations'),
            SizedBox(height: 8.0),
            RecommendationsSection(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  MovieCard({required this.title, required this.imageUrl});

  factory MovieCard.json(Map<String, dynamic> json) {
    return MovieCard(
      title: json['title'],
      imageUrl:
          'https://image.tmdb.org/t/p/w500${json['https://api.themoviedb.org/3/movie/upcoming ']}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
            child: Image.network(
              imageUrl,
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieCardWidget extends StatelessWidget {
  final MovieCard movieCard;
  MovieCardWidget({required this.movieCard});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            movieCard.imageUrl,
            fit: BoxFit.cover,
            height: 160,
            width: 120,
          ),
          SizedBox(height: 8),
          Text(
            movieCard.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class TrendingMovieSection extends StatefulWidget {
  @override
  _TrendingMovieSectionState createState() => _TrendingMovieSectionState();
}

class _TrendingMovieSectionState extends State<TrendingMovieSection> {
  final String apiKey = '7e2888cb00457031860b026f0415280c';
  Future<Iterable<MovieCard>> fetchTrendingMovies() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey&language=en-US&page=1',
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map(
        (e) => MovieCard(title: 'title', imageUrl: 'imageUrl'),
      );
    } else {
      throw Exception('failed to load trending movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<MovieCard>>(
      future: fetchTrendingMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No trending movies available');
        } else {
          Iterable<MovieCard> trendingMovies = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  'Trending movies',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: trendingMovies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        title: '',
                        imageUrl: '',
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class RecentlyAddedMovieSection extends StatefulWidget {
  @override
  _RecentlyAddedMovieSectionState createState() =>
      _RecentlyAddedMovieSectionState();
}

class _RecentlyAddedMovieSectionState extends State<RecentlyAddedMovieSection> {
  final String apiKey = '';
  Future<Iterable<MovieCard>> fetchRecentlyAddedMovies() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1',
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map(
        (e) => MovieCard(title: 'title', imageUrl: 'imageUrl'),
      );
    } else {
      throw Exception('failed to load recently added movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<MovieCard>>(
      future: fetchRecentlyAddedMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No recently added movies available');
        } else {
          Iterable<MovieCard> recentlyAddedMovies = snapshot.data!;
          var movieCard;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: recentlyAddedMovies
                  .map((MovieCard) => MovieCardWidget(movieCard: movieCard))
                  .toList(),
            ),
          );
        }
      },
    );
  }
}

class RecommendationsSection extends StatefulWidget {
  @override
  _RecommendationsSectionState createState() => _RecommendationsSectionState();
}

class _RecommendationsSectionState extends State<RecommendationsSection> {
  final String apiKey = '';
  Future<Iterable<MovieCard>> fetchRecommendations() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1',
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map(
        (e) => MovieCard(title: 'title', imageUrl: 'imageUrl'),
      );
    } else {
      throw Exception('failed to load recommendations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<MovieCard>>(
      future: fetchRecommendations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No recommendations available');
        } else {
          Iterable<MovieCard> recommendations = snapshot.data!;
          var movieCard;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: recommendations
                  .map((MovieCard) => MovieCardWidget(movieCard: movieCard))
                  .toList(),
            ),
          );
        }
      },
    );
  }
}
