import 'package:flutter/material.dart';
import 'package:travel_app/data/functions/hive_functions.dart';
import 'package:travel_app/presentation/login/login_screen.dart';
import 'package:travel_app/presentation/widgets/reuseable_widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}
class _SignInPageState extends State<SignInPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool error=false; 
  // Box signInBox=Hive.box<SignInModel>('signin');
    

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body:  SingleChildScrollView(
          child: Padding(padding:const EdgeInsets.only(right: 30,left: 30),
              child: Form(
                key: _formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  sizedBox(height: 200), 
                  appNAme(),
                  appNameDownTxt(),
                  sizedBox(height: 50),
                  
                 buildTextFormField(
                  controller: _userNameController,
                   labelText: "Username",
                     validator: (value) {
                        if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                        } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                        return 'Username can only contain letters, numbers, and underscores';
                        } else if (value.length < 3) {
                        return 'Username must be at least 3 characters long';
                        }
                        return null;
                     },
                      onChanged:  (value) {
                      setState(() {
                        if(error){
                          error=true;
                        }
                      });
                    },
                      ),

                      sizedBox(height: 15),

                      buildTextFormField(
                  controller: _emailIdController,
                   labelText: "Email Id",
                     validator:  (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter your E mail';
                      }else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                       .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                     },
                      onChanged:  (value) {
                      setState(() {
                        if(error){
                          error=true;
                        }
                      }); 
                    },
                      ),    
                    sizedBox(height: 15), 
                       buildTextFormField(
                        hidepassword: true,
                  controller: _passwordController,
                   labelText: "Password",
                     validator:  (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                         } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                           return 'Password can only contain letters and numbers, ';
                          } else if (value.length <4) {
                           return 'Password must be at least 4 characters long';
                           }
                           return null;
                     },
                      onChanged:  (value) {
                      setState(() {
                        if(error){
                          error=true;
                        }
                      });
                    },
                      ),
                       sizedBox(height: 15),
              
                     ElevatedButton(onPressed: (){
                     SignInService.addSignInData(
                      context: context, formKey: _formKey, 
                      userNameController: _userNameController, 
                      emailIdController: _emailIdController, 
                      passwordController: _passwordController);
                     },
                     child:const Text('        SIGN UP        ',
                     style: TextStyle(color: Colors.white),)),
                      Row(mainAxisAlignment: MainAxisAlignment.center, 
                         children: [const Text("Already you have account?", 
                         style: TextStyle(color: Colors.grey),),
                         TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const LoginPage(),));
                         }, 
                         child:const Text("LOG IN"))]),
                                
                ],),
              ),
            ),
        ),
         
      ),
    ); 
  }

}

