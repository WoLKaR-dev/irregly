import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irregly/style/general_style.dart';
import '../template/verb_template.dart';

//STYLE Tarjeta de verbo
class VerbCard extends StatelessWidget {
  final Verb verb;
  final dynamic onPressed;

  const VerbCard({super.key, required this.verb, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onPressed ?? () {},
        child: Container(
          decoration: BoxDecoration(
            color: colorPallete.surfaceContainer,
            border: Border.all(color: colorPallete.outline),
            borderRadius: BorderRadius.circular(360),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                H5(verb.infinitive),
                Spacer(),
                Icon(Icons.arrow_forward, size: 45.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
