class QuestionModel {
  QuestionModel({
    required this.id,
    required this.question,
    required this.correctAnswer,
  });

  late int id;
  late String question;
  late bool correctAnswer;

  QuestionModel.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    correctAnswer =  int.parse(json['correct_answer'])== 0 ? false : true ;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    map['correct_answer'] = correctAnswer;
    return map;
  }
}
