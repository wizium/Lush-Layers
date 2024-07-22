import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorBar extends StatelessWidget {
  const ColorBar({super.key, required this.colors});

  final List<Color?>? colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          colors == null ? 5 : colors!.length,
          (color) {
            return GestureDetector(
              onLongPress: () {
                HapticFeedback.vibrate();
                Clipboard.setData(ClipboardData(
                  text: colors![color]
                      .toString()
                      .replaceAll("Color(0xff", "")
                      .replaceAll(")", ""),
                )).then((result) {});
              },
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: colors == null
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : colors![color],
                  shape: BoxShape.circle,
                ),
                height: MediaQuery.of(context).size.width / 8,
                width: MediaQuery.of(context).size.width / 8,
              ),
            );
          },
        ),
      ),
    );
  }
}
