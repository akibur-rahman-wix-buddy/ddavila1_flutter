// import 'package:flutter/material.dart';
//
// class DropdownModal extends StatefulWidget {
//   final List<String> options;
//   final TextEditingController controller;
//   final String title;
//   final String buttonText;
//   final Color buttonColor;
//
//   const DropdownModal({
//     Key? key,
//     required this.options,
//     required this.controller,
//     required this.title,
//     required this.buttonText,
//     required this.buttonColor,
//   }) : super(key: key);
//
//   @override
//   _DropdownModalState createState() => _DropdownModalState();
// }
//
// class _DropdownModalState extends State<DropdownModal> {
//   String _selectedOption = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedOption = widget.controller.text; // আগের সিলেক্ট করা অপশন সেট করুন
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         height: 415,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               widget.title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const Divider(color: Colors.grey),
//             Column(
//               children: widget.options.map((option) {
//                 return RadioListTile<String>(
//                   title: Text(
//                     option,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   value: option,
//                   groupValue: _selectedOption,
//                   activeColor: Colors.cyan,
//                   onChanged: (String? value) {
//                     setState(() {
//                       _selectedOption = value!;
//                       widget.controller.text = value;
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 50),
//             ElevatedButton(
//               onPressed: () {
//                 widget.controller.text = _selectedOption;
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: widget.buttonColor,
//                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//               ),
//               child: Text(
//                 widget.buttonText,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
