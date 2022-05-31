enum InputType { boolean, multiselect, text, number }

class SelectOption {
  final String value;
  final String label;

  SelectOption({required this.value, required this.label});

  SelectOption.fromJson(Map<String, dynamic> data)
      : value = data['value'],
        label = data['label'];

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
    };
  }
}

class Question {
  final String id;
  final String title;
  final InputType type;
  final List<SelectOption>? options;

  Question(
      {required this.id,
      required this.title,
      required this.type,
      this.options});
  Question.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        type = InputType.values.byName(data['type']),
        options = data['options'] == null
            ? null
            : List<SelectOption>.from(
                data['options'].map((option) => SelectOption.fromJson(option)));

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {'id': id, 'title': title, 'type': type.name};
    if (options != null) {
      data['options'] = options?.map(((e) => e.toJson())).toList();
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
        questions = List<Question>.from(
            json['questions'].map((question) => Question.fromJson(question)));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'questions': questions.map(((e) => e.toJson())).toList()
    };
  }
}
