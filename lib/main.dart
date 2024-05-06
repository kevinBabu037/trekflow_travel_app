
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/data/model/admin_model.dart';
import 'package:travel_app/data/model/comment.dart';
import 'package:travel_app/data/model/fav_model.dart';
import 'package:travel_app/data/model/profilemodel.dart';
import 'package:travel_app/data/model/shedule_model.dart';
import 'package:travel_app/data/model/signin_model.dart';
import 'package:travel_app/presentation/screens/navbar.dart';
import 'package:travel_app/presentation/splash/splash_screen.dart';


String? loggedInUsername;
String? loggedUserId;
Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter();
  Hive.registerAdapter(SignInModelAdapter()); 
  Hive.registerAdapter(AdminModelAdapter());
  Hive.registerAdapter(SheduleTripModeAdapter()); 
  Hive.registerAdapter(FavModelAdapter());
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(CommentModelAdapter());

  await Hive.openBox <SignInModel>('signin'); 
  await Hive.openBox <AdminModel>('admin') ; 
  await Hive.openBox <SheduleTripMode>('sheduleTrip');
  await Hive.openBox <FavModel>('favorite'); 
  await Hive.openBox <ProfileModel>('profile');
  await Hive.openBox <CommentModel>('comment'); 

  SharedPreferences prefs = await SharedPreferences.getInstance(); 
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
 

  runApp(Myapp(isLoggedIn: isLoggedIn));
}
 class Myapp extends StatelessWidget {
  final bool isLoggedIn;
  const Myapp({required this.isLoggedIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){ 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: GoogleFonts.nunito(),
          bodyMedium:GoogleFonts.nunito()
        ),
       primarySwatch: Colors.amber
      ),
     home: isLoggedIn ? NavBar(userId: loggedUserId,) : SplashScreen(userId: loggedUserId),  
    );
  }
}