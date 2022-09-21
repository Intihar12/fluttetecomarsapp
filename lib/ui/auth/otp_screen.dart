// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kiwkemart/data/singleton/singleton.dart';
// import 'package:kiwkemart/ui/home/home_homepage1.dart';
//
//
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/values/strings.dart';
// import 'package:kiwkemart/ui/widgets/timer_widget.dart';
//
// import 'components/otptextfield.dart';
//
// class OtpScreen extends StatefulWidget {
//
//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//
//
//   FirebaseAuth auth = FirebaseAuth.instance;
//   bool disable = true;
//   late String _verificationId;
//   final _smsController=TextEditingController();
//   final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
//   @override
//   void initState() {
//     codeSend();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final colorScheme = Theme.of(context).colorScheme;
//     return Scaffold(
//       key: _scaffoldkey,
//       appBar: AppBar(
//         title: Text('Enter OTP Code'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding:  EdgeInsets.symmetric(
//             horizontal: Dimens.size14,
//           ),
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Verify Number:',
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       '${SingleToneValue.instance.cCode! + SingleToneValue.instance.number!}',
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 OtpTextField(
//                   onCodeEnter: (String data) async {
//                     print('ahjsd');
//                     if (data.length == 6) {
//                       try {
//                         final AuthCredential credential =
//                         PhoneAuthProvider.credential(
//                           verificationId: _verificationId,
//                           smsCode: data,
//                         );
//                         final User? user = (await auth
//                             .signInWithCredential(
//                             credential))
//                             .user;
//                         _scaffoldkey.currentState!
//                             .hideCurrentSnackBar();
//                         _scaffoldkey.currentState!
//                             .showSnackBar(SnackBar(
//                             content: Text(
//                                 "OTP successfully")));
//                         Future.delayed(
//                             const Duration(
//                                 milliseconds: 1500), () {
//                           Get.to(Home());
//                         });
//                       } catch (e) {
//                         // pr.hide();
//                         _scaffoldkey.currentState!
//                             .hideCurrentSnackBar();
//                         _scaffoldkey.currentState!
//                             .showSnackBar(SnackBar(
//                             content: Text(
//                                 "Enter code again")));
//                       }
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 6.0),
//                   child: Container(
//                     height: size.height * 0.065,
//                     width: size.width,
//                     child: Button(
//                       title: 'Resend',
//                       backgroundColor: colorScheme.primary,
//                       textColor: colorScheme.background,
//                       onPressed: !disable?codeSend:null,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 ProgressTimerWidget(() {
//                   setState(() {
//                     disable = false;
//                   });
//
//                 }),
//               ]),
//         ),
//       ),
//     );
//   }
//
//   codeSend() async {
//     PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential phoneAuthCredential) async {
//       await auth.signInWithCredential(phoneAuthCredential);
//       if(phoneAuthCredential.smsCode!=null) {
//         ProgressTimerWidget(() {
//           disable = false;
//         });
//         {
//           setState(() {
//             _smsController.text = phoneAuthCredential.smsCode!;
//           });
//           // ignore: deprecated_member_use
//           _scaffoldkey.currentState!.showSnackBar(
//               SnackBar(content: Text(Strings.codeIsAuto)));
//           Future.delayed(const Duration(milliseconds: 2500), () {
//             Get.offAll(Home());
//           });
//         }
//       }
//       else
//         // ignore: deprecated_member_use
//         _scaffoldkey.currentState!.showSnackBar(
//             SnackBar(content: Text(Strings.phoneIsAlready)));
//       Future.delayed(const Duration(milliseconds: 2500), () {
//         // Get.off(Signupscreen(false));
//       });
//     };
//     PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException authException) {
//       // ignore: deprecated_member_use
//       _scaffoldkey.currentState!.showSnackBar(
//           SnackBar(content: Text("${Strings.phoneVerificationFailed}, ${authException.message}")));
//     };
//     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       // ignore: deprecated_member_use
//       _scaffoldkey.currentState!.showSnackBar(
//           SnackBar(content: Text(Strings.entercode)));
//       _verificationId = verificationId;
//     };
//
//     PhoneCodeSent codeSent =
//         (String verificationId, [int? forceResendingToken]) async {
//       _scaffoldkey.currentState!.hideCurrentSnackBar();
//       _scaffoldkey.currentState!.showSnackBar(SnackBar(
//           content:
//           Text("phone verification code")));
//       _verificationId = verificationId;
//     };
//
//     // PhoneCodeSent codeSent =
//     //     (String verificationId, [int? forceResendingToken]) async {
//     //   // ignore: deprecated_member_use
//     //   _scaffoldkey.currentState!.showSnackBar(
//     //       SnackBar(content: Text(Strings().phoneVerification)));
//     //   _verificationId = verificationId;
//     // };
//     try {
//       await auth.verifyPhoneNumber(
//         phoneNumber: SingleToneValue.instance.cCode!+ SingleToneValue.instance.number!,
//         timeout: const Duration(seconds: 5),
//         verificationCompleted: verificationCompleted,
//         verificationFailed: verificationFailed,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//       );
//     } catch (e) {
//       // ignore: deprecated_member_use
//       _scaffoldkey.currentState!.showSnackBar(
//           SnackBar(content: Text("${Strings.failedToVerify},${e}")));
//     }
//   }
// }
//
// class Button extends StatelessWidget {
//   String title;
//   Color? backgroundColor;
//   Color? textColor;
//   void Function()? onPressed;
//
//   Button({
//     required this.title,
//     this.backgroundColor,
//     this.textColor,
//     this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       color: MyColors.parpal,
//       onPressed: onPressed,
//       child: Text(
//         title,
//         style: TextStyle(
//           color:  textColor,
//         ),
//       ),
//     );
//   }
// }
//
