
import 'package:flutter/material.dart';

class AddNoteComponent extends StatefulWidget {
  const AddNoteComponent({
    super.key,
    required this.voidCallback,
  });

  final VoidCallback voidCallback;

  @override
  State<AddNoteComponent> createState() => _AddNoteComponentState();
}

class _AddNoteComponentState extends State<AddNoteComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Color(0xff664EAB).withValues(alpha: 0.5))),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          widget.voidCallback.call();
        },
        child: Icon(
          Icons.add,
          size: 14,
        ),
      ),
    );
  }
}
