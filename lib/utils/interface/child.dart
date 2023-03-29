class Child {
  const Child(this.id, this.name, this.temperament);

  final String id;
  final String name;
  final String temperament;

  factory Child.fromJson(Map json) {
    String id = json["id"] is int ? json["id"].toString() : json["id"];
    String name = json["name"];
    String temperament = json["temperament"];
    return Child(id, name, temperament);
  }
}
