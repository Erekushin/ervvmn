class MyServiceB {
  List<MyService>? services;

  MyServiceB({this.services});

  MyServiceB.fromJson(List<dynamic> json) {
    services = <MyService>[];
    for (var u in json) {
      services!.add(MyService.fromJson(u));
    }
  }
}

class MyService {
  String? name;
  String? image;
  String? discription;
  String? type;
  String? payment;

  MyService({this.name, this.image, this.discription, this.type, this.payment});

  MyService.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    discription = json['discription'];
    type = json['type'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['discription'] = discription;
    data['type'] = type;
    data['payment'] = payment;
    return data;
  }
}
