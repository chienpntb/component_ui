import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:se_gay_components/common/sg_text.dart';
import 'package:se_gay_components/common/sg_textfield.dart';

Future<List<String>?> showEditRowDialog({
  required BuildContext context,
  required String title,
  required List<String> headers,
  required List<String> initialValues,
  int topCount = 4,
}) {
  final controllers = List.generate(
    initialValues.length,
    (i) => TextEditingController(text: initialValues[i]),
  );
  log("show Popup");
  final int remain = initialValues.length - topCount;
  final int half = (remain / 2).ceil();

  // Top fields (full width)
  final topFields = List.generate(
    topCount,
    (i) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '${headers[i]}:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: SGTextField(
              height: 30,
              controller: controllers[i],
              readOnly: true
            ),
          ),
        ],
      ),
    ),
  );

  // Left and right fields (split)
  final leftFields = List.generate(
    half,
    (i) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: SGText(
              text: 
              '${headers[i + topCount]}:',
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SGTextField(
              height: 30,
              controller: controllers[i + topCount],
            ),
          ),
        ],
      ),
    ),
  );

  final rightFields = List.generate(
    remain - half,
    (i) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '${headers[i + topCount + half]}:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: SGTextField(
              height: 30,
              controller: controllers[i + topCount + half],
            ),
          ),
        ],
      ),
    ),
  );

  return showDialog<List<String>>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...topFields,
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Column(children: leftFields)),
                const SizedBox(width: 50),
                Expanded(child: Column(children: rightFields)),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final List<String> newValues = controllers.map((c) => c.text).toList();
            Navigator.pop(context, newValues);
          },
          child: const Text('Lưu'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Đóng'),
        ),
      ],
    ),
  );
}