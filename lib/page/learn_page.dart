import 'package:flutter/material.dart';
import 'package:irregly/code/learn_code.dart';
import 'package:irregly/data/data.dart';
import 'package:irregly/style/general_style.dart';
import 'package:irregly/style/learn_styles.dart';
import '../data/learn_data.dart';
import '../template/verb_template.dart';

//SCREEN Página de Aprendizaje
class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scroll(
        padding: EdgeInsets.only(top: 15),
        spacing: 15,
        children: [
          //SECTION Descargar
          H2("Download Verbs"),
          H5(
            "Download a pack of verbs based on your English Level. Cloned packs will instantly add to your verbs collection.",
          ),
          IconElevatedButton("Download", Icons.download, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DownloadPage()),
            );
          }),

          //SECTION Practicar
          Divisor(width: 80),
          H2("Practise"),

          //SECTION Simple Practise
          Divisor(width: 30),
          H3("Single Practise"),
          H5("Start a single verb practise."),
          IconElevatedButton("Start", Icons.school, () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Start Practise"),
                content: Scroll(
                  children: [
                    Text(
                      "You are about to start a new practise for your Irregular Verbs exam.",
                    ),
                  ],
                ),
                actions: [
                  IconElevatedButton("Start", Icons.check, () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamPracticeScreen(
                          verbAmount: 1,
                          mode: ExamMode.simple,
                        ),
                      ),
                    );
                  }),
                  IconElevatedButton(
                    "Cancel",
                    Icons.close,
                    () {
                      Navigator.pop(context);
                    },
                    backgroundColor: colorPallete.error,
                    textAndIconColor: colorPallete.onError,
                  ),
                ],
              ),
            );
          }),

          //SECTION Exam Practise
          Divisor(width: 30),
          H3("Exam Practise"),
          H5("Start an exam-format practise with different amount of verbs."),
          IconElevatedButton("Start", Icons.school, () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Start Practise"),
                content: Scroll(
                  children: [
                    Text(
                      "You are about to start a new practise for your Irregular Verbs exam.",
                    ),
                  ],
                ),
                actions: [
                  IconElevatedButton("Start", Icons.check, () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamPracticeScreen(
                          verbAmount: userVerbs.length >= 10
                              ? 10
                              : userVerbs.length,
                          mode: ExamMode.classicExam,
                        ),
                      ),
                    );
                  }),
                  IconElevatedButton(
                    "Cancel",
                    Icons.close,
                    () {
                      Navigator.pop(context);
                    },
                    backgroundColor: colorPallete.error,
                    textAndIconColor: colorPallete.onError,
                  ),
                ],
              ),
            );
          }),

          //SECTION Weak Practise
          Divisor(width: 30),
          H3("Weak Verbs Pracise"),
          H5(
            "Start an exam-format practise that focuses on your weakest verbs. ",
          ),
          IconElevatedButton("Start", Icons.crisis_alert, () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Weak Verbs Practise"),
                content: Text(
                  "You are about to start an exam-format practise focused on your weakest verbs. ",
                ),
                actions: [
                  IconElevatedButton("Start", Icons.check, () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamPracticeScreen(
                          verbAmount: userVerbs.length >= 10
                              ? 10
                              : userVerbs.length,
                          mode: ExamMode.weakFocusedExam,
                        ),
                      ),
                    );
                  }),
                  IconElevatedButton(
                    "Cancel",
                    Icons.close,
                    () {
                      Navigator.pop(context);
                    },
                    backgroundColor: colorPallete.error,
                    textAndIconColor: colorPallete.onError,
                  ),
                ],
              ),
            );
          }),
          SizedBox(),
        ],
      ),
    );
  }
}

//SCREEN Pantalla de Prácticas de Examen
class ExamPracticeScreen extends StatefulWidget {
  final ExamMode mode;
  final int verbAmount;

  const ExamPracticeScreen({
    super.key,
    required this.verbAmount,
    required this.mode,
  });

  @override
  State<ExamPracticeScreen> createState() => _ExamPracticeScreenState();
}

class _ExamPracticeScreenState extends State<ExamPracticeScreen> {
  final TextEditingController inputController = TextEditingController();
  int? selectedColumn;
  int? selectedRow;
  late List<Verb> verbs;
  late List<List<dynamic>> responses;

  @override
  void initState() {
    super.initState();
    switch (widget.mode) {
      case ExamMode.simple:
        verbs = getExamVerbs(1);
        break;
      case ExamMode.classicExam:
        verbs = getExamVerbs(widget.verbAmount);
        break;
      case ExamMode.weakFocusedExam:
        verbs = getWeakestExamVerbs(widget.verbAmount);
        break;
    }
    responses = generateResponseMatrix(verbs);
  }

