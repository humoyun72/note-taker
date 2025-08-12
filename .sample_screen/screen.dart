import 'package:flutter/material.dart';

import 'screen_wrapper.dart';


class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScreenWrapper(
        child: Scaffold(
            body: SafeArea(child: Container(

            )
          )
        )
    );
  }
}