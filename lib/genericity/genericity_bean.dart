import 'dart:convert';
/// name : ""
/// age : 18
/// sex : 0

GenericityBean genericityBeanFromJson(String str) => GenericityBean.fromJson(json.decode(str));
String genericityBeanToJson(GenericityBean data) => json.encode(data.toJson());
class GenericityBean {
  GenericityBean({
      String name, 
      int age, 
      int sex,}){
    _name = name;
    _age = age;
    _sex = sex;
}

  GenericityBean.fromJson(dynamic json) {
    _name = json['name'];
    _age = json['age'];
    _sex = json['sex'];
  }
  String _name;
  int _age;
  int _sex;
GenericityBean copyWith({  String name,
  int age,
  int sex,
}) => GenericityBean(  name: name ?? _name,
  age: age ?? _age,
  sex: sex ?? _sex,
);
  String get name => _name;
  int get age => _age;
  int get sex => _sex;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['age'] = _age;
    map['sex'] = _sex;
    return map;
  }

}