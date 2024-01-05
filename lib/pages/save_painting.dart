import 'package:canvasthoughtsflutter/widgets/stateful/museumList.dart';
import 'package:flutter/material.dart';


class SelectandSave extends StatefulWidget {
  const SelectandSave({super.key});

  @override
  State<SelectandSave> createState() => _SelectandSaveState();
}

class _SelectandSaveState extends State<SelectandSave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          MuseumList(onTapMuseum: 'save', parentContext: context)
        ],
      )
    );
  }
}
