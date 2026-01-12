// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Controller/payment/paymentcontroller.dart';
// import '../Widgets/color.dart';
// import '../textstyle/apptextstyle.dart';
//
// class Buildpaymentoption extends StatelessWidget {
//   final IconData icon;
//   final String Select_Payment;
//   final int index;
//
//   final PaymentController controller = Get.find();
//
//   Buildpaymentoption({
//     super.key,
//     required this.icon,
//     required this.Select_Payment,
//     required this.index,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Obx ko widget ke andar lagaya hai
//     return Obx(() {
//       bool isSelected = controller.selectedMethod.value == index;
//
//       return GestureDetector(
//         onTap: () => controller.selectMethod(index),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
//           margin: const EdgeInsets.symmetric(horizontal: 40),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? CustomColor.Container_Colors.withOpacity(0.4)
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: isSelected
//                   ? CustomColor.Button_background_Color
//                   : Colors.grey.withOpacity(0.75),
//               width: 2,
//             ),
//           ),
//           child: Row(
//             children: [
//               Icon(icon, color: CustomColor.Icon_Color, size: 26),
//               const SizedBox(width: 10),
//               Text(
//                 Select_Payment,
//                 style: AppTextStyles.medium(),
//               ),
//               const Spacer(),
//               Container(
//                 height: 22,
//                 width: 22,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2),
//                   color: isSelected ? Colors.white : Colors.transparent,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
