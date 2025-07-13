import 'package:flutter/material.dart';
import 'package:se_gay_components/common/sg_colors.dart';

class ZHView extends StatefulWidget {
  const ZHView({super.key});

  @override
  State<ZHView> createState() => _ZHViewState();
}

class _ZHViewState extends State<ZHView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: SGAppColors.error700,
    );
  }
}