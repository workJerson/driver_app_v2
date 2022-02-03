import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTripsScreen extends StatefulWidget {
  const AllTripsScreen({Key? key}) : super(key: key);

  @override
  _AllTripsScreenState createState() => _AllTripsScreenState();
}

class _AllTripsScreenState extends State<AllTripsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AllTripsController _allTripController = Get.find();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'all_trip_label'.tr,
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
        height: size.height - 100,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            SearchField(
              controller: _allTripController.allTripsSearchController,
              hint: 'search_trip_input_label'.tr,
              clearEvent: () {
                _allTripController.allTripsSearchController.text = '';
              },
              onChangeEvent: (value) {},
              searchValue: _allTripController.allTripsSearchController.text,
              prefixIcon: const Icon(
                Icons.search,
                size: 14,
              ),
            ),
            Expanded(
              child: GetX<AllTripsController>(
                builder: (_) {
                  if (_.tripList.isEmpty) {
                    return const LoaderWidget();
                  } else {
                    return AnimatedList(
                      key: _listKey,
                      initialItemCount: _.tripList.length,
                      itemBuilder: (context, index, animation) {
                        Trip trip = _.tripList[index];
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
