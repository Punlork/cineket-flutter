import 'dart:ffi';

import 'package:cineket/helper/helper.dart';
import 'package:cineket/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.title,
    required this.backDropPath,
    required this.releaseDate,
    required this.rating,
    super.key,
  });

  final String title;
  final String backDropPath;
  final DateTime releaseDate;
  final double rating;

  @override
  Widget build(BuildContext context) {
    final baseImageUrl = getEnvVariable('baseImageUrl');
    final dateFormat = DateFormat('dd MMM yyyy');
    final formattedDate = dateFormat.format(releaseDate);

    return InkWell(
      onTap: () => {},
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  '$baseImageUrl$backDropPath',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 45,
                width: 45,
                margin: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '$rating %',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
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
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
