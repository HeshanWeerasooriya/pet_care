import 'package:cloud_firestore/cloud_firestore.dart';
import 'vaccination.dart';

class Pet {
  String name;
  String? notes;
  String type;

  List<Vaccination> vaccinations;

  String? referenceId;

  Pet(this.name,
      {this.notes,
      required this.type,
      this.referenceId,
      required this.vaccinations});

  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Pet.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory Pet.fromJson(Map<String, dynamic> json) => _petFromJson(json);

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

//Convert a list of vaccinations into a list of mapped values.
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
