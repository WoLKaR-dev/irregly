import 'dart:convert';
import 'dart:io';
import 'package:irregly/data/data.dart';
import 'package:path_provider/path_provider.dart';
import '../template/verb_template.dart';

/*
Guarda los datos de los verbos localmente
*/
Future<void> saveData() async {
  //Guardar datos de verbos
  await write("verbs.irr", jsonEncode(getUserVerbs()));
}

/*
Cargar los datos del usuario
*/
Future<void> loadData() async {
  //Cargar datos de los verbos
  loadUserVerbs(await readFile("verbs.irr"));
}

/*
Escribe el archivo con el nombre dado y los datos dados
@param nombre del archivo
@param datos del archivo
*/
Future<void> write(String fileName, String data) async {
  Directory directory = await getApplicationDocumentsDirectory();
  File newFile = File("${directory.path}/$fileName");
  if (!(await newFile.exists())) {
    newFile.create(recursive: true);
  }

  await newFile.writeAsString(data, flush: true);
  return;
}

/*
Lee el archivo con el nombre dado y retorna los datos
@param nombre del arhivo
@return datos del archivo
*/
Future<String> readFile(String fileName) async {
  Directory directory = await getApplicationDocumentsDirectory();
  File readFile = File("${directory.path}/$fileName");
  if (await readFile.exists()) {
    return await readFile.readAsString();
  } else {
    return "";
  }
}

/*
Obtiene los datos del usuario
@return datos
*/
List<Map<String, dynamic>> getUserVerbs() {
  List<Map<String, dynamic>> data = [];
  for (Verb verb in userVerbs) {
    data.add(verb.json);
  }
  return data;
}

/*
Carga los datos del usuario
*/
void loadUserVerbs(String data) {
  if (data != "") {
    var loadedData = jsonDecode(data);
    for (var verbEntrance in loadedData) {
      Verb newVerb = Verb(
        verbEntrance["infinitive"],
        verbEntrance["past"],
        verbEntrance["pastParticiple"],
        verbEntrance["translation"],
        newAppearances: verbEntrance["appearances"],
        newCorrectAppearances: verbEntrance["correctAppearances"],
      );
      userVerbs.add(newVerb);
    }
  }
}
