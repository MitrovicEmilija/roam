import 'package:flutter/material.dart';
import 'package:roam/theme/pallete.dart';

class StarRating extends StatefulWidget {
  final List<int> ratings;
  final Function(int) onRatingChanged;

  const StarRating({
    Key? key,
    required this.ratings,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  State createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _userRating;

  @override
  void initState() {
    super.initState();
    _userRating = widget.ratings.isNotEmpty
        ? widget.ratings.reduce((a, b) => a + b) ~/ widget.ratings.length
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: IconButton(
              icon: Icon(
                index < _userRating ? Icons.star : Icons.star_border,
                color: Pallete.yellow,
              ),
              onPressed: () {
                setState(() {
                  _userRating = index + 1;
                });
                widget.onRatingChanged(_userRating);
              },
            ),
          );
        },
      ),
    );
  }
}
