part of '../screens.dart';

class MapFindLocationScreen extends HookConsumerWidget {
  final Function(Candidate candidate)? onSelectedLocation;
  final LatLng? initialPosition;
  static const routeName = "/map-find-location";

  const MapFindLocationScreen({
    super.key,
    this.initialPosition,
    this.onSelectedLocation,
  });

  @override
  Widget build(BuildContext context, ref) {
    final mapNotifier = ref.read(mapFinderNotifierProvider.notifier);
    final mapState = ref.watch(mapFinderNotifierProvider);
    final mapController = useState<GoogleMapController?>(null);
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    final isLoading = useState(true);

    void permissionRequest(
      BuildContext context,
      ValueNotifier<bool> isLoading,
    ) async {
      final status = await Permission.location.request();
      checkGPSAccess(status);
      isLoading.value = true;

      if (initialPosition != null) {
        mapNotifier.setCurrentPosition(
          Candidate(
            name: 'Ubicación inicial',
            geometry: Geometry(
              location: Location(
                lat: initialPosition!.latitude,
                lng: initialPosition!.longitude,
              ),
            ),
            formattedAddress: 'Ubicación inicial',
          ),
        );
      } else {
        final location = await getLocation();
        mapNotifier.setCurrentPosition(
          Candidate(
            name: 'Ubicación actual',
            geometry: Geometry(
              location: Location(
                lat: location.latitude,
                lng: location.longitude,
              ),
            ),
            formattedAddress: 'Ubicación actual',
          ),
        );
      }
      isLoading.value = false;
    }

    void moveMap() {
      if (mapController.value != null) {
        mapController.value!.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(
              mapState.candidateSelectedPosition!.geometry.location.lat,
              mapState.candidateSelectedPosition!.geometry.location.lng,
            ),
            17,
          ),
        );
      }
    }

    useEffect(
      () {
        permissionRequest(context, isLoading);
        return () {};
      },
      [],
    );
    useEffect(
      () {
        if (mapState.candidateSelectedPosition != null) {
          moveMap();
        }
      },
      [
        mapState.candidateSelectedPosition,
        mapController.value,
      ],
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.location_pin, color: Colors.white),
        onPressed: () {
          /* if (onSelectedLocation != null) {
            onSelectedLocation!(mapState.candidate!);
          }
          context.pop(); */
          mapController.value!.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(
                mapState.candidateCurrentPosition!.geometry.location.lat,
                mapState.candidateCurrentPosition!.geometry.location.lng,
              ),
              17,
            ),
          );
        },
      ),
      /* appBar: AppBar(
        title: const Text('Selecciona una ubicación'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchLocationDelegate(
                  mapNotifier,
                ),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          /* IconButton(
            onPressed: () {
              if (onSelectedLocation != null) {
                /* onSelectedLocation!(mapState.currentPositionMarker!.); */
                
              }
              context.pop();
            },
            icon: const Icon(Icons.location_on, color: Colors.green),
          ), */
        ],
      ), */
      body: SafeArea(
        child: isLoading.value
            ? Center(
                child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      /* color: Colors.white, */
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(appIcon))),
              )
            : Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    markers: mapState.markers,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        mapState
                            .candidateCurrentPosition!.geometry.location.lat,
                        mapState
                            .candidateCurrentPosition!.geometry.location.lng,
                      ),
                      zoom: 16,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      mapController.value = controller;
                    },
                    onTap: (LatLng position) {
                      inspect(position);
                      mapNotifier.setMarkerSelectedPosition(
                        Candidate(
                          name: 'Ubicación seleccionada',
                          geometry: Geometry(
                            location: Location(
                              lat: position.latitude,
                              lng: position.longitude,
                            ),
                          ),
                          formattedAddress: 'Ubicación seleccionada',
                        ),
                      );
                    },
                  ),
                  mapState.isFetching
                      ? Opacity(
                          opacity: 0.6, // Valor de opacidad (0.0 a 1.0)
                          child: Container(
                            color: Colors.black, // Color oscuro
                          ),
                        )
                      : const SizedBox(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      /* color: Colors.red, */
                      width: double.infinity,
                      height: kToolbarHeight,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: BackIcon(
                              size: 40,
                            ),
                          ),
                          SimpleText(
                            padding: const EdgeInsets.only(left: 10),
                            'Ubicación de envio',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: SearchLocationDelegate(
                                  mapNotifier,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
