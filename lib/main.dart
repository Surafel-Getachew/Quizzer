import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import "quiz_brain.dart";

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = new QuizBrain();
  List<Icon> scoreKeeper = [];
  bool correct = false;
  bool started = false;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (quizBrain.checkQuestionNumber()) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        scoreKeeper = [];
        quizBrain.reset();
      } else {
        if (userPickedAnswer == correctAnswer) {
          setState(() {
            scoreKeeper.add(Icon(Icons.check, color: Colors.green));
            quizBrain.nextQuestion();
          });
        } else {
          setState(() {
            scoreKeeper.add(Icon(Icons.close, color: Colors.red));
            quizBrain.nextQuestion();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                style: TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              onPressed: () {
                started = true;
                checkAnswer(true);
              },
              child: Text(
                "True",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              onPressed: () {
                started = true;
                checkAnswer(false);
              },
              child: Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
