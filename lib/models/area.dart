import 'package:hive/hive.dart';
part 'area.g.dart';

@HiveType(typeId: 0)
class Area extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool selected;

  @HiveField(3)
  String districtCode;

  @HiveField(4)
  String type;

  Area({
    this.id,
    this.name,
    this.type,
    this.districtCode,
    this.selected,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json['id'],
        name: json['ru_name'],
        districtCode: json['district_code'],
        type: json['type_name'],
        selected: false,
      );

  String get fullName => type == 'г.' ? "$name" : "$name район";
}
