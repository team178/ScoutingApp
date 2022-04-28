import 'dart:mirrors';

abstract class MapSerializeable {
  Map<String, dynamic> toJson() {
    InstanceMirror im = reflect(this);
    ClassMirror cm = im.type;

    Map<String, dynamic> data = {};

    cm.declarations.values.whereType<VariableMirror>().forEach((vm) {
      final name = MirrorSystem.getName(vm.simpleName);
      final value = im.getField(vm.simpleName).reflectee;

      data[name] = value;
    });

    return data;
  }

  static T fromJson<T extends Object>(Map<String, dynamic> data) {
    ClassMirror cm = reflectClass(T);

    Map<Symbol, dynamic> args = {};

    data.entries.forEach((arg) {
      args[Symbol(arg.key)] = arg.value;
    });

    return cm.newInstance(Symbol(''), [], args).reflectee;
  }
}
