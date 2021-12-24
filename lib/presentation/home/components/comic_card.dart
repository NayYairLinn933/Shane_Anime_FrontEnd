import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/application/episodes/episodes_bloc.dart';
import 'package:movie_app/domain/episodes/episodes.dart';
import '../../../domain/comic/comic.dart';
import '../../../helper/global/image_widget.dart';
import '../../details/details_screen.dart';

class ComicCard extends StatelessWidget {
  final Comic comic;
  final int height;
  final int width;

  const ComicCard({
    Key? key,
    required this.comic,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 10.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DetailsScreen(comicId: comic.id!)));
            },
            child: SizedBox(
              height: height.h,
              width: width.w,
              child: ImageWidget(image: comic.coverPhoto),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 150.w),
            child: Text(
              comic.title,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          BlocBuilder<EpisodesBloc, EpisodesState>(
            builder: (context, state) {
              return state.maybeMap(
                  orElse: () => Container(),
                  loaded: (state) {
                    Episodes? lastChapter;
                    if (state.episodes.isEmpty) {
                      lastChapter = Episodes(
                          comicId: comic.id!,
                          episodeNumber: 0,
                          episodeName: "No Chapter",
                          like: {},
                          driveLink: "",
                          pdfFile: "");
                    } else {
                      lastChapter = state.episodes.last;
                    }
                    return Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lastChapter.episodeName,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            lastChapter.episodeNumber.toString(),
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
