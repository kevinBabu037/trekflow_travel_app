import 'package:flutter/material.dart';
import 'package:travel_app/functions/hive_functions.dart';
import '../reuseable_widgets/reuseable_widgets.dart';
import '../sign_up/signup_screen.dart';

class LoginPage extends StatefulWidget {


  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   bool error=false;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(padding:const EdgeInsets.only(left: 30  ,right: 30),
          child: SafeArea(
            child:SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      const SizedBox(height: 200,),
                       appNAme(),
                       appNameDownTxt(),
                       sizedBox(height: 50),         
                       buildTextFormField(
                        controller:_usernameController , 
                        labelText: "Username",  
                        validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter username';
                      }else if(value.length<3){
                        return 'please enter atleast 3 characters';
                      }
                      return null;
                    }, 
                        onChanged:  (value){
                      setState(() {
                        if(error){
                          error=true;
                        } 
                      });
                    }), 
                    
                       sizedBox(height: 15,),

                       buildTextFormField(
                        hidepassword: true,
                        controller:_passwordController , 
                        labelText: "password",  
                        validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter your password'; 
                      }else if(value.length<4){
                        return 'please enter atleast 4 characters';
                      }
                      return null;
                    }, 
                        onChanged:  (value){
                      setState(() {
                        if(error){
                          error=true;
                        }
                      });
                    }),
                        const SizedBox(height: 15,), 
                       ElevatedButton(
                         onPressed: ()async{
                         LoginService.loginCheck(
                          context: context, 
                          usernameController: _usernameController, 
                          passwordController: _passwordController, 
                          formKey: _formKey);
                            },
                       child:const Text('        LOG IN        ',
                       style: TextStyle(color: Colors.white),)),
                       Row(mainAxisAlignment: MainAxisAlignment.center, 
                       children: [const Text("You don't have account?", 
                       style: TextStyle(color: Colors.grey),),
                       TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const SignInPage(),));
                       }, 
                       child:const Text("SIGN UP"))]), 
                  ],
                ),
              ),
            )
             ),
        ),
      ),
    );

  }  
}


