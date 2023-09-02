import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineket/actors/model/response.dart';
import 'package:cineket/theme/theme.dart';
import 'package:flutter/material.dart';

class ActorCard extends StatelessWidget {
  const ActorCard({
    required this.profileUrl,
    required this.name,
    required this.knownForDepartment,
    required this.popularity,
    required this.knownFor,
    super.key,
  });

  final String profileUrl;
  final String name;
  final String knownForDepartment;
  final double popularity;
  final List<KnownFor> knownFor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: profileUrl,
                width: 100,
                height: 120,
                memCacheHeight: 780,
                memCacheWidth: 780,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: AppColors.primary,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          knownForDepartment,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
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
                          ' | $popularity popularity',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Known for: ',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        Expanded(
                          child: Wrap(
                            children: List.generate(
                              knownFor.length,
                              (index) {
                                final tempKnowFor = knownFor[index];
                                if (tempKnowFor.title == null ||
                                    tempKnowFor.originalTitle == null) {
                                  return const SizedBox();
                                }
                                final title = tempKnowFor.title ??
                                    tempKnowFor.originalTitle ??
                                    '';

                                return Text(
                                  '$title${index != knownFor.length - 1 ? ', ' : ''}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
