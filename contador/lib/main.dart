import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int count = 0;

  void decrement() {

    setState(() {
      if(count > 0) {
        count --;
        print(count);
      }
    });


  }

  void increment() {

    setState(() {
      count++;
      print(count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 240, 240, 240),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/fundo.jpg'),
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pode entrar',
                style: TextStyle(
                  fontSize: 70,
                  color: Color.fromARGB(220, 20, 20, 20),
                  fontWeight: FontWeight.bold,
                  fontFamily: "RobotoMono",
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '$count',
                style: const TextStyle(fontSize: 100),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: decrement,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(100,100),
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text('Saiu',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      ),),
                  ),
                  const SizedBox(width: 32,),
                  TextButton(
                    onPressed: increment,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(100,100),
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text('Entrou',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      ),),
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}





