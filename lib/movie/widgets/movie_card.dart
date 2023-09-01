// ignore_for_file: lines_longer_than_80_chars

import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cineket/app/widgets/custom_box_shadow.dart';
import 'package:cineket/helper/genre_finder.dart';
import 'package:cineket/helper/helper.dart';
import 'package:cineket/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.rating,
    required this.reviewer,
    required this.genreIds,
    super.key,
  });

  final String title;
  final String posterPath;
  final DateTime releaseDate;
  final double rating;
  final int reviewer;
  final List<int> genreIds;

  @override
  Widget build(BuildContext context) {
    final baseImageUrl = getEnvVariable('baseImageUrl');
    final dateFormat = DateFormat('dd MMM yyyy');
    final formattedDate = dateFormat.format(releaseDate);
    final genres = findMovieGenreNames(genreIds);

    return InkWell(
      onTap: () => {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            // BoxShadow(),
            CustomBoxShadow(
              color: AppColors.primary.withOpacity(.5),
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                // height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      '$baseImageUrl$posterPath',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.7),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(
                    left: 10,
                    // right: 16,
                    bottom: 5,
                    top: 10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        children: List.generate(
                          genres.length,
                          (index) => Text(
                            '${genres[index]}${index != genreIds.length - 1 ? ', ' : ''}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff9DB2CE).withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '$rating',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                      ),
                      const Icon(
                        Icons.star_border_purple500_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      Text(
                        ' | $reviewer reviews',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
