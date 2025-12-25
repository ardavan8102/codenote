import 'package:flutter/material.dart';

class SingleNoteMetaDataRow extends StatelessWidget {
  const SingleNoteMetaDataRow({
    super.key,
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ],
    );
  }
}