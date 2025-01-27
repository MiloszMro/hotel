import 'package:flutter/material.dart';
import 'package:hotelapp/components/my_textfield.dart';
import 'package:hotelapp/components/my_button.dart';
import 'package:hotelapp/services/auth/auth_service.dart';


class LoginPage extends StatefulWidget{
  final void Function()? onTap;


  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> { 

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async{
   final _authService = AuthService();

   try{
    await _authService.singInWithEmailPassword(emailController.text, passwordController.text,);
   }
   catch(e){
    showDialog(
      context: context,
       builder: (context) => AlertDialog(
        title: Text(e.toString()),
       )
      );
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
            const Text(
              "hotelapp",
              style: TextStyle(
                fontSize: 50,
                color: Color.fromARGB(255, 255, 81, 0),
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

            const SizedBox(height: 15),

            MyButton(
              text: "Zaloguj", 
              onTap: login,
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nie masz konta?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Zarejestruj się",
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