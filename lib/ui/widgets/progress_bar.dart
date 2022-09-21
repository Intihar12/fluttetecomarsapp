import 'package:flutter/material.dart';

import '../values/my_colors.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColors.white,
        color: MyColors.primaryColor,
        strokeWidth: 4,
      ),
    );
  }
}
