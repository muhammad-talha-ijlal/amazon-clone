class Address {
  int? id;
  String flat;
  String area;
  String city;
  String zipCode;

  Address({
    this.id,
    required this.flat,
    required this.area,
    required this.city,
    required this.zipCode,
  });

  String toString() {
    return '${flat},${area},${city} - ${zipCode}';
  }

  Map<String, dynamic> toMap() {
    return {
      'flat': flat,
      'area': area,
      'city': city,
      'zipCode': zipCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      flat: map['flat'],
      area: map['area'],
      city: map['city'],
      zipCode: map['zipCode'],
    );
  }
}
