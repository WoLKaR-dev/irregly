import 'package:flutter/material.dart';
import 'package:irregly/code/data_code.dart';
import 'package:irregly/code/lists_code.dart';
import 'package:irregly/data/data.dart';
import 'package:irregly/style/general_style.dart';
import 'package:irregly/style/lists_style.dart';
import 'package:irregly/template/verb_template.dart';

//SCREEN Verb List
class VerbListPage extends StatefulWidget {
  const VerbListPage({super.key});

  @override
  State<VerbListPage> createState() => VerbListPageState();
}

class VerbListPageState extends State<VerbListPage> {
  void refreshVerbs() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scroll(
        spacing: 15,
        padding: EdgeInsets.all(15),
        children: [
          //SECTION Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15,
            children: [
              H1("My Verbs"),
              IconElevatedButton("See all", Icons.arrow_forward, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AllVerbsPage(updateTablePage: refreshVerbs),
                  ),
                );
              }),
            ],
          ),
          Divisor(width: 80),
          Table(
            border: TableBorder.all(color: colorPallete.outline),
            children: [
              TableRow(
                decoration: BoxDecoration(color: colorPallete.secondaryFixed),
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: H5("Infinitive"),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: H5("Past"),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: H5("Past Participle"),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: H5("Translation"),
                  ),
                ],
              ),
              ...List.generate(userVerbs.length, (index) {
                Verb currentVerb = userVerbs[index];
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: H5(currentVerb.infinitive),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: H5(currentVerb.past),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: H5(currentVerb.pastParticiple),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: H5(currentVerb.translation),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

//SCREEN Verb Editor
class VerbEditorPage extends StatefulWidget {
  final Verb? verb;
  final dynamic onEnd;

  const VerbEditorPage({super.key, this.verb, this.onEnd});

  @override
  State<VerbEditorPage> createState() => _VerbEditorPageState();
}

class _VerbEditorPageState extends State<VerbEditorPage> {
  final TextEditingController _infinitive = TextEditingController();
  final TextEditingController _past = TextEditingController();
  final TextEditingController _pastParticiple = TextEditingController();
  final TextEditingController _translation = TextEditingController();

  @override
  void initState() {
    super.initState();
    _infinitive.text = widget.verb?.infinitive ?? "";
    _past.text = widget.verb?.past ?? "";
    _pastParticiple.text = widget.verb?.pastParticiple ?? "";
    _translation.text = widget.verb?.translation ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.verb != null) {
            widget.verb!.updateVerbTenses(
              infinitive: _infinitive.text,
              past: _past.text,
              pastParticiple: _pastParticiple.text,
              translation: _translation.text,
            );
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Verb updated successfully")),
            );
          } else {
            Verb newVerb = Verb(
              _infinitive.text,
              _past.text,
              _pastParticiple.text,
              _translation.text,
            );
            if (!isInfinitiveRegistered(checkedVerb: newVerb)) {
              registerVerb(newVerb);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Verb added successfully")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Another verb with same infinitive exists."),
                ),
              );
            }
          }
          if (widget.onEnd != null) {
            widget.onEnd();
          }
        },
        child: Icon(Icons.check),
      ),
      appBar: AppBar(title: Text("Verb Editor")),
      body: Background(
        child: Scroll(
          padding: EdgeInsets.only(top: 15),
          spacing: 15,
          children: [
            widget.verb != null
                ? H1("Editing ${widget.verb!.infinitive}")
                : H1("Creating Verb"),
            Divisor(width: 80),
            //SECTION Infinitive
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                H4("Infinitive: "),
                Input(controller: _infinitive, width: 30),
              ],
            ),

            //SECTION Past
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                H4("Past: "),
                Input(controller: _past, width: 30),
              ],
            ),

            //SECTION PastParticiple
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                H4("Past Participle: "),
                Input(controller: _pastParticiple, width: 30),
              ],
            ),

            //SECTION Translation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                H4("Translation: "),
                Input(controller: _translation, width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//SCREEN All Verbs
class AllVerbsPage extends StatefulWidget {
  final dynamic updateTablePage;

  const AllVerbsPage({super.key, required this.updateTablePage});

  @override
  State<AllVerbsPage> createState() => _AllVerbsPageState();
}

class _AllVerbsPageState extends State<AllVerbsPage> {
  void refreshPage() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Verbs")),
      body: Background(
        child: Scroll(
          padding: EdgeInsets.only(top: 15),
          spacing: 5,
          children: [
            ...List.generate(userVerbs.length, (index) {
              Verb verb = userVerbs[index];
              return VerbCard(
                verb: verb,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerbPage(
                        verb: verb,
                        updateTablePage: widget.updateTablePage,
                        updateListPage: refreshPage,
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

//SCREEN Verb Screen
class VerbPage extends StatelessWidget {
  final dynamic updateListPage;
  final dynamic updateTablePage;
  final Verb verb;

  const VerbPage({
    super.key,
    required this.verb,
    required this.updateTablePage,
    required this.updateListPage,
  });

  Widget generateCell(String text) {
    return Padding(padding: EdgeInsets.all(10), child: H5(text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(verb.infinitive)),
      body: Background(
        child: Scroll(
          padding: EdgeInsets.all(15),
          spacing: 15,
          children: [
            //SECTION Information
            H3("Information"),
            Table(
              border: TableBorder.all(color: colorPallete.outline),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: colorPallete.secondaryContainer,
                  ),
                  children: [
                    generateCell("Infinitive"),
                    generateCell("Past"),
                    generateCell("Past Participle"),
                    generateCell("Translation"),
                  ],
                ),

                TableRow(
                  decoration: BoxDecoration(
                    color: colorPallete.surfaceContainer,
                  ),
                  children: [
                    generateCell(verb.infinitive),
                    generateCell(verb.past),
                    generateCell(verb.pastParticiple),
                    generateCell(verb.translation),
                  ],
                ),
              ],
            ),

            //SECTION Extra information
            Divisor(width: 80),
            H3("Extra Information"),
            H5(
              "Appearances: ${verb.appearances}\n"
              "Correct Appearances: ${verb.correctAppearances}\n"
              "Rate: ${verb.rate}",
            ),

            //SECTION Eliminar Verbo
            Divisor(width: 80),
            H3("Danger Zone"),
            IconElevatedButton(
              "Delete Verb",
              Icons.delete_forever,
              () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Delete ${verb.infinitive}"),
                    content: Text(
                      "You are about to delete ${verb.infinitive}. This action is irreversible",
                    ),
                    actions: [
                      IconElevatedButton("Cancel", Icons.close, () {
                        Navigator.pop(context);
                      }),
                      IconElevatedButton(
                        "Delete",
                        Icons.delete_forever,
                        () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          removeVerb(verb);
                          updateTablePage();
                          updateListPage();
                          saveData();
                        },
                        backgroundColor: colorPallete.error,
                        textAndIconColor: colorPallete.onError,
                      ),
                    ],
                  ),
                );
              },
              backgroundColor: colorPallete.error,
              textAndIconColor: colorPallete.onError,
            ),
          ],
        ),
      ),
    );
  }
}
