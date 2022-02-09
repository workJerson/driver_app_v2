import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTripsController extends GetxController {
  final newTripList = <Trip>[].obs;
  TextEditingController newTripsSearchController = TextEditingController();
  RxBool loading = false.obs;
  final ITrip tripService = TripService();

  @override
  void onInit() {
    getTripList();
    super.onInit();
  }

  void getTripList() {
    setLoading();
    tripService
        .getTripByStatus(
          driverId:
              Get.find<DriverController>().driver.value.driverId.toString(),
          status: 'NEW',
        )
        .then((value) => {setTripList(value), setLoading()})
        .catchError(
      (error) {
        setLoading();
        Get.snackbar(
          'error_snackbar_title'.tr,
          error.toString(),
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          duration: const Duration(
            seconds: 4,
          ),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
        );
      },
    );
  }

  void setTripList(List<Trip> value) {
    newTripList.value = value;
    update();
  }

  void setLoading() {
    loading.toggle();
  }
}