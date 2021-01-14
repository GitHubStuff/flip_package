part of 'transition_cubit.dart';

@immutable
abstract class TransitionState {}

class TransitionInitial extends TransitionState {}

class FlipState extends TransitionState {}
