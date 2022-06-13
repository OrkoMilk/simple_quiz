class OneAnswerQuizModel {
  int? id;
  String? question;
  List<dynamic>? answers;
  String? rightAnswer;

  OneAnswerQuizModel({
    this.id,
    this.question,
    this.answers,
    this.rightAnswer,
  });

  factory OneAnswerQuizModel.fromJson(Map<String, dynamic> json) => OneAnswerQuizModel(
        id: json['id'] == null ? null : json['id'] as int?,
        question: json['question'] == null ? null : json['question'] as String?,
        answers: json['answers'] == null ? null : json['answers'] as List<dynamic>?,
        rightAnswer:json['rightAnswer'] == null ? null : json['rightAnswer'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'answers': answers,
    'rightAnswer': rightAnswer,
  };

  @override
  String toString() {
    return 'OneAnswerQuizModel{id: $id, question: $question, answers: $answers, rightAnswer: $rightAnswer}';
  }
}
