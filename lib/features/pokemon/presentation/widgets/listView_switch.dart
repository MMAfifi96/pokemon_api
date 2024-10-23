import 'package:flutter/material.dart';

class ListviewSwitch extends StatefulWidget {
  const ListviewSwitch({super.key});

  @override
  State<ListviewSwitch> createState() => _ListviewSwitchState();
}

class _ListviewSwitchState extends State<ListviewSwitch> {
  bool isOneItemListView = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Switch(
            value: isOneItemListView,
            onChanged: (value) {
              setState(() {
                isOneItemListView = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
