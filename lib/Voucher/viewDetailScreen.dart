import 'package:flutter/material.dart';

class VoucherDetailScreen extends StatelessWidget {
  final Map<String, dynamic> response;

  const VoucherDetailScreen({Key key, this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Log the response for debugging
    print('Response received: $response');

    return Scaffold(
          appBar: AppBar(
        title: const Text(
          'Voucher Details',
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                        children: const [
                          Icon(Icons.calendar_today, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                          'Date:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                        ),
                        Text(
                        response['createdAt'] ?? 'N/A',
                       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                        children: [
                          
                          Image.asset(
                          'assets/images/nepRs.png',
                          height: 15,
                          width: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                          'Payment:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                        ),
                      Text(
                        '\Rs ${response['voucherPayment']?.toString() ?? 'N/A'}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ],
                    ),
                  ),
          
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                        children: const [
                        Icon(Icons.note, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Note:',
                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        ],
                      ),
                      Text(
                        response['voucherNote'] ?? 'N/A',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ],
                    ),
                    ),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                        children: const [
                          Icon(Icons.info, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                          'Status:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                        ),
                      Text(
                        response['voucherStatus'] ?? 'Pending',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ],
                    ),
                    ),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                      Icon(Icons.image, color: Colors.red),
                      SizedBox(width: 8),
                        Text(
                        'Voucher Image',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                    ),
                  if (response['voucherImage'] != null)
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Center(
    child: GestureDetector(
      // onTap: () {
      //   // Show the image in a larger view when tapped
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return Dialog(
      //         child: Image.network(
      //           response['voucherImage'],
      //           height: 400,  // Larger height for clear view
      //           width: 800,   // Larger width for clear view
      //           errorBuilder: (context, error, stackTrace) => const Icon(
      //             Icons.broken_image,
      //             size: 100,
      //             color: Colors.grey,
      //           ),
      //         ),
      //       );
      //     },
      //   );
      // },

      onTap: () {
  // Show the image in a larger view when tapped
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: InteractiveViewer(
          panEnabled: true, // Enable panning
          minScale: 1.0, // Minimum zoom scale
          maxScale: 5.0, // Maximum zoom scale
          child: Image.network(
            response['voucherImage'],
            height: 400, // Larger height for clear view
            width: 800,  // Larger width for clear view
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.broken_image,
              size: 100,
              color: Colors.grey,
            ),
          ),
        ),
      );
    },
  );
},

      child: Image.network(
  response['voucherImage'],
  height: 165,  // Decreased height
  width: 1200,  // Increased width
  errorBuilder: (context, error, stackTrace) => const Icon(
    Icons.broken_image,
    size: 100,
    color: Colors.grey,
  ),
),

    ),
  ),
)


                ],
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
