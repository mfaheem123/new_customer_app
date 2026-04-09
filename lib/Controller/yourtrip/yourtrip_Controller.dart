import 'package:get/get.dart';
import '../../View/yourtrip/booking_history_model/bookingHistorymodel.dart';
import '../../View/yourtrip/booking_history_model/bookingScheduleModel.dart';
import '../../api_servies/api_servies.dart';
import '../../api_servies/session.dart';

class YourTripController extends GetxController{

  RxInt selectedIndex = (0).obs;

  void ChangeIndex(int index) {
    selectedIndex.value = index;

    if (index == 0) {
      getBookingScheduleApi(); // 📅 schedule tab
    } else if (index == 1) {
      getBookingHistoryApi(); // 📜 history tab
    }
  }
  BookingHistoryModel? bookingHistoryModel;
  bool loading = false;

  Future<void> getBookingHistoryApi() async {
    loading = true;
    update();

    var response = await ApiService.get(
        "bookings/customer-bookings/${TokenManager.userId}",
        auth: true,
        isProgressShow: false
    );

    if (response != null && response.statusCode == 200) {

      bookingHistoryModel =BookingHistoryModel.fromJson(response.data);
      print(response.data);
    }

    loading = false;
    update();
  }



  ///=====================================================  booking schedule

  BookingScheduleModel? bookingScheduleModel;
  bool scheduleLoading = false;

  Future<void> getBookingScheduleApi() async {
    scheduleLoading = true;
    update();

    var response = await ApiService.get(
        "bookings/customer-schedule/${TokenManager.userId}",
        auth: true,
        isProgressShow: false
    );

    if (response != null && response.statusCode == 200) {

      bookingScheduleModel =BookingScheduleModel.fromJson(response.data);
      print(response.data);
    }

    scheduleLoading = false;
    update();
  }
}

