import 'package:nguyentuananh_2224802010328_lab4/controllers/auth_services.dart';
import 'package:nguyentuananh_2224802010328_lab4/views/login_page.dart';
import 'package:nguyentuananh_2224802010328_lab4/views/add_contact_page.dart';
import 'package:nguyentuananh_2224802010328_lab4/views/home.dart';
import 'package:nguyentuananh_2224802010328_lab4/views/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// Import các page khác của bạn ở đây...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade800),
      ),
      routes: {
        "/": (context) => const CheckUser(),
        "/home": (context) => const Homepage(),
        "/signup": (context) => const SignUpPage(),
        "/login": (context) => const LoginPage(),
        "/add": (context) => const AddContactPage(),
      },
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});
  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    AuthService().isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}