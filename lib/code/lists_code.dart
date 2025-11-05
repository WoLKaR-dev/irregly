import 'package:irregly/data/data.dart';
import 'package:irregly/template/verb_template.dart';

/*
Comprueba si ya existe un verbo con el mismo infinitivo
@param verbo 
@param infinitivo 
*/
bool isInfinitiveRegistered({Verb? checkedVerb, String? checkedInfinitive}) {
  String? currentInfinitive = checkedVerb?.infinitive ?? checkedInfinitive;
  if (currentInfinitive != null) {
    for (Verb verb in userVerbs) {
      if (verb.infinitive.toLowerCase() == currentInfinitive.toLowerCase()) {
        return true;
      }
    }
  }
  return false;
}

/*
Registra un verbo en la lista de verbos del usuario
@param verbo a registrar
*/
void registerVerb(Verb verbToRegister) {
  userVerbs.add(verbToRegister);
}

/*
Remueve un verbo de la lista de verbos
@param verbo
*/
void removeVerb(Verb oldVerb) {
  userVerbs.removeWhere((verb) => verb == oldVerb);
}

