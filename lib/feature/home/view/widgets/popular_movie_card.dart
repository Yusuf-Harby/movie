import 'package:flutter/material.dart';
import 'package:movie/core/constants/api_constants.dart';

class ItemMovieWidget extends StatelessWidget {
  const ItemMovieWidget({super.key, required this.posterPath, this.onTap});
  final String posterPath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 13),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),

          child: AspectRatio(
            aspectRatio: 10 / 15,
            child: Image.network(
              fit: BoxFit.contain,
              "${ApiConstants.imagePath}$posterPath",
            ),
          ),
        ),
      ),
    );
  }
}
