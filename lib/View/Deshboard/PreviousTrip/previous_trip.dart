// import 'package:customer/View/Widgets/color.dart';
// import 'package:customer/View/Widgets/textformfield.dart';
// import 'package:flutter/material.dart';
//
// class PreviousTrip_Screen extends StatefulWidget {
//   const PreviousTrip_Screen({super.key});
//
//   @override
//   State<PreviousTrip_Screen> createState() => _PreviousTrip_ScreenState();
// }
//
// class _PreviousTrip_ScreenState extends State<PreviousTrip_Screen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<String> _items = [];
//
//   int? _editingIndex;
//
//   void _addOrUpdateItem() {
//     if (_controller.text.isNotEmpty) {
//       setState(() {
//         if (_editingIndex == null) {
//           // add mode
//           _items.add(_controller.text);
//         } else {
//           // edit mode
//           _items[_editingIndex!] = _controller.text;
//           _editingIndex = null;
//         }
//         _controller.clear();
//       });
//     }
//   }
//
//   void _editItem(int index) {
//     setState(() {
//       _controller.text = _items[index];
//       _editingIndex = index;
//     });
//   }
//
//   void _deleteItem(int index) {
//     setState(() {
//       _items.removeAt(index);
//       if (_editingIndex == index) {
//         _controller.clear();
//         _editingIndex = null;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColor.background,
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height / 3,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: CustomColor.textfield_fill,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       hintText: "Add Your Work Address",
//                       borderRadius: 15,
//                       fillColor: CustomColor.textfield_fill,
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _editingIndex == null ? Icons.add : Icons.save,
//                       color: Colors.white,
//                     ),
//                     onPressed: _addOrUpdateItem,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _items.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_items[index]),
//                   leading: const Icon(Icons.text_fields),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.edit, color: Colors.blue),
//                         onPressed: () => _editItem(index),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => _deleteItem(index),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
