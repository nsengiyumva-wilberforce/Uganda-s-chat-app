import 'package:chat_app/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() async{
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      //sign in
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      "Welcome back, you have been missed",
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
                      height: 25,
                    ),
                
                    //sign in button
                    MyButton(onTap: signIn, text: "Sign in"),
                
                    const SizedBox(
                      height: 50,
                    ),
                    //not a member? register now
                    Row(
                      children: [
                        const Text("Not a member?"),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Register now",
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
