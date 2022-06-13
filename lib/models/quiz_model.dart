class QuizModel {
  int? id;
  String? question;
  bool? rightAnswer;

  QuizModel({
    this.id,
    this.question,
    this.rightAnswer,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    id: json['id'] == null ? null : json['id'] as int?,
    question: json['question'] == null ? null : json['question'] as String?,
    rightAnswer:
    json['rightAnswer'] == null ? null : json['rightAnswer'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'rightAnswer': rightAnswer,
  };

  @override
  String toString() {
    return 'QuizModel{id: $id, question: $question, rightAnswer: $rightAnswer}';
  }
}