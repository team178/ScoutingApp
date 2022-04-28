import 'package:scoutingapp/common/utils.dart';

enum InputType { boolean, multiselect, text, number }

class SelectOption with MapSerializeable {
  final String value;
  final String label;

  SelectOption({required this.value, required this.label});
}

class Question {
  final String title;
  final InputType type;
  final List<dynamic>? options;

  Question({required this.title, required this.type, this.options});
  Question.fromJson({required this.title, required type, this.options})
      : type = InputType.values.byName(type);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {'name': title, 'type': type.name};
    if (options != null) {
      data['options'] = options;
    }
    return data;
  }
}

class ScoutForm with MapSerializeable {
  final String name;
  final List<Question> questions = [];

  ScoutForm({required this.name});
}
