import 'package:cloud_firestore/cloud_firestore.dart';

import 'vaccination.dart';

class Pet {
  // 1
  String name;
  String? notes;
  String type;
  // 2
  List<Vaccination> vaccinations;
  // 3
  String? referenceId;
  // 4
  Pet(this.name,
      {this.notes,
      required this.type,
      this.referenceId,
      required this.vaccinations});
  // 5
  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Pet.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }
  // 6
  factory Pet.fromJson(Map<String, dynamic> json) => _petFromJson(json);
  // 7
  Map<String, dynamic> toJson() => _petToJson(this);

  @override
  String toString() => 'Pet<$name>';
}

//Add a function to convert a map of key/value pairs into a pet.
Pet _petFromJson(Map<String, dynamic> json) {
  return Pet(json['name'] as String,
      notes: json['notes'] as String?,
      type: json['type'] as String,
      vaccinations:
          _convertVaccinations(json['vaccinations'] as List<dynamic>));
}

// Add another function to convert a list of maps into a list of vaccinations.
List<Vaccination> _convertVaccinations(List<dynamic> vaccinationMap) {
  final vaccinations = <Vaccination>[];

  for (final vaccination in vaccinationMap) {
    vaccinations.add(Vaccination.fromJson(vaccination as Map<String, dynamic>));
  }
  return vaccinations;
}

// Convert a pet into a map of key/value pairs.
Map<String, dynamic> _petToJson(Pet instance) => <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
      'type': instance.type,
      'vaccinations': _vaccinationList(instance.vaccinations),
    };
// 4
List<Map<String, dynamic>>? _vaccinationList(List<Vaccination>? vaccinations) {
  if (vaccinations == null) {
    return null;
  }
  final vaccinationMap = <Map<String, dynamic>>[];
  vaccinations.forEach((vaccination) {
    vaccinationMap.add(vaccination.toJson());
  });
  return vaccinationMap;
}
