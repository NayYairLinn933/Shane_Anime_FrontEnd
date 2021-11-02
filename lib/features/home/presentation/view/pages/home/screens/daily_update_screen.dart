import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../../core/global/loading_indicator.dart';
import '../../../../../../../core/strings/constants.dart';
import '../../../../bloc/filter_episode/filterepisode_bloc.dart';

import '../../reading/reading_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyUpdateScreen extends StatefulWidget {
  const DailyUpdateScreen({Key? key}) : super(key: key);

  @override
  _DailyUpdateScreenState createState() => _DailyUpdateScreenState();
}

class _DailyUpdateScreenState extends State<DailyUpdateScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(fontSize: 18),
                    weekendStyle: TextStyle(fontSize: 18)),
                daysOfWeekHeight: 80,
                pageJumpingEnabled: true,
                rowHeight: 65,
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                  String date = DateFormat.yMMMEd().format(_selectedDay!);
                  String dateComma = date.replaceAll(",", "");

                  BlocProvider.of<FilterepisodeBloc>(context)
                      .add(FilterEpisode(dateComma));
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 50),
              BlocBuilder<FilterepisodeBloc, FilterepisodeState>(
                builder: (context, state) {
                  if (state is FilterepisodeLoading) {
                    return const LoadingIndicator();
                  }
                  if (state is FilterepisodeInitial) {
                    return const Text(
                      "Please Selects a date",
                      style: TextStyle(fontSize: 23),
                    );
                  }

                  if (state is FilteredEpisodesLoaded) {
                    if (state.filterEpisodes.isEmpty) {
                      return const Text(
                        "No Results Found",
                        style: TextStyle(fontSize: 23),
                        textAlign: TextAlign.center,
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.filterEpisodes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(state.filterEpisodes[index].title),
                          subtitle: Text(
                              "${state.filterEpisodes[index].title}${state.filterEpisodes[index].episodeNumber.toString()}"),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ReadingScreen(
                                    episodes: state.filterEpisodes[index])));
                          },
                          leading: Container(
                            height: 70,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(state
                                        .filterEpisodes[index].coverPhoto))),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
