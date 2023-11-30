import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/SPF_track_model.dart';
import 'package:frontend_flutter/models/album_model.dart';
import 'package:frontend_flutter/services/graphql_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<SPF_TrackModel>? _tracks;
  final GraphQLService _graphQLService = GraphQLService();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tracks = null;
  }

  void _getTrack(title) async {
    _tracks = await _graphQLService.getTrackFromSearch(inputTitle: title);
    setState(() {});
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
            TextField(
              onSubmitted: (text) {
                _getTrack(text);
              },
              controller: textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Search for an Album',
                suffixIcon: IconButton(
                  onPressed: () {
                    _getTrack(textController.text);
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            // Text(
            //   '${_album?[0].title} by ${_album?[0].artists[0]} ',
            // ),
          ],
        ),
      ),
    );
  }
}
