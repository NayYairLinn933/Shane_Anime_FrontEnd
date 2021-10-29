import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/global/error_message.dart';
import '../../../home/presentation/view/pages/home/widgets/shimmer_genre.dart';
import '../bloc/genre_bloc.dart';
import 'widgets/genre_item.dart';

class GenreList extends StatelessWidget {
  const GenreList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is GenreLoading) {
          return const ShimmerGenre();
        }
        if (state is GenreError) {
          return ErrorMessage(
            message: state.message,
            isSliver: true,
          );
        }
        if (state is GenreSuccess) {
          return SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: state.genres
                    .map((e) => GenreItem(
                          genre: e,
                        ))
                    .toList(),
              ),
            ),
          );
        }
        return SliverToBoxAdapter(child: Container());
      },
    );
  }
}
