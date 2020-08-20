import 'package:flutter/material.dart';

class AskQuestionPage extends StatefulWidget {
  @override
  _AskQuestionPageState createState() => _AskQuestionPageState();
}

class _AskQuestionPageState extends State<AskQuestionPage> {
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
                            maxLengthEnforced: true,
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
              SizedBox(height: MediaQuery.of(context).size.height / 6),
              Builder(
                builder: (context) => RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 3),
                            content: Text('Вопрос успешно отправлен')));
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
