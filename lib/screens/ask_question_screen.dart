import 'package:flutter/material.dart';
import 'package:islamdag/models/question.dart';
import 'package:islamdag/resources/api_provider.dart';

class AskQuestionScreen extends StatefulWidget {
  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final _question = Question();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Фетвы"),
          automaticallyImplyLeading: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height / 23),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                  Text("Задать вопрос:",
                      style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.dark,
                            decoration: InputDecoration(
                              hintText: "Имя*",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            onChanged: (text) => _question.name = text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Имя не может быть пустым';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 50),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            keyboardAppearance: Brightness.dark,
                            decoration: InputDecoration(
                              hintText: "Электронная почта*",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            onChanged: (text) => _question.email = text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Неверный e-mail';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 50),
                        Container(
                          child: TextFormField(
                            maxLines: 8,
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.dark,
                            decoration: InputDecoration(
                              hintText: "Вопрос*",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            onChanged: (text) => _question.question = text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Напишите вопрос';
                              }
                              if (value.length < 10) {
                                return 'Вопрос не должен быть меньше 10 символов';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Builder(
                builder: (context) => RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _question.save();
                        sendQuestion(_question.name, _question.question,
                                _question.email)
                            .then((isSend) {
                          isSend
                              ? Scaffold.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text('Вопрос успешно отправлен')))
                              : Scaffold.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text('Ошибка отправки формы')));
                        }).whenComplete(() => Future.delayed(
                                Duration(seconds: 3),
                                () => Navigator.pop(context)));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Отправить",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    )),
              )
            ]),
          ),
        ));
  }
}
