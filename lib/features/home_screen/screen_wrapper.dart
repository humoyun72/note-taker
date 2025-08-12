import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:note_taker/features/home_screen/bloc/event.dart';

import 'bloc/bloc.dart';


class HomeScreenWrapper extends StatelessWidget {
  final Widget child;
  const HomeScreenWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
       create: (context) => HomeScreenBloc(GetIt.I.get())..add(LoadNotesEvent()),
       child: child
   );
  }
}