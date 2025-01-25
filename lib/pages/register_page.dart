import 'package:chat_app/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

      void signUp() async{
        //make sure passwords match
        if(passwordController.text != confirmPasswordController.text){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Passwords do not match"),
            )
          );
          return;
        } else {
          //get auth service
          final authService = Provider.of<AuthService>(context, listen: false);

          try{
            //sign up
            await authService.createUserWithEmailAndPassword(emailController.text, passwordController.text);
          }catch(e){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              )
            );
          }
        }
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    //logo
                    Icon(
                      Icons.message,
                      size: 80,
                      color: Colors.grey[800],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                
                    //welcome back message
                    Text(
                      "Let's create an account for you!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                
                    const SizedBox(
                      height: 50,
                    ),
                
                    //email field
                    MyTextField(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false),
                    //password field
                    const SizedBox(
                      height: 10,
                    ),
                
                    MyTextField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true),
                
                    const SizedBox(
                      height: 10,
                    ),
                
                    MyTextField(
                        controller: confirmPasswordController,
                        hintText: "Confirm Password",
                        obscureText: true),
                
                    const SizedBox(
                      height: 25,
                    ),
                
                    //sign up button
                    MyButton(onTap: signUp, text: "Sign up"),
                
                    const SizedBox(
                      height: 50,
                    ),
                    //not a member? register now
                    Row(
                      children: [
                        const Text("Already a member?"),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Login now",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
