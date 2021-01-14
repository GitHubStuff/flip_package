import 'dart:math';

import 'package:flip_package/source/cubit/transition_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlipWidget extends StatefulWidget {
  final Widget frontWidget;
  final Widget backWidget;
  FlipWidget(this.frontWidget, this.backWidget);

  @override
  _FlipWidget createState() => _FlipWidget();
}

class _FlipWidget extends State<FlipWidget> {
  TransitionCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = TransitionCubit(widget.frontWidget, widget.backWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransitionCubit, TransitionState>(
        cubit: cubit,
        builder: (cntx, state) {
          debugPrint('State: $state');
          if (state is TransitionInitial) {
            Future.delayed(Duration(seconds: 3), () {
              cubit.flipSides();
            });
          }
          return _buildFlipAnimation();
        });
  }

  Widget _buildFlipAnimation() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      transitionBuilder: __transitionBuilder,
      layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
      child: cubit.visibleSide,
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeInBack.flipped,
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
