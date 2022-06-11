class Question {
  const Question(this.question, this.answers);
  final String question;
  final List<Answer> answers;
}

class Answer {
  const Answer({
    required this.title,
    this.isRight = false,
  });
  final String title;
  final bool isRight;
}
