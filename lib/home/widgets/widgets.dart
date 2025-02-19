import 'package:flutter/material.dart';
import 'package:reslink_test/constants/colors.dart';
import 'package:reslink_test/constants/dimensions.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 5),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: getScreenHeight(context) * 0.5,
        child: Container(),
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50)
      ),
      width: getScreenWidth(context) * 0.35,
      child: SliderTheme(
        data: SliderThemeData(
            trackHeight: getScreenHeight(context) * 0.075,
            activeTrackColor: secondaryBlueColor,
            inactiveTrackColor: inactiveTrackColor,
            thumbColor: Colors.transparent,
            overlayShape: SliderComponentShape.noThumb,
            valueIndicatorShape: SliderComponentShape.noOverlay,
            trackShape: const RectangularSliderTrackShape(),
            thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 0,
                disabledThumbRadius: 0
            )
        ),
        child: Slider(
            value: value,
            activeColor: secondaryBlueColor,
            inactiveColor: inactiveTrackColor,
            label: 'green',
            overlayColor: WidgetStateProperty.resolveWith<Color>((state)=>secondaryBlueColor),
            onChanged: onChanged),
      ),
    );
  }
}