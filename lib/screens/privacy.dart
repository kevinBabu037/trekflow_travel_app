import 'package:flutter/material.dart';
import 'package:travel_app/reuseable_widgets/reuseable_widgets.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _AboutPageState();
}

class _AboutPageState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
       actions:const [ Icon(Icons.abc,color: Colors.white,)],
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [ Text('Privacy Policy '),Icon(Icons.privacy_tip,color: Colors.amber,)]),
      ),
      body: SingleChildScrollView(
             child: Padding(padding:const EdgeInsets.all(15),
               child: Column(
                children: [
                       const Text(privacyPlolicyText,style: TextStyle(fontSize:16 ),),
                 sizedBox(height: 10)
                ], 
               ),
             ),
      ),
    );
  }
}