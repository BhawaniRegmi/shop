// import 'package:flutter/material.dart';

// class TopSnackBar {
//   static void show(BuildContext context, String message, {Duration duration = const Duration(seconds: 3)}) {
//     final overlay = Overlay.of(context);
//      OverlayEntry overlayEntry;

//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 85.6,
//         left: 0,
//         right: 0,
//         child: Material(
//           elevation: 10,
//           child: Container(
//             padding: const EdgeInsets.all(16.0),
//             color: Colors.red,
//             child: Text(
//               message,
//               style: const TextStyle(color: Colors.white, fontSize: 18),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);
    
//     Future.delayed(duration, () {
//       overlayEntry.remove();
//     });
//   }


//    static void _showTopSnackBarSucess(BuildContext context, String message) {
//     final overlay = Overlay.of(context);
//     OverlayEntry overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 85.6, // Position at the top
//         left: 0,
//         right: 0,
//         child: Material(
//           elevation: 10,
//           child: Container(
//             padding: EdgeInsets.all(16.0),
//             color: Colors.blue,
//             child: Text(
//               message,
//               style: TextStyle(color: Colors.white, fontSize: 18),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);
    
//     // Automatically remove the SnackBar after a delay
//     Future.delayed(Duration(seconds: 3), () {
//       overlayEntry.remove();
//     });
//   }
// }


import 'package:flutter/material.dart';

class TopSnackBar {
  static void show(BuildContext context, String message, {Color backgroundColor = Colors.red, Duration duration = const Duration(seconds: 3)}) {
    final overlay = Overlay.of(context);
     OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 85.6,
        left: 0,
        right: 0,
        child: Material(
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: backgroundColor,
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  static void showSuccess(BuildContext context, String message, {Duration duration = const Duration(seconds: 3)}) {
    show(context, message, backgroundColor: Colors.blue, duration: duration);
  }
}
