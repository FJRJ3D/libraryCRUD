import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_crud/BookListScreen.dart';
import 'package:library_crud/inputs.dart';
import 'package:library_crud/book_service.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final bookService = Book_service();
  // bookService.createBookAuto('Book1', 'Author1', 'Description1', 2001);
  // bookService.createBookAuto('Book2', 'Author2', 'Description2', 2002);
  // bookService.createBookAuto('Book3', 'Author3', 'Description3', 2003);
  runApp(MyApp(bookService: bookService));
}

class MyApp extends StatelessWidget {
  final Book_service bookService;
  const MyApp({super.key, required this.bookService});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Library CRUD'),
            bottom: TabBar(
              tabs: [
                Tab(text: "Book list"),
                Tab(text: "Add book"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BookListScreen(bookService: bookService),
              BookInputList(bookService: bookService),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}