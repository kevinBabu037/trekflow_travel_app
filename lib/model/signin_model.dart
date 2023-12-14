
 import 'package:hive/hive.dart';
 part 'signin_model.g.dart';

 @HiveType(typeId: 0)
 
 class SignInModel{


 @HiveField(0)
 String? userName;

 @HiveField(1)
 String? emailId;

 @HiveField(2)
 String? password;

 @HiveField(3)
 String? userId;

 @HiveField(4)
 String? image;


 SignInModel({ this.userName, this.emailId, this.password, this.userId,this.image});


}