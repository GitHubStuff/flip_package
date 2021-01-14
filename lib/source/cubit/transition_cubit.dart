import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../flip_package.dart';

part 'transition_state.dart';

class TransitionCubit extends Cubit<TransitionState> {
  FlipSide currentSide = FlipSide.front;
  bool flipXAxis = true;
  Widget frontSide;
  Widget backSide;

  TransitionCubit(Widget frontWidget, Widget backWidget) : super(TransitionInitial()) {
    frontSide = Container(key: ValueKey(FlipSide.front), child: frontWidget);
    backSide = Container(key: ValueKey(FlipSide.back), child: backWidget);
  }

  Widget get visibleSide => (currentSide == FlipSide.front) ? frontSide : backSide;

  void flipSides() async {
    currentSide = currentSide.toggle;
    emit(FlipState(currentSide));
  }
}
