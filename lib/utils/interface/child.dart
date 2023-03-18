class Child {
  const Child(this.name, this.temperament);

  final String name;
  final String temperament;

  factory Child.fromJson(Map json) {
    String name = json["name"];
    String temperament = json["temperament"];
    return Child(name, temperament);
  }
}
