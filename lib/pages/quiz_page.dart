import 'package:flutter/material.dart';

import '../utils/question.dart';
import '../utils/quiz.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/result_overlay.dart';
import './score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question _currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Elon Musk is human", false),
    new Question("You are handsome", true)
  ]);
  String questionText;
  int questionNumber;
  bool _isCorrect;
  bool _overlayShouldBeVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentQuestion = quiz.nextQuestion;
    questionText = _currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    _isCorrect = (_currentQuestion.answer == answer);
    quiz.answer(_isCorrect);
    this.setState(() {
      _overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(fit: StackFit.expand, children: <Widget>[
      new Column(
        children: <Widget>[
          new AnswerButton(true, () => handleAnswer(true)),
          new QuestionText(questionText, questionNumber),
          new AnswerButton(false, () => handleAnswer(false)),
        ], // This is main page
      ),
      _overlayShouldBeVisible
          ? new ResultOverlay(_isCorrect, () {
              if (quiz.length == questionNumber) {
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new ScorePage(quiz.score, quiz.length)),
                    (Route route) => route == null);
              }
              _currentQuestion = quiz.nextQuestion;
              this.setState(() {
                _overlayShouldBeVisible = false;
                questionText = _currentQuestion.question;
                questionNumber = quiz.questionNumber;
              });
            })
          : new Container()
    ]);
  }
}
