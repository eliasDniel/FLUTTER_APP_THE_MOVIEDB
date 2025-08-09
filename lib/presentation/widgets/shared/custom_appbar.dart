import 'package:flutter/material.dart';

import '../../delegates/search_movie_delagate.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorStyle = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: Container(
        color: Colors.red,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.movie_outlined, color: colorStyle.primary),
                onPressed: () {},
              ),
              SizedBox(width: 5),
              Text(
                'EK FilmApp',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Handle search button press
                  showSearch(context: context, delegate: SearchMovieDelagate());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
