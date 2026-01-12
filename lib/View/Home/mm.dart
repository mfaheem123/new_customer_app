// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SwapController extends GetxController {
//   // TextEditingControllers ko observable rakhne ki zarurat nahi
//   final firstController = TextEditingController();
//   final secondController = TextEditingController();

//   void swapValues() {
//     final temp = firstController.text;
//     firstController.text = secondController.text;
//     secondController.text = temp;
//   }

//   @override
//   void onClose() {
//     firstController.dispose();
//     secondController.dispose();
//     super.onClose();
//   }
// }

// class SwapTextFields extends StatelessWidget {
//   const SwapTextFields({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SwapController());

//     return Scaffold(
//       appBar: AppBar(title: const Text("Swap TextFields Example (GetX)")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: controller.firstController,
//               decoration: InputDecoration(
//                 labelText: "First Field",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Swap Icon Button
//             IconButton(
//               onPressed: controller.swapValues,
//               icon: const Icon(Icons.swap_vert, size: 32, color: Colors.blue),
//             ),

//             const SizedBox(height: 12),

//             TextField(
//               controller: controller.secondController,
//               decoration: InputDecoration(
//                 labelText: "Second Field",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
