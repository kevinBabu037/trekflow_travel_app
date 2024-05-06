import 'package:hive/hive.dart';
part 'comment.g.dart';

@HiveType(typeId: 5)
class CommentModel{
  @HiveField(0)
  String comment;

   @HiveField(1)
  String? placeId;

  CommentModel({required  this.comment,required this.placeId});

}