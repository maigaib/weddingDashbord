// import 'package:app_wedding_yours/pages/messages.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// class ImageMessage extends StatelessWidget {
//   final String image, date, description;

//   const ImageMessage({
//     Key? key,
//     required this.image,
//     required this.date,
//     required this.description,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           margin: const EdgeInsets.only(
//             right: 16,
//           ),
//           width: 45,
//           height: 45,
//         ),
//         Expanded(
//           child: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(
//                   right: 26,
//                   top: 5,
//                 ),
//                 height: 150,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(image),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(22.0),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(
//                   top: 8,
//                   right: 25,
//                   bottom: 10,
//                 ),
//                 padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
//                 height: 55,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(12)),
//                 ),
//                 child: Wrap(children: [
//                   Text(
//                     description,
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.inter(
//                       color: dPink,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ]),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           width: 60,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               const Icon(
//                 Icons.check,
//                 color: dPink,
//                 size: 13.0,
//               ),
//               const SizedBox(width: 7.0),
//               Text(
//                 "17:14",
//                 style: GoogleFonts.inter(
//                   color: dPink,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }