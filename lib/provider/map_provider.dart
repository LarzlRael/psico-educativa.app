import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/provider/auth_provider.dart';

final mapFinderNotifierProvider =
    StateNotifierProvider<MapFinderNotifier, MapFinderState>(
  (ref) => MapFinderNotifier(ref),
);

class MapFinderNotifier extends StateNotifier<MapFinderState> {
  final Ref ref;

  MapFinderNotifier(this.ref) : super(MapFinderState.initialState()) {
    // Configura el listener para cambios en el AuthNotifier
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.authenticateStatus == AuthStatus.authenticated) {
        updatePositionFromAuth(next);
      }
    });
  }

  void updatePositionFromAuth(AuthState authState) {
    final authState = ref.read(authNotifierProvider);
    if (authState.user != null && authState.user!.addressCoordinates != null) {
      final candidate = Candidate(
        name: 'Ubicación actual',
        formattedAddress: authState.user!.location ?? '',
        geometry: Geometry(
          location: Location(
              lat: authState.user!.addressCoordinates!.latitude,
              lng: authState.user!.addressCoordinates!.longitude),
        ),
      );

      setMarkerSelectedPosition(candidate);
    }
  }

  void setMarkers(Set<Marker> markers) {
    state = state.copyWith(
      markers: markers,
    );
  }

  void setMarkerSelectedPosition(Candidate candidate) {
    inspect(candidate);
    state = state.copyWith(
      candidateSelectedPosition: candidate,
      markers: {
        ...state.markers,
        Marker(
          markerId: MarkerId('marker_id_2'),
          position: LatLng(
            candidate.geometry.location.lat,
            candidate.geometry.location.lng,
          ),
          infoWindow: InfoWindow(
            title: candidate.formattedAddress ?? '',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      },
    );
  }

  Future<void> setCurrentPosition(Candidate candidate) async {
    state = state.copyWith(
      candidateCurrentPosition: candidate,
      markers: {
        ...state.markers,
        Marker(
          markerId: MarkerId('marker_id'),
          position: LatLng(
            candidate.geometry.location.lat,
            candidate.geometry.location.lng,
          ),
          infoWindow: InfoWindow(
            title: 'Tu estás aquí',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
      },
    );
  }
}

class MapFinderState {
  final bool isFetching;
  final Candidate? candidateSelectedPosition;
  final Candidate? candidateCurrentPosition;
  final Set<Marker> markers;

  final Marker? currentPositionMarker;

  MapFinderState({
    this.currentPositionMarker,
    this.candidateCurrentPosition,
    this.candidateSelectedPosition,
    required this.isFetching,
    required this.markers,
  });

  factory MapFinderState.initialState() => MapFinderState(
        currentPositionMarker: null,
        candidateSelectedPosition: null,
        candidateCurrentPosition: null,
        isFetching: false,
        markers: {},
      );

  MapFinderState copyWith({
    bool? isFetching,
    Set<Marker>? markers,
    Marker? currentPositionMarker,
    Candidate? candidateSelectedPosition,
    Candidate? candidateCurrentPosition,
  }) =>
      MapFinderState(
        isFetching: isFetching ?? this.isFetching,
        candidateSelectedPosition:
            candidateSelectedPosition ?? this.candidateSelectedPosition,
        candidateCurrentPosition:
            candidateCurrentPosition ?? this.candidateCurrentPosition,
        markers: markers ?? this.markers,
        currentPositionMarker:
            currentPositionMarker ?? this.currentPositionMarker,
      );
}
