import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:get/get.dart';

class CompletedTrips extends StatefulWidget {
  const CompletedTrips({Key? key}) : super(key: key);

  @override
  _CompletedTripsState createState() => _CompletedTripsState();
}

class _CompletedTripsState extends State<CompletedTrips> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final CompletedTripsController _completedTripController = Get.find();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> pullRefresh() async {
    _completedTripController.getTripList();
    return Future.delayed(
      const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'completed_trip_label'.tr,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onMenuPress: () => openDrawer(),
        showOnlineButton: true,
      ),
      drawer: const MainDrawer(),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SearchField(
              controller:
                  _completedTripController.completedTripsSearchController,
              hint: 'search_trip_input_label'.tr,
              clearEvent: () {
                _completedTripController.completedTripsSearchController.text =
                    '';
              },
              onChangeEvent: (value) {},
              searchValue:
                  _completedTripController.completedTripsSearchController.text,
              prefixIcon: const Icon(
                Icons.search,
                size: 14,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: pullRefresh,
                child: GetX<CompletedTripsController>(
                  builder: (_) {
                    if (_.loading.value) {
                      return const LoaderWidget();
                    } else {
                      if (_.completedTripList.isEmpty) {
                        return Center(
                          child: Text(
                            'no_trips_label'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black26),
                          ),
                        );
                      } else {
                        return AnimatedList(
                          key: _listKey,
                          initialItemCount: _.completedTripList.length,
                          itemBuilder: (context, index, animation) {
                            Trip trip = _.completedTripList[index];
                            return SlideTransition(
                              position: CurvedAnimation(
                                      curve: Curves.easeOut, parent: animation)
                                  .drive(
                                Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: const Offset(0, 0),
                                ),
                              ),
                              child: TripCard(trip: trip),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
