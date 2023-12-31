import 'package:finalproject/pages/auth.dart';
import 'package:finalproject/pages/blog.dart';
import 'package:finalproject/pages/order_detail.dart';
import 'package:finalproject/pages/product_detail.dart';
import 'package:finalproject/pages/verify_email.dart';
import 'package:finalproject/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: Toast.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
        routes: {
          ProductDetail.routeName: (context) => const ProductDetail(),
          OrderDetail.routeName: (context) => const OrderDetail(),
          BlogDetail.routeName: (context) => const BlogDetail(),
        },
      );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            } else if (snapshot.hasData) {
              return const VerifyEmail();
            } else {
              return const SingleChildScrollView(
                child: Auth(),
              );
            }
          },
        ),
      );
}
