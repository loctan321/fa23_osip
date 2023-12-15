// import 'package:flutter/material.dart';
// import 'package:optimizing_stock_investment_portfolio/screens/login/login_screen.dart';

// import '../theme/theme.dart';
// import '../widgets/custom_scaffort.dart';
// import 'package:http/http.dart' as http;

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<RegisterScreen> {
//   final _emailController = TextEditingController();

//   final _formSignupKey = GlobalKey<FormState>();
//   bool agreePersonalData = true;
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       child: Column(
//         children: [
//           const Expanded(
//             flex: 1,
//             child: SizedBox(
//               height: 10,
//             ),
//           ),
//           Expanded(
//             flex: 7,
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40.0),
//                   topRight: Radius.circular(40.0),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 // get started form
//                 child: Form(
//                   key: _formSignupKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // get started text
//                       Text(
//                         'Get Started',
//                         style: TextStyle(
//                           fontSize: 30.0,
//                           fontWeight: FontWeight.w900,
//                           color: lightColorScheme.primary,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40.0,
//                       ),
//                       // full name
//                       TextFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter Full name';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           label: const Text('Full Name'),
//                           hintText: 'Enter Full Name',
//                           hintStyle: const TextStyle(
//                             color: Colors.black26,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12, // Default border color
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12, // Default border color
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25.0,
//                       ),
//                       // email
//                       TextFormField(
//                         controller: _emailController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter Email';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           label: const Text('Email'),
//                           hintText: 'Enter Email',
//                           hintStyle: const TextStyle(
//                             color: Colors.black26,
//                           ),
//                           suffixIcon: TextButton(
//                               onPressed: () {
//                                 _sendOtp();
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('OTP send.'),
//                                   ),
//                                 );
//                               },
//                               child: const Text("Send OTP")),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12, // Default border color
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12, // Default border color
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25.0,
//                       ),
//                       // password
//                       TextFormField(
//                         obscureText: true,
//                         obscuringCharacter: '*',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter Password';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           label: const Text('Password'),
//                           hintText: 'Enter Password',
//                           hintStyle: const TextStyle(
//                             color: Colors.black26,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12, // Default border color
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12, // Default border color
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25.0,
//                       ),
//                       //OTP
//                       TextFormField(
//                         obscureText: true,
//                         obscuringCharacter: '*',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter OTP';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           label: const Text('OTP'),
//                           hintText: 'Enter OTP',
//                           hintStyle: const TextStyle(
//                             color: Colors.black26,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12, // Default border color
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12, // Default border color
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25.0,
//                       ),
//                       // i agree to the processing
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: agreePersonalData,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 agreePersonalData = value!;
//                               });
//                             },
//                             activeColor: lightColorScheme.primary,
//                           ),
//                           const Text(
//                             'I agree to the processing of ',
//                             style: TextStyle(
//                               color: Colors.black45,
//                             ),
//                           ),
//                           Text(
//                             'OSP',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: lightColorScheme.primary,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 15.0,
//                       ),
//                       // signup button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formSignupKey.currentState!.validate() &&
//                                 agreePersonalData) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Processing Data'),
//                                 ),
//                               );
//                             } else if (!agreePersonalData) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text(
//                                         'Please agree to the processing of OSP')),
//                               );
//                             }
//                           },
//                           child: const Text('Sign up'),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 30.0,
//                       ),
//                       // sign up divider
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Divider(
//                               thickness: 0.7,
//                               color: Colors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                           // const Padding(
//                           //   padding: EdgeInsets.symmetric(
//                           //     vertical: 0,
//                           //     horizontal: 10,
//                           //   ),
//                           //   child: Text(
//                           //     'Sign up with',
//                           //     style: TextStyle(
//                           //       color: Colors.black45,
//                           //     ),
//                           //   ),
//                           // ),
//                           // Expanded(
//                           //   child: Divider(
//                           //     thickness: 0.7,
//                           //     color: Colors.grey.withOpacity(0.5),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 30.0,
//                       ),
//                       // sign up social media logo

//                       const SizedBox(
//                         height: 25.0,
//                       ),
//                       // already have an account
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             'Already have an account? ',
//                             style: TextStyle(
//                               color: Colors.black45,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (e) => const LoginScreen(),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               'Sign in',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: lightColorScheme.primary,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20.0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _sendOtp() async {
//     if (_formSignupKey.currentState!.validate()) {
//       final response = await http.post(
//         Uri.parse(
//             'https://10.0.2.2:7053/api/Email/SendOtp?toEmail=${_emailController.text}'),
//       );
//       //https://10.0.2.2:7053/api/Stocks/
//       if (response.statusCode == 200) {
//         // OTP gửi thành công
//         print("OTP Sent");
//       } else {
//         // Xử lý lỗi
//         print("Not send OTP");
//       }
//     }
//   }
// }
