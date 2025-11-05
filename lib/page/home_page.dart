import 'package:flutter/material.dart';
import 'package:irregly/data/data.dart';
import 'package:irregly/page/lists_page.dart';
import 'package:irregly/style/general_style.dart';
import 'package:irregly/style/home_style.dart';

class HomePage extends StatelessWidget {
  final dynamic changeNavigationPage;

  const HomePage({super.key, required this.changeNavigationPage});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scroll(
        padding: EdgeInsets.only(top: 15),
        spacing: 15,
        children: [
          if (!isUpdated) UpdateCard(),
          HomeBigCard(
            title: "Let's add a Verb!",
            description: "Click here to add a new verb to your collection",
            image: "assets/images/pencil.webp",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VerbEditorPage()),
              );
            },
          ),

          HomeSmallCard(
            description: "Check out your collection of added verbs.",
            image: "assets/images/table.webp",
            onTap: () {
              changeNavigationPage(1);
            },
          ),
        ],
      ),
    );
  }
}
