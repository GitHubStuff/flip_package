// Copyright 2021 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

library flip_package;

export 'source/flip_widget.dart';

enum FlipSide {
  front,
  back,
}

extension FlipSideExtension on FlipSide {
  FlipSide get toggle => (this == FlipSide.back) ? FlipSide.front : FlipSide.back;
}
