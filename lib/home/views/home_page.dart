import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/homepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          SizedBox(
            height: 150,
            child: Image.asset(
              'assets/images/thunder.png',
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            "Welcome Back",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "name",
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Email",
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 15,
          ),
          ActionChip(label: const Text("Logout"), onPressed: () {})
        ]),
      ),
    );
  }
}
