part of '../custom_widgets.dart';

class SearchLocationDelegate extends SearchDelegate {
  late final MapFinderNotifier mapNotifier;

  @override
  String get searchFieldLabel => 'Buscar';

  Timer? debouncerTimer;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  SearchLocationDelegate(MapFinderNotifier mapsFinderProvider) {
    mapNotifier = mapsFinderProvider;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => {
        close(context, null),
        /* cleanStreams(), */
      },
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    /* query = searchProvider.getQuerySearched; */

    _onQueryChanged(context, query);
    /* resultBloc.getSearchStore(query); */
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          query.isNotEmpty
              ? 'Resultados de busqueda para "$query"'
              : 'Mostrando todos los resultados',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        Expanded(
          child: FutureBuilder<MapLocation>(
              future: getLocationQuery(query),
              builder: (context, data) {
                if (data.connectionState == ConnectionState.waiting ||
                    !data.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListViewSuggestResult(
                    suggestionList: data.data!,
                    selectStore: (candidate) {
                      mapNotifier.setMarkerSelectedPosition(candidate);

                      context.pop();
                    });
              }),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(context, query);
    return Container();
  }

  void _onQueryChanged(BuildContext context, String query) {
    if (debouncerTimer?.isActive ?? false) debouncerTimer!.cancel();

    debouncerTimer = Timer(Duration(milliseconds: 250), () async {
      print(query);
      if (query.isEmpty) {
        return;
      }
      final result = await getLocationQuery(query);
      mapNotifier.setCurrentPosition(
        result.candidates.first,
      );
    });
  }
}

class ListViewSuggestResult extends StatelessWidget {
  final MapLocation suggestionList;
  final void Function(Candidate candidate) selectStore;
  const ListViewSuggestResult({
    super.key,
    required this.suggestionList,
    required this.selectStore,
  });

  @override
  Widget build(BuildContext context) {
    final candidates = suggestionList.candidates;
    const double sizeImage = 40;

    return ListView.builder(
      itemCount: candidates.length,
      itemBuilder: (context, i) {
        final candidate = candidates[i];
        return ListTile(
          /* leading: Hero(
            tag: candidates[i].formattedAddress,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                suggestionList[i].imageUrl,
                width: sizeImage,
                height: sizeImage,
              ),
            ),
          ), */
          title: Text(candidate.name.toCapitalizeEachWord()),
          onTap: () => selectStore(candidate),
        );
      },
    );
  }
}

/* TODO CHANGE REQUREST TO ACCEPT OTRHERS URLS */
Future<MapLocation> getLocationQuery(String query) async {
  final googleApiKey = Environment.googleMapsApiKey;
  final url =
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$query&inputtype=textquery&fields=formatted_address,name,geometry&key=$googleApiKey';
  final response = await Request.sendRequest(RequestType.get, url);
  final mapLocation = mapLocationFromJson(response!.body);
  return mapLocation;
}
