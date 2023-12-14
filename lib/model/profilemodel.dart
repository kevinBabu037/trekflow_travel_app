
import 'package:hive/hive.dart';
part 'profilemodel.g.dart';

@HiveType(typeId: 4)
class ProfileModel{
  @HiveField(0)
  String? image;

    @HiveField(1)
  String? key;
  @HiveField(1)
  String? justText;

  ProfileModel({ this.image, this.key,this.justText});
}