import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//STYLE AppPallete
ColorScheme colorPallete = ColorScheme.fromSeed(
  seedColor: Colors.lightGreenAccent,
);

//STYLE AppStyles
ThemeData appTheme() {
  return ThemeData(
    //SECTION Paleta
    colorScheme: colorPallete,

    //SECTION estilos
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: colorPallete.primaryFixed,
      indicatorColor: colorPallete.primaryFixedDim,
      labelType: NavigationRailLabelType.selected,
      selectedLabelTextStyle: TextStyle(
        fontFamily: "Outfit",
        color: colorPallete.onPrimaryFixed,
      ),
      selectedIconTheme: IconThemeData(color: colorPallete.onPrimaryFixed),
      unselectedIconTheme: IconThemeData(color: colorPallete.onPrimaryFixed),
    ),

    //SECTION Appbar
    appBarTheme: AppBarThemeData(
      centerTitle: true,
      backgroundColor: colorPallete.primaryFixedDim,
      titleTextStyle: TextStyle(
        color: colorPallete.onPrimaryFixed,
        fontFamily: "Outfit",
        fontSize: 40.w,
      ),
    ),

    //SECTION SnackBar
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(
        fontFamily: "Outfit",
        color: Colors.white70,
        fontSize: 40.w,
      ),
    ),

    //SECTION Alert Dialog
    dialogTheme: DialogThemeData(
      titleTextStyle: TextStyle(
        fontFamily: "Outfit",
        color: colorPallete.onSecondaryContainer,
        fontSize: 45.w,
      ),
      contentTextStyle: TextStyle(
        fontFamily: "Outfit",
        color: colorPallete.onSecondaryContainer,
        fontSize: 35.w,
      ),
    ),
  );
}

//STYLE Background
class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(color: colorPallete.surface),
      child: SafeArea(child: child),
    );
  }
}

//STYLE Scroll
class Scroll extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final double? spacing;

  const Scroll({super.key, required this.children, this.padding, this.spacing});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding ?? EdgeInsets.zero,
      child: Column(spacing: spacing ?? 0, children: children),
    );
  }
}

//STYLE Input
class Input extends StatelessWidget {
  final double? width;
  final TextEditingController controller;
  final dynamic onTapOutside;

  const Input({
    super.key,
    required this.controller,
    this.width,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null
          ? MediaQuery.sizeOf(context).width * (width! / 100)
          : MediaQuery.sizeOf(context).width,
      child: TextField(
        onTapOutside: onTapOutside ?? (value) {},
        style: TextStyle(
          fontFamily: "Outfit",
          color: colorPallete.onSecondaryContainer,
          fontSize: 40.w,
        ),
        decoration: InputDecoration(
          fillColor: colorPallete.secondaryContainer,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: colorPallete.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: colorPallete.outline, width: 2),
          ),
        ),
        controller: controller,
      ),
    );
  }
}

//STYLE Hs
class H1 extends StatelessWidget {
  final String text;
  final Color? textColor;

  const H1(this.text, {super.key, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Outfit",
        fontSize: 90.w,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class H2 extends StatelessWidget {
  final String text;
  final Color? textColor;

  const H2(this.text, {super.key, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Outfit",
        fontSize: 80.w,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class H3 extends StatelessWidget {
  final String text;
  final Color? textColor;

  const H3(this.text, {super.key, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Outfit",
        fontSize: 70.w,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class H4 extends StatelessWidget {
  final String text;
  final Color? textColor;

  const H4(this.text, {super.key, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Outfit",
        fontSize: 50.w,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class H5 extends StatelessWidget {
  final String text;
  final Color? textColor;

  const H5(this.text, {super.key, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Outfit",
        fontSize: 40.w,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class H6 extends StatelessWidget {
  final String text;
  final Color? textColor;

  const H6(this.text, {super.key, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Outfit",
        fontSize: 30.w,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

//STYLE Divider
class Divisor extends StatelessWidget {
  final double? width;
  final double? height;
  final double? thickness;

  const Divisor({super.key, this.width, this.height, this.thickness});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null
          ? MediaQuery.sizeOf(context).width * (width! / 100)
          : MediaQuery.sizeOf(context).width,
      child: Divider(
        color: colorPallete.outline,
        height: height ?? 0,
        thickness: thickness ?? 1,
      ),
    );
  }
}

//STYLE Custom Icon Elevated Button
class IconElevatedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final dynamic onPressed;
  final Color? backgroundColor;
  final Color? textAndIconColor;

  const IconElevatedButton(
    this.text,
    this.icon,
    this.onPressed, {
    super.key,
    this.backgroundColor,
    this.textAndIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      label: Text(
        text,
        style: TextStyle(
          fontFamily: "Outfit",
          color: textAndIconColor ?? colorPallete.onSecondary,
        ),
      ),
      icon: Icon(icon, color: textAndIconColor ?? colorPallete.onSecondary),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? colorPallete.secondary,
      ),
    );
  }
}
