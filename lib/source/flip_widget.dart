// Copyright 2021 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flip_package/source/cubit/transition_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../flip_package.dart';

typedef FlipCallback = void Function(FlipSide side);

class FlipWidget extends StatelessWidget {
  final Widget frontWidget;
  final Widget backWidget;
  final FlipCallback flipCallback;
  final TransitionCubit cubit;
  final Duration duration;
  final bool flipXAxis;

  FlipWidget({
    @required this.frontWidget,
    @required this.backWidget,
    @required this.flipCallback,
    Duration flipDuration,
    bool flipAlongXAxis,
  })  : assert(frontWidget != null),
        assert(backWidget != null),
        assert(flipCallback != null),
        duration = flipDuration ?? Duration(milliseconds: 800),
        flipXAxis = flipAlongXAxis ?? true,
        cubit = TransitionCubit(frontWidget, backWidget);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransitionCubit, TransitionState>(
        cubit: cubit,
        builder: (cntx, state) {
          if (state is TransitionInitial) {
            cubit.flipXAxis = flipXAxis;
          }
          if (state is FlipState) {
            flipCallback(state.faceSide);
          }
          return _buildFlipAnimation();
        });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () => cubit.flipSides(),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
        child: cubit.visibleSide,
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(cubit.currentSide) != widget.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: cubit.flipXAxis ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt)) : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
