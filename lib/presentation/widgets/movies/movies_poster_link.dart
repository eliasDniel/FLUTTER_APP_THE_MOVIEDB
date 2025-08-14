import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';

class MoviesPosterLink extends StatelessWidget {
  final Movie movie;
  const MoviesPosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return FadeInUp(
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450) + 0),
      child: GestureDetector(
        onTap: () => context.push('/home/2/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: FadeInImage(
            height: 180,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/loaders/bottle-loader.gif'),
            image: NetworkImage(movie.posterPath!),
          ),
        ),
      ),
    );
  }
}
