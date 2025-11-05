import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irregly/style/general_style.dart';

//STYLE Download Card
class VerbDownloadCard extends StatelessWidget {
  final String text;
  final dynamic onTap;

  const VerbDownloadCard({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
          decoration: BoxDecoration(
            color: colorPallete.surfaceContainer,
            border: Border.all(color: colorPallete.outline),
            borderRadius: BorderRadius.circular(360),
          ),
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              H5(text),
              Spacer(),
              Icon(Icons.download, size: 45.w),
            ],
          ),
        ),
      ),
    );
  }
}
