class Survey {
  List<Question>? questions;

  Survey({this.questions});

  Survey.fromJson(List<dynamic> json) {
    questions = <Question>[];
    for (var v in json) {
      questions!.add(Question.fromJson(v));
    }
  }
}

class Question {
  String? id;
  String? quistion;
  List<Options>? options;
  String? type;

  Question({this.id, this.quistion, this.options, this.type});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quistion = json['quistion'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    type = json['type'];
  }
}

class Options {
  String? id;
  String? optionName;

  Options({this.id, this.optionName});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionName = json['option_name'];
  }
}
