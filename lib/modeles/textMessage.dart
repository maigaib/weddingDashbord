// //import 'package:app_wedding_yours/pages/messages.dart';
// import 'package:flutter/material.dart';
// //import 'package:google_fonts/google_fonts.dart';
// class TextMessage extends StatelessWidget {
//   final String message, date, senderProfile;
//   final int isReceiver, isDirect;

//   const TextMessage({
//     Key? key,
//     required this.message,
//     required this.date,
//     required this.senderProfile,
//     required this.isReceiver,
//     required this.isDirect,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         children: [
//           isReceiver == 1 && isDirect == 0
//               ? Container(
//                   margin: const EdgeInsets.only(right: 15),
//                   width: 45,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage(senderProfile),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 )
//               : SizedBox(
//                   width: 60,
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.check,
//                         color: dPink,
//                         size: 13.0,
//                       ),
//                       const SizedBox(width: 7.0),
//                       Text(
//                         date,
//                         style: GoogleFonts.inter(
//                           color: dPink,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//           Expanded(
//             child: Container(
//               alignment: Alignment.centerLeft,
//               margin: isReceiver == 1
//                   ? const EdgeInsets.only(
//                       right: 25,
//                     )
//                   : const EdgeInsets.only(
//                       left: 20,
//                     ),
//               padding: const EdgeInsets.all(6),
//               height: 55,
//               decoration: isReceiver == 1
//                   ? const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(12),
//                         topRight: Radius.circular(12),
//                         bottomLeft: Radius.circular(12),
//                       ),
//                     )
//                   : const BoxDecoration(
//                       color: dPink,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                         bottomRight: Radius.circular(15),
//                       ),
//                     ),
//               child: Text(
//                 message,
//                 style: GoogleFonts.inter(
//                   color: isReceiver == 1 ? dPink : Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//           isReceiver == 1 && isDirect == 0
//               ? SizedBox(
//                   width: 60,
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.check,
//                         color: dPink,
//                         size: 13.0,
//                       ),
//                       const SizedBox(
//                         width: 7.0,
//                       ),
//                       Text(
//                         date,
//                         style: GoogleFonts.inter(
//                           color: dPink,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : Container(),
//           isDirect == 0 && isReceiver == 0
//               ? Container(
//                   margin: const EdgeInsets.only(
//                     left: 16,
//                     right: 10,
//                   ),
//                   width: 45,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage(senderProfile),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 )
//               : Container(),
//           isReceiver == 0 && isDirect == 1
//               ? Container(
//                   margin: const EdgeInsets.only(
//                     left: 16,
//                     right: 10,
//                   ),
//                   width: 45,
//                   height: 45,
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }