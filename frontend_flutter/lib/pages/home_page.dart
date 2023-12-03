import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/SPF_artist_model.dart';
import 'package:frontend_flutter/models/SPF_searchResults.dart';
import 'package:frontend_flutter/models/SPF_track_model.dart';
import 'package:frontend_flutter/services/graphql_service.dart';

const List<String> searchOptions = ["track", 'artist', 'album'];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SPF_TrackModel>? _tracks;
  List<SPF_ArtistModel>? _artists;
  final GraphQLService _graphQLService = GraphQLService();
  final TextEditingController textController = TextEditingController();
  final List<bool> _toggleSearchSelection = searchOptions
      .map((e) => e == "track")
      .toList(); // map out default search selection states

  @override
  void initState() {
    super.initState();
    _tracks = null;
    _artists = null;
  }

  // checks which search functionality to do based on search options
  void _runSearch(String name) {
    int selectedIndex =
        _toggleSearchSelection.indexWhere((isSelected) => isSelected);

    if (selectedIndex != -1) {
      String selectedOption = searchOptions[selectedIndex];
      print('Selected Search Option: $selectedOption');

      // run the query that satisfy the filters/ search selection
      if (selectedOption == 'track') {
        print("track selected getting tracks...");
        _getTrack(name);
      } else if (selectedOption == 'artist') {
        print("artist selected getting artists...");
        _getArtist(name);
      }
    }
  }

  // Gets tracks from spotify API
  void _getTrack(String title) async {
    _tracks = await _graphQLService.getTrackFromSearch(inputTitle: title);
    setState(() {});
  }

  void _getArtist(String name) async {
    _artists = await _graphQLService.getArtistFromSearch(inputName: name);
    setState(() {});
  }

  // builds tracks search results
  Widget _buildListViewResults<T extends SPF_SearchResults>(List<T> searchResults) {
    return Expanded(
      child: ListView.builder(
        itemCount: searchResults.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.music_note),
              title: Text(searchResults[index].getTitle()),
              subtitle: Text(searchResults[index].getSubtitle()),
              trailing: Text(searchResults[index].getTrailing()),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(5.0)),
              Material(
                shadowColor: Colors.grey,
                elevation: 5.0,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: TextField(
                  onSubmitted: (text) {
                    _runSearch(text);
                  },
                  controller: textController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    hintText: 'Search for a track, artist or album...',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _runSearch(textController.text);
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
              ),

              const Padding(padding: EdgeInsets.all(2.0)),
              // ---- Search filters ----
              Material(
                shadowColor: Colors.grey,
                elevation: 2.0,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: ToggleButtons(
                  isSelected: _toggleSearchSelection,
                  onPressed: (index) {
                    setState(() {
                      // set the button that has been selected to true, others to false
                      for (int i = 0; i < _toggleSearchSelection.length; i++) {
                        _toggleSearchSelection[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  children: List<Widget>.generate(
                    searchOptions.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(searchOptions[index]),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(5.0)),
              // ---- Search Results ----
              // shows search items in a list view
              _tracks != null ? _buildListViewResults<SPF_TrackModel>(_tracks!) : const Text('')
            ],
          ),
        ),
      ),
    );
  }
}
