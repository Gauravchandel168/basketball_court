import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:meta/meta.dart';

import '../data/data_providers/http/custom_http_exception.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> fetchLocation() async {
    emit(LocationLoading());

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationError('Location services are disabled.'));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError('Location permissions are denied.'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError(
            'Location permissions are permanently denied.'));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );
      // Convert coordinates to address
      String address = await getAddressFromCoordinates(
          // position.latitude,
          // position.longitude
         // 30.353308,89.8380393
          30.3008, 76.9830
         // 30.353302,76.8380393
      );
      emit(LocationSuccess(position, address));
    } catch (e) {
      if (e is CustomHttpException) {

        emit(LocationError(e.error));
      } else {
        // print(e.toString());
        // print("e.toString()");
        emit(LocationError('Failed to fetch location: $e'));
      }
    }
  }

  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        return address;
      } else {
        return "Unknown location";
      }
    } catch (e) {

      return "Error: $e";
    }
  }

}
