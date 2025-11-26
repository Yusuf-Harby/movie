import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_colors.dart';
import 'package:movie/core/constants/app_strings.dart';

class TopMovieCard extends StatelessWidget {
  const TopMovieCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2.5,
      height: 210,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 144 / 210,
              child: Image.network(
                'https://m.media-amazon.com/images/I/61CRq2R6i4L._AC_SL1024_.jpg',
                fit: BoxFit.cover,
              ),
              // : Container(
              //     color: AppColors.gray,
              //     alignment: Alignment.center,
              //     child: Text(
              //       movie.title,
              //       textAlign: TextAlign.center,
              //       style: Theme.of(
              //         context,
              //       ).textTheme.bodySmall?.copyWith(color: AppColors.white),
              //     ),
              //   ),
            ),
          ),
          Positioned(
            left: -10,
            bottom: -40,
            child: Stack(
              children: [
                // Stroke
                Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).width / 3,
                    fontFamily: AppStrings.fontPopular,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = AppColors.selected,
                    shadows: const [
                      Shadow(
                        color: AppColors.black,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                // Fill
                Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).width / 3,
                    fontFamily: AppStrings.fontPopular,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
