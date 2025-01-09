import 'package:flutter/material.dart';

class ListviewSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ListviewSwitch(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: Colors.green,
            activeThumbImage: AssetImage(
              'assets/images/pokemon-ball-nbg.png',
            ),
            inactiveThumbImage: AssetImage(
              'assets/images/pokemon-ball-nbg.png',
            ),
          ),
        ],
      ),
    );
  }
}
