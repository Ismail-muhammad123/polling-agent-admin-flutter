import 'package:admin/pages/home.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool _loading = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.4,
            scale: 0.1,
            fit: BoxFit.fitWidth,
            image: AssetImage(
              "assets/images/assembly.png", // TODO change asset path
            ),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png", // TODO: remove assets when compiling or web
              height: 200.0,
              width: 200.0,
            ),
            Text(
              "Polls Monitor".toUpperCase(),
              style: const TextStyle(
                fontSize: 30.0,
                color: Colors.red,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _loading
                ? const Text(
                    "loading, please wait...",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _loading
                  ? const CircularProgressIndicator(
                      color: Colors.red,
                    )
                  : Container(
                      width: 400,
                      height: 250,
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(6, 6),
                              blurRadius: 12.0),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Login".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                label: Text("Email"),
                                icon: Icon(Icons.email),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                label: Text("Password"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              },
                              color: Colors.green,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
