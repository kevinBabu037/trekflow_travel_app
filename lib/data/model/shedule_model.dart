
import 'package:hive_flutter/adapters.dart';
part 'shedule_model.g.dart';

@HiveType(typeId: 2)
class SheduleTripMode{

  @HiveField(0)
  String destination;

  @HiveField(1)
  String startingDate;

  @HiveField(2)
  String endingDate;

  @HiveField(3)
  List <String> companion;

  @HiveField(4)
  int budget;


   @HiveField(5)
   String? userId;
 
   @HiveField(6)
   String? dataKey;

   SheduleTripMode({
    this.dataKey,
    this.userId,
   required this.destination,
   required this.startingDate,
   required this.endingDate,
   required this.companion,
   required this.budget
   });

   
}