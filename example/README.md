# flip_package

Simple animation StatelessWidget that takes two(2) widgets and lets them flip like
a coin or a card reveal

Flip two widgets like a coin:

A front widget and back widget flip along X-axis or Y-axis

## Usage

```dart
FlipWidget(
      frontWidget: Container(height: 100, width: 100, color: Colors.blue),
      backWidget: Container(height: 100, width: 100, color: Colors.green),
      flipAlongXAxis: true,
      duration: Duration(milliseconds: 800),
      flipCallback: (FlipSide side) {
        debugPrint('Side: $side');
      },
    );

```

where:

flipAlongXAxis - default 'true' flips along the X-axis. 'false' flips along Y-axis

duration - default is 800 milliseconds

flipCallback - FlipSide is enum with values 'front' and 'back', this callback is made each time (after inital display) if the frontWidget or backWidget is displayed.
