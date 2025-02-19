import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reslink_test/constants/colors.dart';

import '../constants/dimensions.dart';

class NormalTextBody extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  final double size;
  const NormalTextBody({
    required this.text,
    this.color = Colors.black,
    super.key,
    this.weight= FontWeight.bold,
    this.size = 0.038
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        color: color,
        fontWeight: weight,
        fontSize: getScreenWidth(context) * size,
      ),
    );
  }
}

class CustomSwiperPaginationBuilder extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(config.itemCount, (index) {
        bool isActive = index == config.activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? darkBlackShade : secondaryGreyColor, // Active/Inactive color
            borderRadius: isActive ? BorderRadius.circular(4.0) : BorderRadius.circular(4), // Rectangle for active, circular for inactive
          ),
        );
      }),
    );
  }
}

class SimpleChildButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? splashColor;
  final double? padding;

  const SimpleChildButton({
    super.key,
    required this.onTap,
    required this.child,
    this.splashColor = Colors.grey,
    this.padding = 0
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(padding!),
        child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            splashColor: splashColor!.withOpacity(0.2),  // Ripple effect color
            child: child
        ),
      ),
    );
  }
}