import 'package:customer/Routing/routes_name.dart';
import 'package:get/get.dart';
import '../Binding/auth_binding.dart';
import '../View/Auth/Login_screens/forget_password.dart';
import '../View/Auth/Login_screens/forget_password_otp.dart';
import '../View/Auth/Sign_Up_Screen/signup_otpo_password.dart';
import '../View/Auth/Login_screens/login.dart';
import '../View/Auth/Login_screens/reset_Password.dart';
import '../View/Auth/Sign_Up_Screen/sign_up.dart';
import '../View/Auth/splash_Screen/spalsh.dart';
import '../View/Auth/trems.dart';
import '../View/Deshboard/dashboard.dart';
import '../View/Deshboard/pickup/pickup.dart';
import '../View/Reebook/Reebookingscreen.dart';
import '../View/Reebook/extras.dart';
import '../View/Reebook/promoscreen.dart';
import '../View/about/aboutscreen.dart';
import '../View/chatscreen.dart';
import '../View/payments/paymentscreen.dart';
import '../View/profile/profilescreen.dart';
import '../View/rides/DriverDetailscreen.dart';
import '../View/rides/ride_info_screen.dart';
import '../View/rides/ridecomplete.dart';
import '../View/rides/ridesearchscreen.dart';
import '../View/thanks/thanksscreen.dart';
import '../View/yourtrip/tripdetail.dart';
import '../View/yourtrip/yourtrip.dart';

class AppRoutes{

  static appRoutes()=>[


    GetPage(
      name: routesName.Splash_Screen,
      page: () =>Splash_Screen(),
      // binding: Splash_Screen(),
    ),
    GetPage(
      name: routesName.ResetPasswordScreen,
      page: () =>ResetPasswordScreen(),
      // binding: Splash_Screen(),
    ),
    // GetPage(
    //   name: routesName.chatScreen,
    //   page: () => ChatScreen(),
    //   // binding: Splash_Screen(),
    // ),
    //

    GetPage(
      name: routesName.SignupOtpoPassword,
      page: () => SignupOtpoPassword(),
    ),




      GetPage(
      name: routesName.ForgetPasswordOtp,
      page: () => ForgetPasswordOtp(),
    ),



    GetPage(
      name: routesName.ForgotPassword,
      page: () =>forgotPassword(),
      // binding: Splash_Screen(),
    ),
    GetPage(
      name: routesName.TermsAndConditionsScreen,
      page: () => TermsAndConditionsScreen(),
      // binding: Splash_Screen(),
    ),
    GetPage(
      name: routesName.ProfileScreen,
      page: () =>ProfileScreen(),
      // binding: ProfileScreen(),
    ),
    GetPage(
      name: routesName.SigUp_Screen,
      page: () => SigUp_Screen(),
     // binding: SingUpBinding(),
    ),
    GetPage(
      name: routesName.SigIn_Screen,
      page: () => SigIn_Screen(),
    //  binding: SingUpBinding(),
    ),
    GetPage(
        name: routesName.DeshBoard_Screen,
      page: () => DeshBoard_Screen(),
      // binding: DeshboardBinding(),
    ),
    GetPage(
      name: routesName.AboutScreen,
      page: () => Aboutscreen(),
      //binding: Aboutscreen(),
    ),
    GetPage(
      name: routesName.Yourtrip,
      page: () => Yourtrip(),
      //binding: Yourtrip(),
    ),
    GetPage(
      name: routesName.TripDetail,
      page: () => TripDetail(),
      //binding: TripDetail(),
    ),GetPage(
      name: routesName.PickupScreen,
      page: () => PickupScreen(),
      //binding: PickupScreen(),
    ),
    GetPage(
      name: routesName.RideInfoScreen,
      page: () => RideInfoScreen(),
      //binding: RideInfoScreen(),
    ),
    GetPage(
      name: routesName.RideSearchScreen,
      page: () => RideSearchScreen(),
      //binding: RideSearchScreen(),
    ),

    GetPage(
      name: routesName.PaymentScreen,
      page: () => PaymentScreen(),
      //binding: PaymentScreen(),
    ),
    GetPage(
      name: routesName.PromoScreen,
      page: () => PromoScreen(),
      //binding: PromoScreen(),
    ),

    GetPage(
      name: routesName.ReebookingScreen,
      page: () => ReebookingScreen(),
      //binding: ReebookingScreen(),
    ),
    GetPage(
      name: routesName.ExtrasScreen,
      page: () => ExtrasScreen(),
      //binding: PaymentReschedule(),
    ),
    GetPage(
      name: routesName.ThanksScreen ,
      page: () => ThanksScreen(),
      //binding: PaymentReschedule(),
    ),
    GetPage(
      name: routesName.RideCompleteScreen ,
      page: () => RideCompleteScreen(),
      //binding: PaymentReschedule(),
    ),
    GetPage(
      name: routesName.Driverdetailscreen ,
      page: () => Driverdetailscreen(),
      //binding: PaymentReschedule(),
    ),



  ];
}