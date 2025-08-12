import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_taker/features/home_screen/bloc/bloc.dart';
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
            body: SafeArea(child: BlocBuilder<HomeScreenBloc, HomeScreenState>(builder: (context, state) {
              return _buildNotes(state.notes);
            },

            )
          )
        )
    );
  }

  Widget _buildNotes(List<Note> notes) {
    if (notes.isEmpty) {
      return const Center(child: Text("No notes found"));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: notes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16
            ),
            itemBuilder: (context, index) {
              final note = notes[index];

              //random color for background
              final randomColor = noteColor[index % noteColor.length];

              return Container(
                color: randomColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(note.title),
                    const SizedBox(height: 8),
                    Expanded(child:
                     Text(note.content)
                    )
                  ],
                ),
              );
            }
        ),
      );

    }
  }
}