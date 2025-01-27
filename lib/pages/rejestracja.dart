import 'package:flutter/material.dart';
import 'package:hotelapp/components/my_button.dart';
import 'package:hotelapp/components/my_textfield.dart';
import 'package:hotelapp/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

   @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

void register() async{
  final _authService = AuthService();

  if (passwordController.text == confirmpasswordController.text){
    try{
      await _authService.singUpWithEmailPassword(emailController.text, passwordController.text,);
    }
    catch(e){
      showDialog(
        context: context,
         builder: (context) => AlertDialog(
          title: Text(e.toString()),
         ));
    }
  }
  else{
    showDialog(
        context: context,
         builder: (context) => AlertDialog(
          title: Text("Hasła są różne"),
         ));
  }
}
 

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "hotelapp",
              style: TextStyle(
                fontSize: 50,
                color: const Color.fromARGB(255, 255, 81, 0),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
             
            const SizedBox(height: 10),

            MyTextField(
              controller: passwordController,
              hintText: "Hasło",
              obscureText: true,
            ),

            const SizedBox(height: 10),

            MyTextField(
              controller: confirmpasswordController,
              hintText: "Potwierdź hasło",
              obscureText: true,
            ),

            const SizedBox(height: 15),

            MyButton(
              text: "Zarejestruj", 
              onTap: register,
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mam już konto",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Zaloguj się",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                )
              ]
            ,)
          ],
        ),
      ),
    );
  }
}