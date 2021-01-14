library flip_package;

export 'source/cubit/transition_cubit.dart';
export 'source/flip_widget.dart';

enum FlipSide {
  front,
  back,
}

extension FlipSideExtension on FlipSide {
  FlipSide get toggle => (this == FlipSide.back) ? FlipSide.front : FlipSide.back;
}
