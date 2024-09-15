part of '../screens.dart';

/* class MapTrafficPolyline extends HookWidget {
  final LatLng? toLocation;
  final bool? showAppBar;
  final String? locationName;
  MapTrafficPolyline({
    Key? key,
    this.toLocation,
    this.showAppBar = true,
    this.locationName,
  });

  void permisionRequest(
      BuildContext context,
      ValueNotifier<LatLng?> currentLocation,
      ValueNotifier<bool> isLoading,
      ValueNotifier<Set<Polyline>> polylines) async {
    final status = await Permission.location.request();
    accesoGPS(status);
    isLoading.value = true;
    final location = await getLocation();
    currentLocation.value = LatLng(location.latitude, location.longitude);
    isLoading.value = false;
    setPolylines(
      context,
      currentLocation.value!,
      toLocation!,
      polylines,
    );
  }

  void moveMap(BuildContext context) {
    final mapsFinderProvider = context.read<MapsFinderProvider>();
    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          mapsFinderProvider.state.candidate!.geometry.location.lat,
          mapsFinderProvider.state.candidate!.geometry.location.lng,
        ),
        17,
      ),
    );
  }

  void setPolylines(
    BuildContext context,
    LatLng start,
    LatLng end,
    ValueNotifier<Set<Polyline>> polylines,
  ) async {
    final res = await getCoordsInicioAndFin(start, end);
    polylines.value = {
      Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.blue,
        width: 6,
        points: res,
      ),
    };
  }

  late final GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    final isLoading = useState(true);
    final startFrom = useState<LatLng?>(null);
    final polylines = useState<Set<Polyline>>({});

    useEffect(
      () {
        permisionRequest(context, startFrom, isLoading, polylines);

        return () {};
      },
      [],
    );

    return Scaffold(
      appBar: !showAppBar!
          ? null
          : AppBar(
              title: locationName == null
                  ? SizedBox()
                  : Text('Ubicación de ${locationName}')),
      body: isLoading.value
          ? Center(
              child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          Image.asset('assets/loadings/hand_bag_loading.gif'))),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  polylines: polylines.value.toSet(),
                  markers: {
                    Marker(
                      markerId: const MarkerId('start'),
                      position: startFrom.value ?? LatLng(0, 0),
                      infoWindow: InfoWindow(
                        title: 'Inicio',
                      ),
                    ),
                    Marker(
                      markerId: const MarkerId('end'),
                      position: toLocation ?? LatLng(0, 0),
                      infoWindow: InfoWindow(
                        title: 'Fin',
                      ),
                    ),
                  },
                  initialCameraPosition: CameraPosition(
                    target: startFrom.value ?? LatLng(0, 0),
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    mapController = controller;
                  },

                  /*  onTap: (LatLng position) {
                   
                    mapController!.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        LatLng(
                          stateM.candidate!.geometry.location.lat,
                          stateM.candidate!.geometry.location.lng,
                        ),
                        17,
                      ),
                    );
                  }, */
                ),
                isLoading.value
                    ? Opacity(
                        opacity: 0.6, // Valor de opacidad (0.0 a 1.0)
                        child: Container(
                          color: Colors.black, // Color oscuro
                        ),
                      )
                    : SizedBox(),
              ],
            ),
    );
  } 
}
  */
