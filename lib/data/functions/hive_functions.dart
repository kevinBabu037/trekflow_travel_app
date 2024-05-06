
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:travel_app/presentation/admin_side/admin_navbar.dart';
import 'package:travel_app/presentation/login/login_screen.dart';
import 'package:travel_app/data/model/admin_model.dart';
import 'package:travel_app/data/model/shedule_model.dart';
import 'package:travel_app/presentation/screens/navbar.dart';
import '../model/signin_model.dart';
import '../../presentation/widgets/reuseable_widgets.dart';
import '../../main.dart';

class LoginService {
  static Future<void> loginCheck({
    required BuildContext context,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    required GlobalKey<FormState> formKey,
  }) async {
    Box signInBox = Hive.box<SignInModel>('signin');
    var signInData = signInBox.values.cast<SignInModel>().toList();

    String enteredUsername = usernameController.text.trim();
    String enteredPassword = passwordController.text.trim();

    if (enteredUsername == '@admin' && enteredPassword == 'admin123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const AdminNavbar()),
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      SignInModel? loggedInUser;
      try {
        loggedInUser = signInData.firstWhere(
            (data) =>
                data.userName == enteredUsername &&
                data.password == enteredPassword);
      } catch (e) {
        // If no matching user is found, loggedInUser will be null
      }

      if (loggedInUser != null) {
        var loggedInUserKey =
            signInBox.keyAt(signInData.indexOf(loggedInUser)).toString();
        
          loggedUserId = loggedInUserKey;
          debugPrint('user id on login $loggedUserId');
        


        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn',  true);
        loggedInUsername = usernameController.text.trim();
        prefs.setString('loggedInUsername', loggedInUsername!);
        prefs.setString('loggedInUserId', loggedUserId.toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavBar(userId: loggedUserId),
          ),
        );
      } else {
        showSnackBar(
          context: context,
          message: 'Username and password do not match',
          snakBarclr: Colors.red,
        );
      }
    }
  }
}


///////////////////


class SignInService {
  static void addSignInData({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController userNameController,
    required TextEditingController emailIdController,
    required TextEditingController passwordController,
  }) {
    Box signInBox = Hive.box<SignInModel>('signin');

    final isValid = formKey.currentState?.validate();
    if (isValid != null && isValid) {
      formKey.currentState?.save();

      String? userName = userNameController.text.trim();
      String? emailId = emailIdController.text.trim();
      String? password = passwordController.text.trim();

      if (userName .isNotEmpty && emailId.isNotEmpty && password .isNotEmpty) {
        String userId = DateTime.now().millisecondsSinceEpoch.toString();
        signInBox.put(
          userId,
          SignInModel(
            userId: userId,
            userName: userName,
            emailId: emailId,
            password: password,
          ),
        );
        showSnackBar(
          context: context,
          message: 'Verified successfully',
          snakBarclr: Colors.green,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        showSnackBar(
          context: context,
          message: 'Please enter username and password',
          snakBarclr: Colors.red,
        );
      }
    }
  }
}

// admin_data_functions.dart

class AdminDataFunctions {

  static void getImage({
    required Function(XFile?) setImage,
  }) async {
    // ignore: deprecated_member_use, invalid_use_of_visible_for_testing_member
    final image = await ImagePicker.platform.getImage(
      source: ImageSource.gallery,
    );
    setImage(image);
  }

  static void resetForm(GlobalKey<FormState> formKey) {
    formKey.currentState?.reset();
    
  }
}

/////////////////////////

class HiveFunctions {
  static void updateAdminModel(Box<AdminModel> box, AdminModel oldData, AdminModel newData) {
    int index = box.values.toList().indexOf(oldData);
    box.putAt(index, newData);
  }
}


// hive_functions.dart



class SheduleServices{
  static void addSheduleData({
    required GlobalKey<FormState> formKey,
    required String destination,
    required String? startingDate,
    required String? endingDate,
    required List<String> companion,
    required int? budget,
    required BuildContext context,
  }) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState?.save();
      if (startingDate != null && endingDate != null) {
        Hive.box<SheduleTripMode>('sheduleTrip').add(
          SheduleTripMode(
            destination: destination,
            startingDate: startingDate,
            endingDate: endingDate,
            companion: companion,
            budget: budget!,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data added successfully'), backgroundColor: Colors.green),
        );
        resetFields(formKey);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Select date'), backgroundColor: Colors.red),
        );
      }
    }
  }

  static void resetFields(GlobalKey<FormState> formKey) {
    formKey.currentState?.reset();
  }
}





