class Question {
  String name, question, email;
  Question({
    this.name,
    this.email,
    this.question,
  });

  save() {
    print("Name:$name\nEmail:$email\nQuestion:$question");
  }
}
