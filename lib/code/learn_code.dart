import 'dart:convert';
import 'dart:math';
import 'package:irregly/code/data_code.dart';

import '../data/data.dart';
import '../template/verb_template.dart';
import 'package:http/http.dart' as http;
import 'lists_code.dart';

/*
Retorna una lista de verbos aleatorio de la cantidad pedida
@param Cantidad de verbos
@return Lista de verbos
*/
List<Verb> getExamVerbs(int amount) {
  List<Verb> verbs = [];
  final random = Random();

  if (userVerbs.length >= amount) {
    while (verbs.length < amount) {
      int randomNumber = random.nextInt(userVerbs.length);
      Verb selectedVerb = userVerbs[randomNumber];
      if (!verbs.contains(selectedVerb)) {
        verbs.add(selectedVerb);
      }
    }
  }

  return verbs;
}

/*
Retorna la matriz de respuestas de una lista de verbos
@param lista de verbos
@param dificultad
@return Matriz de respuestas
*/
List<List<dynamic>> generateResponseMatrix(List<Verb> verbs) {
  List<List<dynamic>> responseMatrix = [];
  final random = Random();
  for (Verb verb in verbs) {
    int randomNumber = random.nextInt(4);
    List<dynamic> response = [];
    for (int i = 0; i < 4; i++) {
      if (i == randomNumber) {
        switch (randomNumber) {
          case 0:
            response.add(verb.infinitive);
            break;
          case 1:
            response.add(verb.past);
            break;
          case 2:
            response.add(verb.pastParticiple);
            break;
          case 3:
            response.add(verb.translation);
            break;
          default:
            break;
        }
      }
      response.add("");
    }
    responseMatrix.add(response);
  }
  return responseMatrix;
}

/*
Procesa los resultados obtenidos y da un resultado detallado
@param Lista de verbos
@param Matriz de respuestas
@return Resultados
*/
Result generateResults(List<Verb> verbs, List<List<dynamic>> responses) {
  int attempedVerbs = verbs.length;
  int attempedTenses = verbs.length * 4;
  int correctVerbs = 0;
  int correctTenses = 0;
  List<Verb> failedVerbs = [];

  for (int i = 0; i < verbs.length; i++) {
    var responseRow = responses[i];
    Verb verb = verbs[i];
    String infinitive = responseRow[0];
    String past = responseRow[1];
    String pastParticiple = responseRow[2];
    String translation = responseRow[3];
    bool correct = verb.checkResponse(
      infinitive,
      past,
      pastParticiple,
      translation,
    );
    verb.registerResponse(correct);
    correct == true ? correctVerbs++ : failedVerbs.add(verb);
    int totalCorrectTenses = verb.getCorrectTenses(
      infinitive,
      past,
      pastParticiple,
      translation,
    );
    correctTenses += totalCorrectTenses;
  }
  saveData();
  return Result(
    attempedTenses,
    correctTenses,
    attempedVerbs,
    correctVerbs,
    failedVerbs,
  );
}

/*
Genera una lista de verbos con los menores rate de todos
@param cantidad verbos
@return Lista de verbos
*/
List<Verb> getWeakestExamVerbs(int amount) {
  List<Verb> verbs = [];
  userVerbs.sort((a, b) => a.rate.compareTo(b.rate));
  for (int i = 0; i < amount; i++) {
    verbs.add(userVerbs[i]);
  }
  return verbs;
}

/*
Obtiene el listado de verbos para descargar
@return listado de verbos
*/
Future<List<dynamic>?> getOnlineVerbs() async {
  try {
    Uri link = Uri.parse(
      "https://irregly-web.web.app/backend/verbs.json",
    );
    var response = await http.get(link);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

/*
Clona el listado de verbos en modo json
@param Listado de verbos en json
*/
void cloneVerbs(dynamic list) {
  for (var entrance in list) {
    Verb newVerb = Verb(
      entrance["infinitive"],
      entrance["past"],
      entrance["pastParticiple"],
      entrance["translation"],
    );
    if (!isInfinitiveRegistered(checkedVerb: newVerb)) {
      registerVerb(newVerb);
    }
  }
  saveData();
}
