import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/episodes.dart';
import '../../../bloc/details/details_bloc.dart';

import '../../../../../injector.dart';

import 'widgets/reading_view.dart';

class ReadingScreen extends StatefulWidget {
  final Episode episodes;
  ReadingScreen({Key? key, required this.episodes}) : super(key: key);

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.episodes.episodeName),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => sl<DetailsBloc>()
            ..add(CheckPdfOrImagesEvent(
                widget.episodes.comicId, widget.episodes.episodeName)),
          child: ReadingView(
            episodes: widget.episodes,
            isDarkMode: isDarkMode,
          ),
        ));
  }
}
