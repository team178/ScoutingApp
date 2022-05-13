enum InputType { boolean, multiselect, text, number }

class SelectOption {
  final String value;
  final String label;

  SelectOption({required this.value, required this.label});
}

class Question {
  final String id;
  final String title;
  final InputType type;
  final List<dynamic>? options;

  Question({required this.id, required this.title, required this.type, this.options});
  Question.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        type = InputType.values[data['type']],
        options = data['options'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {'name': title, 'type': type.name};
    if (options != null) {
      data['options'] = options;
    }
    return data;
  }
}

class ScoutForm {
  final String id;
  final String name;
  final List<Question> questions;

  ScoutForm({required this.id, required this.name, this.questions = const []});

  ScoutForm.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        questions = json['questions']
            .map((question) => Question.fromJson(question))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'questions': questions.map(((e) => e.toJson())).toList()
    };
  }
}
