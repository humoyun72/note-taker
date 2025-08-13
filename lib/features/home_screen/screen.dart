import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_taker/features/create_update_note_screen/screen.dart';
import 'package:note_taker/features/home_screen/bloc/bloc.dart';
import 'package:note_taker/features/home_screen/bloc/state.dart';
import 'package:note_taker/generated/assets.dart';
import 'package:note_taker/shared/db/database.dart';

import 'bloc/event.dart';
import 'screen_wrapper.dart';

const List<Color> noteColors = [
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
    // HomeScreen birinchi marta qurilganda event jo‘natamiz
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenBloc>().add(LoadNotesEvent());
    });
    return HomeScreenWrapper(
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('Recent Notes'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(Assets.iconsSearch),
              ),
            ],
            actionsPadding: const EdgeInsets.only(right: 16.0),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFFE8505B),
            shape: CircleBorder(),
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(builder: (_) => CreateUpdateNoteScreen()),
                  )
                  .then((result) {
                    if (result == true && context.mounted) {
                      context.read<HomeScreenBloc>().add(LoadNotesEvent());
                    }
                  });
            },
            child: Icon(Icons.add, color: Colors.white, size: 42),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(child: _buildNotes(context, state.notes)),
        ),
      ),
    );
  }

  Widget _buildNotes(BuildContext context, List<Note> notes) {
    if (notes.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text('No notes available'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context.read<HomeScreenBloc>().add(LoadNotesEvent());
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeScreenBloc>().add(LoadNotesEvent());
      },
      child: MasonryGridView.count(
        padding: const EdgeInsets.all(32),
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 20,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          int randomNumber = Random.secure().nextInt(100);
          Color randomColor = noteColors[randomNumber % noteColors.length];

          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: randomColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  note.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(note.content),
              ],
            ),
          );
        },
      ),
    );
  }
}
