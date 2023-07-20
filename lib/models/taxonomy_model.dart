class TaxonomyModel {
  String? name;
  int? id;
  TaxonomyModel({this.id, this.name});

  static TaxonomyModel fromMap(Map<String, dynamic>? map) {
    return TaxonomyModel(
      id: map!['id'],
      name: map['name'],
    );
  }
}