  Widget buildCell(String value, int row, int column) {
    if (row == selectedRow && column == selectedColumn) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Input(
          controller: inputController,
          onTapOutside: (value) {
            responses[row][column] = inputController.text.trim();
            inputController.clear();
            setState(() {
              selectedColumn = null;
              selectedRow = null;
            });
          },
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRow = row;
          selectedColumn = column;
          inputController.text = responses[row][column];
        });
      },
      child: Padding(padding: EdgeInsets.all(10), child: H5(value)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exam Practise")),
      body: Background(
        child: Scroll(
          spacing: 15,
          padding: EdgeInsets.all(10),
          children: [
            //SECTION Tabla de Verbos
            Table(
              border: TableBorder.all(color: colorPallete.outline),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: colorPallete.secondaryContainer,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: H5("Infinitive"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: H5("Past"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: H5("Past Participle"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: H5("Translation"),
                    ),
                  ],
                ),
                ...List.generate(responses.length, (index) {
                  List<dynamic> responseArray = responses[index];
                  return TableRow(
                    decoration: BoxDecoration(
                      color: colorPallete.surfaceContainer,
                    ),
                    children: [
                      buildCell(responseArray[0], index, 0),
                      buildCell(responseArray[1], index, 1),
                      buildCell(responseArray[2], index, 2),
                      buildCell(responseArray[3], index, 3),
                    ],
                  );
                }),
              ],
            ),

            //SECTION Finalizar Examen
            Divisor(width: 50),
            H3("End Practise"),
            H5(
              "You can now end your practise. Results will be shown as soon as you press 'Finish'. ",
            ),
            IconElevatedButton("Finish", Icons.check, () {
              Result result = generateResults(verbs, responses);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LearnResultsScreen(result: result),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

//SCREEN Results Screen
class LearnResultsScreen extends StatelessWidget {
  final Result result;

  const LearnResultsScreen({super.key, required this.result});

  Widget generateCell(String value) =>
      Padding(padding: EdgeInsets.all(10), child: H5(value));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Background(
        child: Scroll(
          spacing: 15,
          padding: EdgeInsets.only(top: 15),
          children: [
            //SECTION Resultados Generales
            H4("Results"),
            H5(
              "You got right a total of ${result.correctVerbs} verbs out of ${result.totalVerbs}."
              " Plus, you also guessed a total of ${result.correctTenses} tenses out of ${result.totalTenses}.",
            ),

            //SECTION Resultados Numericos
            H4("Numeric Results"),
            H5(
              "${result.correctTenses}/${result.totalTenses} tenses"
              ", which means a correct percentaje of ${result.correctPercentaje}%",
            ),
            H5(
              "${result.correctVerbs}/${result.totalVerbs} verbs, which means you got a ${result.mark} out of 10. ",
            ),

            //SECTION Tablas de verbos errados
            if (result.wrongVerbs.isNotEmpty) ...[
              H4("Failed Verbs"),
              H5(
                "You failed some verbs. Here is a table with the failed verbs. ",
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Table(
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
                    ...List.generate(result.wrongVerbs.length, (index) {
                      Verb verb = result.wrongVerbs[index];
                      return TableRow(
                        decoration: BoxDecoration(
                          color: colorPallete.surfaceContainer,
                        ),
                        children: [
                          generateCell(verb.infinitive),
                          generateCell(verb.past),
                          generateCell(verb.pastParticiple),
                          generateCell(verb.translation),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

//SCREEN Download Screen
class DownloadPage extends StatefulWidget {
  @override
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  List<dynamic>? webVerbs;

  @override
  void initState() {
    super.initState();
    _loadVerbs();
  }

  void _loadVerbs() async {
    webVerbs = await getOnlineVerbs();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Downloads")),
      body: webVerbs == null
          ? Background(
              child: Column(
                spacing: 15,
                children: [H3("Loading Verbs"), CircularProgressIndicator()],
              ),
            )
          : Background(
              child: Scroll(
                padding: EdgeInsets.only(top: 15),
                spacing: 5,
                children: [
                  H3("Available Downloads"),
                  ...List.generate(webVerbs!.length, (index) {
                    var downloadEntrance = webVerbs![index];
                    return VerbDownloadCard(
                      text: downloadEntrance["title"],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DownloadVerbsPreview(data: downloadEntrance),
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

//SCREEN Pantalla de todos los verbos de una descarga
class DownloadVerbsPreview extends StatelessWidget {
  final dynamic data;

  const DownloadVerbsPreview({super.key, required this.data});

  Widget generateCell(String text) =>
      Padding(padding: EdgeInsets.all(10), child: H5(text));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data["title"])),
      body: Background(
        child: Scroll(
          padding: EdgeInsets.all(15),
          spacing: 15,
          children: [
            //SECTION Header
            H3("Verb List"),

            //SECTION Previsualizacion
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

                ...List.generate(data["verbs"].length, (index) {
                  var verb = data["verbs"][index];
                  return TableRow(
                    decoration: BoxDecoration(
                      color: colorPallete.surfaceContainer,
                    ),
                    children: [
                      generateCell(verb["infinitive"]),
                      generateCell(verb["past"]),
                      generateCell(verb["pastParticiple"]),
                      generateCell(verb["translation"]),
                    ],
                  );
                }),
              ],
            ),

            //SECTION Clonar
            H3("Clone Verbs"),
            H5(
              "You can now clone verbs. Only non-repeated cloned verbs will add to your verb collection.",
            ),
            IconElevatedButton("Clone", Icons.copy, () {
              cloneVerbs(data["verbs"]);
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Verbs Cloned")));
            }),
          ],
        ),
      ),
    );
  }
}
