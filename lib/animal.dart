class Animal {
  final String name;
  final String image;
  final String sound;

  Animal({this.name, this.image, this.sound});

  factory Animal.fromJson(Map<String, dynamic> json) =>
      Animal(name: json['name'], image: json['image'], sound: json['sound']);
}
