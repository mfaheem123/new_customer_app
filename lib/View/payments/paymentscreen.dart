import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/payment/paymentcontroller.dart';
import '../Widgets/all_text.dart';
import '../Widgets/color.dart';
import '../Widgets/elevat_button.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: CustomColor.background,
       body: Container(
         height:MediaQuery.of(context).size.height,
         width:MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [
               Color.fromARGB(255, 30, 1, 44),
               Color.fromARGB(255, 227, 194, 242)
             ],
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
           ),
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             // ---------- Heading ----------
              Text(
               CustomText.Payments,
               style: AppTextStyles.heading(),
             ),
              SizedBox(height: 15),

              Text(
               CustomText.Payments_Method_Choose,
               style: AppTextStyles.medium(),
             ),

              SizedBox(height: 40),

             // ========================================        Payment Options
             Obx(() => Column(
               children: [
                 buildPaymentOption(
                     icon: Icons.attach_money,
                     Select_Payment: "Cash",
                     index: 0),
                  SizedBox(height: 15),
                 buildPaymentOption(
                     icon: Icons.account_balance,
                     Select_Payment: "Account",
                     index: 1),
                  SizedBox(height: 15),
                 buildPaymentOption(
                     icon: Icons.credit_card,
                     Select_Payment: "Credit Card",
                     index: 2),
               ],
             )),

              SizedBox(height: 40),

             // ---------- Info Text ----------
              Padding(
               padding: EdgeInsets.symmetric(horizontal: 20),
               child: Text(
                 CustomText.Payments_Text,
                 textAlign: TextAlign.center,
                 style: AppTextStyles.regular(),
               ),
             ),

              SizedBox(height: 40),

             // ---------- Done Button ----------

             SizedBox(
               height: 55,
               width: 250  ,
               child: MyElevatedButton(
                 text: 'Done',
                 textWidget: FittedBox(
                   child: Text("Done",style: AppTextStyles.medium(size: 25,weight: FontWeight.bold),),
                 ),
                 onPressed: () {
                   Get.toNamed("/SigIn_Screen");
                 },

                 fontSize: 20,
               ),
             )

           ],
         ),
       ),

    );
  }

  // ---------- Custom Widget ----------
  Widget buildPaymentOption({
    required IconData icon,
    required String Select_Payment,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => controller.selectMethod(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: controller.selectedMethod.value == index
              ?CustomColor.Container_Colors.withOpacity(0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: controller.selectedMethod.value == index
                ? CustomColor.Button_background_Color
                : Colors.grey.withOpacity(0.75),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: CustomColor.Icon_Color, size: 26),
            const SizedBox(width: 10),
            Text(
              Select_Payment,
              style: AppTextStyles.medium(),
            ),
           
          ],
        ),
      ),
    );
  }
}
