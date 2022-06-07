
import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  // Initialize state containing view.
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  late StreamController _streamController;
  late Stream _stream;

  @override
  void initState() {
    _streamController = StreamController();
    _stream= _streamController.stream;
  }

  void _incrementCounter() {
    _streamController.sink.add(_counter++);
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("rxdart sample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot){

                  return  Text(
                    snapshot.data != null ? snapshot.data.toString() : "0",
                    style: Theme.of(context).textTheme.displayMedium,
                  );
                }
            )
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

// class CounterBloc {
//   final _actionController = StreamController<void>();
//   Sink<void> get increment => _actionController.sink;
//
//   final _countController = StreamController<int>();
//   Stream<int> get count => _countController.stream;
//
//   int _count = 0;
//
//   CounterBloc() {
//     _actionController.stream.listen((_) {
//       _count++;
//       _countController.sink.add(_count);
//     });
//   }
//
//   void dispose() {
//     _actionController.close();
//     _countController.close();
//   }
// }