import 'package:flutter/material.dart';
import 'package:roam/theme/pallete.dart';

class StarRating extends StatefulWidget {
  final int rating;
  final Function(int) onRatingChanged;

  const StarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  State createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: IconButton(
              icon: Icon(
                index < widget.rating ? Icons.star : Icons.star_border,
                color: Pallete.yellow,
              ),
              onPressed: () {
                widget.onRatingChanged(index + 1);
              },
            ),
          );
        },
      ),
    );
  }
}
