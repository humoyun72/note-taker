import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_taker/features/home_screen/bloc/bloc.dart';
import 'package:note_taker/features/home_screen/bloc/event.dart';
import 'package:note_taker/features/home_screen/bloc/state.dart';
import 'package:note_taker/generated/assets.dart';
import 'package:note_taker/shared/model/note.dart';

import 'screen_wrapper.dart';


const List<Color> noteColor = [
  Color(0xFFC4FFCA),
  Color(0xFFC5CBFF),
  Color(0xFFFBBECF),
  Color(0xFF96F4F4),
  Color(0xFFFDF3BF),
  Color(0xFFFEC5FF),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreenWrapper(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Recent Notes"),
              actions: [
                IconButton(onPressed: () {},
                    icon: SvgPicture.asset(Assets.assetsIconsSearch))
              ],
              actionsPadding: const EdgeInsets.only(right: 16),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFFE8505B),
              shape: CircleBorder(),
              onPressed: () {
                //TODO go to create note screen
              },
                child: Icon(Icons.add, color: Colors.white, size: 32,)),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: SafeArea(child: BlocBuilder<HomeScreenBloc, HomeScreenState>(builder: (context, state) {
              return _buildNotes(context, state.notes);
            },

            )
            )
        )
    );
  }

  Widget _buildNotes(BuildContext context, List<Note> notes) {
    if (notes.isEmpty) {
      return const Center(child: Text("No notes found"));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeScreenBloc>().add(LoadNotesEvent());
          },
          child: MasonryGridView.count(
              itemCount: notes.length,
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                final note = notes[index];

                //random color for background
                final randomColor = noteColor[index % noteColor.length];

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: randomColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        // note.content,
                        index % 2 == 1 ? "content $index" : ""
                            "lorem  ipsum dolor sit amter for "
                            "windows application and high quality images",
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                );
              }
          ),
        ),
      );

    }
  }
}