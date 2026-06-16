import 'package:customer/Controller/Deshboard/deshboard_cont.dart';
import 'package:customer/Controller/Home/home-controller.dart';
import 'package:get/get.dart';
import '../Controller/Ride/RideController.dart';
import '../View/profile/controller/profile_controller.dart';



class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeshBoardAddHome_Controller());
  }
}

class SwapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SwapController());
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(profileModelController(), permanent: true);
  }
}

class RideBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RideController(), permanent: true);
  }
}


// class SingUpBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => SignUp_Controller());
//   }
// }

// class DeshboardBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => DeshBoardAddHome_Controller());
//   }
// }
//
// class swapController  extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => SwapController());
//   }
// }
//
// class InitialBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(profileModelController(), permanent: true);
//   }
// }
//
// class RideController extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(RideController(), permanent: true);
//   }

