import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class RecordModel extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  double quantity;

  @HiveField(2)
  double calories;

  RecordModel(this.name, this.quantity, this.calories);
}
