import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_manager/core/colors.dart';
import 'package:geolocator/geolocator.dart';

class Locationpage extends ConsumerStatefulWidget {
  const Locationpage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationpageState();
}

class _LocationpageState extends ConsumerState<Locationpage> {
  Future<Position> getCurrentlocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Service is not Enabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission is delayed');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission is denied Forever");
    }
    return Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final Future<Position> postion = getCurrentlocation();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 120,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                "Location",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              centerTitle: true,
            ),
            leading: IconButton(
              style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Appcolors.brandColor,
              ),
            ),
            backgroundColor: Appcolors.brandColor,
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Appcolors.brandColor,
              ),
              child: Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FutureBuilder(
                          future: postion,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return const Text(
                                "No Connection",
                                style: TextStyle(
                                    color: Appcolors.brandColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator.adaptive();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return SizedBox(
                                height: 400,
                                width: 400,
                                child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(snapshot.data!.latitude,
                                            snapshot.data!.longitude))),
                              );
                            }
                            return const Text(
                              "Unknonw Error",
                              style: TextStyle(
                                  color: Appcolors.brandColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
