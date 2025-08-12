import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'state.dart';

class SampleScreenBloc extends Bloc<SampleScreenEvent, SampleScreenState> {
  SampleScreenBloc(): super(SampleScreenState());
}