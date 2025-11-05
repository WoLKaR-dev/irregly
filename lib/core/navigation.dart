import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irregly/code/data_code.dart';
import 'package:irregly/page/home_page.dart';
import 'package:irregly/page/learn_page.dart';
import 'package:irregly/page/lists_page.dart';
import 'package:irregly/style/general_style.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final GlobalKey<VerbListPageState> verbListKey =
      GlobalKey<VerbListPageState>();
  List<String> appbarNames = ["Home", "Lists", "Practise"];
  late List<Widget> screens;
  int selectedIndex = 0;

  void changePage(int page) => setState(() {
    selectedIndex = page;
  });

  @override
  void initState() {
    super.initState();
    screens = [HomePage(changeNavigationPage: changePage,), VerbListPage(key: verbListKey), LearnPage()];
  }

  void updateState() async {
    await saveData();
    verbListKey.currentState?.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appbarNames[selectedIndex])),
      body: Row(
        children: [
          //SECTION Raíl de navigacion
          NavigationRail(
            leading: FloatingActionButton(
              backgroundColor: colorPallete.surfaceContainerHigh,
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 50.w,
                  color: colorPallete.onSecondaryFixed,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerbEditorPage(onEnd: updateState),
                  ),
                );
              },
            ),
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            groupAlignment: 0,
            destinations: [
              NavigationRailDestination(
                icon: Icon(
                  selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                ),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list_rounded),
                label: Text("Lists"),
              ),
              NavigationRailDestination(
                icon: Icon(
                  selectedIndex == 2 ? Icons.school : Icons.school_outlined,
                ),
                label: Text("Practise"),
              ),
            ],
            selectedIndex: selectedIndex,
          ),

          //SECTION Pantallas
          Expanded(child: screens[selectedIndex]),
        ],
      ),
    );
  }
}
