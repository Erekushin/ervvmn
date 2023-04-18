class ContentCreationTypes {
  String? typeName;
  int? typeId;
  String? keyWord;

  ContentCreationTypes({this.typeName, this.typeId, this.keyWord});

  ContentCreationTypes.fromJson(Map<String, dynamic> json) {
    typeName = json['type_name'];
    typeId = json['type_id'];
    keyWord = json['key_word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_name'] = typeName;
    data['type_id'] = typeId;
    data['key_word'] = keyWord;
    return data;
  }
}

class SurveyCreationTypes {
  int? code;
  String? status;
  String? message;
  Result? result;

  SurveyCreationTypes({this.code, this.status, this.message, this.result});

  SurveyCreationTypes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }
}

class Result {
  List<ContentCreationTypes>? privacyLevel;
  List<ContentCreationTypes>? questionType;
  List<ContentCreationTypes>? countType;
  List<ContentCreationTypes>? surveyType;
  List<ContentCreationTypes>? statistic;

  Result(
      {this.privacyLevel, this.questionType, this.surveyType, this.countType});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['privacy_level'] != null) {
      privacyLevel = <ContentCreationTypes>[];
      json['privacy_level'].forEach((v) {
        privacyLevel!.add(ContentCreationTypes.fromJson(v));
      });
    }
    if (json['statistic'] != null) {
      statistic = <ContentCreationTypes>[];
      json['statistic'].forEach((v) {
        statistic!.add(ContentCreationTypes.fromJson(v));
      });
    }
    if (json['question_type'] != null) {
      questionType = <ContentCreationTypes>[];
      json['question_type'].forEach((v) {
        questionType!.add(ContentCreationTypes.fromJson(v));
      });
    }
    if (json['count_type'] != null) {
      countType = <ContentCreationTypes>[];
      json['count_type'].forEach((v) {
        countType!.add(ContentCreationTypes.fromJson(v));
      });
    }
    if (json['survey_type'] != null) {
      surveyType = <ContentCreationTypes>[];
      json['survey_type'].forEach((v) {
        surveyType!.add(ContentCreationTypes.fromJson(v));
      });
    }
  }
}
