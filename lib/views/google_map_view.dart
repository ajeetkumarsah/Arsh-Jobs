
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class GoogleMapScreen extends StatefulWidget {
  GoogleMapScreen(
      {Key? key,
      this.lat,
      this.long,
      this.title = '',
      this.image,
      this.description = '',
      this.iconDataBytes})
      : super(key: key);
  double? lat, long;
  dynamic image;
  String? title, description;
  // ignore: prefer_typing_uninitialized_variables
  var iconDataBytes;
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Set<Marker> _markers = {};
  BitmapDescriptor mapMarker = BitmapDescriptor.defaultMarker;
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
          icon: mapMarker,
          markerId: const MarkerId('id-1'),
          position: LatLng(widget.lat!, widget.long!),
          infoWindow:
              InfoWindow(title: widget.title, snippet: widget.description)));
    });
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    if (widget.image == null) {
      mapMarker = BitmapDescriptor.defaultMarker;
      // .fromAssetImage(
      //     ImageConfiguration(size: Size(50, 50)),
      //     AppConstants.defaultCompanyImage);
    } else {
      mapMarker = BitmapDescriptor.fromBytes(widget.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _markers,
      onMapCreated: _onMapCreated,
      zoomControlsEnabled: AppConstants.enableZoom,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat!, widget.long!), zoom: AppConstants.zoom),
    );
  }
}
