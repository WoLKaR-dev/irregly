class Verb {
  //PART Attributes
  String _infinitive;
  String _past;
  String _pastParticiple;
  String _translation;
  int _appearances;
  int _correctAppearances;

  //PART Constructor
  Verb(
    this._infinitive,
    this._past,
    this._pastParticiple,
    this._translation, {
    int? newAppearances,
    int? newCorrectAppearances,
  }) : _appearances = newAppearances ?? 0,
       _correctAppearances = newCorrectAppearances ?? 0;

  //PART Métodos
  /*
  Actualiza los datos del verbo
  @param infinitivo
  @param pasado
  @param participio
  @param traducción
  */
  void updateVerbTenses({
    String? infinitive,
    String? past,
    String? pastParticiple,
    String? translation,
  }) {
    _infinitive = infinitive ?? _infinitive;
    _past = past ?? _past;
    _pastParticiple = pastParticiple ?? _pastParticiple;
    _translation = translation ?? _translation;
  }

  /*
  Actualiza la respuesta del verbo con su acierto o fallo
  @param resultado
  */
  void registerResponse(bool correct) {
    if (correct) {
      _correctAppearances++;
    }
    _appearances++;
  }

  /*
  Comprueba si una respuesta es correcta
  @param infinitivo
  @param pasado
  @param participio
  @param traducción
  */
  bool checkResponse(
    String infinitive,
    String past,
    String pastParticiple,
    String translation,
  ) {
    return infinitive.trim().toLowerCase() ==
            _infinitive.trim().toLowerCase() &&
        past.trim().toLowerCase() == _past.trim().toLowerCase() &&
        pastParticiple.trim().toLowerCase() ==
            _pastParticiple.trim().toLowerCase() &&
        translation.trim().toLowerCase() == _translation.trim().toLowerCase();
  }

  /*
  Comprueba y retorna el número de aciertos de un verbo
  @param infinitivo
  @param pasado
  @param participio
  @param traduccion
  @return Numero de aciertos
  */
  int getCorrectTenses(
    String infinitive,
    String past,
    String pastParticiple,
    String translation,
  ) {
    int correctTenses = 0;
    if (infinitive.trim().toLowerCase() == _infinitive.trim().toLowerCase()) {
      correctTenses++;
    }
    if (past.trim().toLowerCase() == _past.trim().toLowerCase()) {
      correctTenses++;
    }
    if (pastParticiple.trim().toLowerCase() ==
        _pastParticiple.trim().toLowerCase()) {
      correctTenses++;
    }
    if (translation.trim().toLowerCase() == _translation.trim().toLowerCase()) {
      correctTenses++;
    }
    return correctTenses;
  }

  //PART Getters
  String get infinitive => _infinitive;

  String get past => _past;

  String get pastParticiple => _pastParticiple;

  String get translation => _translation;

  int get appearances => _appearances;

  int get correctAppearances => _correctAppearances;

  double get rate {
    if (_appearances > 0) {
      return (_correctAppearances / _appearances) * 100;
    } else {
      return 0;
    }
  }

  Map<String, dynamic> get json => {
    "infinitive": _infinitive,
    "past": _past,
    "pastParticiple": _pastParticiple,
    "translation": _translation,
    "appearances": _appearances,
    "correctAppearances": _correctAppearances,
  };
}

class Result {
  //PART Attributes
  final int _totalTenses;
  final int _correctTenses;
  final int _totalVerbs;
  final int _correctVerbs;
  final List<Verb> _wrongVerbs;

  //PART Constructor
  Result(
    this._totalTenses,
    this._correctTenses,
    this._totalVerbs,
    this._correctVerbs,
    this._wrongVerbs,
  );

  //PART Getters
  int get totalTenses => _totalTenses;

  int get correctTenses => _correctTenses;

  int get totalVerbs => _totalVerbs;

  int get correctVerbs => _correctVerbs;

  List<Verb> get wrongVerbs => _wrongVerbs;

  double get correctPercentaje => (_correctTenses / _totalTenses) * 100;

  double get mark => (_correctVerbs / _totalVerbs) * 10;
}
