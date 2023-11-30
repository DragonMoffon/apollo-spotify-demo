import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/SPF_track_model.dart';
import 'package:frontend_flutter/services/graphql_service.dart';

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

  // Gets tracks from spotify API
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
        child:FractionallySizedBox(
          widthFactor: 0.8,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(2.0)),
              TextField(
                onSubmitted: (text) {
                  _getTrack(text);
                },
                controller: textController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Search for a Track',
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

              // shows search items in a list view
              _tracks == null
                ? const Text('')
                : Expanded(
                  child: ListView.builder(
                    itemCount: _tracks?.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text('${_tracks?[index].name}'),
                        trailing: Text('${_tracks?[index].duration}'),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
