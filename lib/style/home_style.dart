import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irregly/style/general_style.dart';
import 'package:url_launcher/url_launcher.dart';

//STYLE Carta de Inicio
class UpdateCard extends StatelessWidget {
  const UpdateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 800.w,
      decoration: BoxDecoration(
        color: colorPallete.tertiaryContainer,
        border: Border.all(color: colorPallete.outline),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        spacing: 15,
        children: [
          H5("Update Irregly"),
          H6(
            "Your local version of Irregly is not the latest. Update Irregly to run the latest version.",
          ),
          IconElevatedButton(
            "Update",
            Icons.download,
            () async {
              try {
                Uri url = Uri.parse("https://irregly-web.web.app");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              } catch (e) {
                return;
              }
            },
            backgroundColor: colorPallete.tertiary,
            textAndIconColor: colorPallete.onTertiary,
          ),
        ],
      ),
    );
  }
}

//STYLE Carta inicio grande
class HomeBigCard extends StatelessWidget {
  final String title;
  final String description;
  final String? image;
  final dynamic onTap;

  const HomeBigCard({
    super.key,
    required this.title,
    required this.description,
    this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: colorPallete.surfaceContainer,
          border: Border.all(color: colorPallete.outline),
          borderRadius: BorderRadius.circular(30),
        ),
        width: 800.w,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              //SECTION Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(image ?? "assets/icons/irregly_icon.png"),
              ),

              //SECTION Título
              H3(title),

              //SECTION Descripcion
              H5(description),
            ],
          ),
        ),
      ),
    );
  }
}

//STYLE Carta inicio pequeña
class HomeSmallCard extends StatelessWidget {
  final String description;
  final String? image;
  final dynamic onTap;

  const HomeSmallCard({
    super.key,
    required this.description,
    this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 800.w,
        decoration: BoxDecoration(
          color: colorPallete.surfaceContainer,
          border: Border.all(color: colorPallete.outline),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            spacing: 10,
            children: [
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(image ?? "assets/icons/irregly_icon.png"),
                ),
              ),
              Flexible(flex: 2, child: H5(description)),
            ],
          ),
        ),
      ),
    );
  }
}
