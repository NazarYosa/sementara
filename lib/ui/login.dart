// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final emailEdc = TextEditingController();
//   final passEdc = TextEditingController();
//   bool passInvisible = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
//         child: ListView(
//           children: [
//             const Text(
//               "Login",
//               style: TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff3D4DE0)),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Text(
//               "Silahkan masukan e-mail dan password anda",
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             const Text(
//               "e-mail",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             TextFormField(
//               controller: emailEdc,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "password",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             TextFormField(
//               controller: passEdc,
//               decoration: InputDecoration(
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                       passInvisible ? Icons.visibility : Icons.visibility_off),
//                   onPressed: () {
//                     setState(() {
//                       passInvisible = !passInvisible;
//                     });
//                   },
//                 ),
//               ),
//               obscureText: !passInvisible,
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/home');
//                 },
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff3D4DE0),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                 child: const Text(
//                   "Login",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24,
//                       color: Colors.white),
//                 )),
//             const SizedBox(
//               height: 25,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Belum punya akun ?"),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/register');
//                     },
//                     child: const Text(
//                       "Daftar",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff3D4DE0)),
//                     ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum6/bloc/login/login_cubit.dart';
import '../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailEdc = TextEditingController();
  final passEdc = TextEditingController();
  bool passInvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(content: Text('Loading..')));
          }
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.red,
              ));
          }
          if (state is LoginSuccess) {
// context.read<AuthCubit>().loggedIn();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.green,
              ));
            Navigator.pushNamedAndRemoveUntil(context, rHome, (route) => false);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child: ListView(
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3D4DE0)),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Silahkan masukan e-mail dan password anda",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "e-mail",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: emailEdc,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: passEdc,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(passInvisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passInvisible = !passInvisible;
                      });
                    },
                  ),
                ),
                obscureText: !passInvisible,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<LoginCubit>()
                        .login(email: emailEdc.text, password: passEdc.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3D4DE0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  )),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, //Menengahkan elemen horizontal
                children: [
                  const Text("Belum punya akun ?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3D4DE0)),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
