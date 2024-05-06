
import 'package:flutter/material.dart';
import 'package:travel_app/presentation/login/first_page.dart';
import 'package:travel_app/presentation/widgets/reuseable_widgets.dart';


class SplashScreen extends StatefulWidget {
  final String? userId;
  const SplashScreen({super.key, this.userId});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigatingSplashScreen();
  }


  Future<void>navigatingSplashScreen ()async{
     await Future.delayed(const Duration(seconds: 3)); 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstPage(userId:widget.userId ),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  
        
           SingleChildScrollView(
             child: Column(
              children: [
                sizedBox(height: 200),
                appNAme(),
               const SizedBox(height: 10,),
                appNameDownTxt(),
               const SizedBox(height: 30,),
                SizedBox(
                  child:Image.asset('images/app_logo.png') , 
                  ),
                 
               Text('- lets start the journey enjoy\n the beautiful moments of life -' .toUpperCase(),style:const TextStyle(color: Colors.amber,fontSize:18),),

                     ],),
           )
        
       
    );
  }
}