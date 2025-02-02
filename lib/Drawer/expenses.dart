
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:logistics/NewReUseableWidgets/topSnackBar.dart';
import 'package:logistics/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';



class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key key}) : super(key: key);

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  
  List<Map<String, dynamic>> _expenses = [];
  final List<Map<String, dynamic>> _expenseFields = [
    {'amountController': TextEditingController(), 'remarksController': TextEditingController(), 'image': null, 'title': null},
  ];
  final _imagePicker = ImagePicker();
  List<String> _expenseTitles = [];
  String _selectedTitle;

  @override
  void initState() {
    super.initState();
    _fetchExpenseTitles();
  }

  Future<void> _fetchExpenseTitles() async {
  try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      if (token == null) {
        throw Exception('No token found in SharedPreferences');
      }

      Dio dio = Dio();
      dio.options.headers = {'Authorization': 'Bearer $token'};

      Response response = await dio.get(
        'https://dashlogistics.dev/api/v1/employee/expenses/title',
       );
    print('Titles response: ${response.data}');

    setState(() {
     // _expenseTitles = List<String>.from(response.data['titles']); // Adjust based on API response
     _expenseTitles = (response.data['data'] as Map<String, dynamic>).values.cast<String>().toList();

    });
  } catch (e) {
    print('Error fetching titles: $e');
  }
}

Future<void> _fetchExpenses() async {
  try {

      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      if (token == null) {
        throw Exception('No token found in SharedPreferences');
      }

      Dio dio = Dio();
      dio.options.headers = {'Authorization': 'Bearer $token'};
    
    final response = await dio.get('https://dashlogistics.dev/api/v1/employee/expenses');
    print('Expenses response: ${response.data}');

    setState(() {
     // _expenses = List<Map<String, dynamic>>.from(response.data['expenses']); // Adjust based on API response
     _expenses = List<Map<String, dynamic>>.from(response.data['expenses']);

    });
  } catch (e) {
    print('Error fetching expenses: $e');
  }
}


  void _pickImage(ImageSource source, int index) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _expenseFields[index]['image'] = File(pickedFile.path);
      });
    }
  }

  void _addExpenseField() {
    setState(() {
      _expenseFields.add({
        'amountController': TextEditingController(),
        'remarksController': TextEditingController(),
        'image': null,
        'title': null,
      });
    });
  }



Future<void> _submitExpenses() async {
 bool _isLoading = true;
  setState(() {
    _isLoading = true; // Show loader
  });
  try {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null) {
      throw Exception('No token found in SharedPreferences');
    }

    Dio dio = Dio();
    dio.options.headers = {'Authorization': 'Bearer $token'};

    for (var expenseField in _expenseFields) {
      final amount = double.tryParse(expenseField['amountController']?.text ?? '');
      final remarks = expenseField['remarksController']?.text;
      // Ensure title is treated as a String
      final title = expenseField['title']?.toString().replaceAll(' ', '').replaceFirstMapped(RegExp(r'^[A-Z]'), (match) => match.group(0).toLowerCase());
      final image = expenseField['image'];

      // Skip fields with invalid data
      if (amount == null || amount <= 0 || title == null || title.isEmpty || remarks == null || remarks.isEmpty) {
        print("Skipping invalid expense: amount=$amount, title=$title, remarks=$remarks");
        continue;
      }

      // Construct the FormData
      final formData = FormData.fromMap({
        "expensesTitle": title,
        "amount": amount.toString(),
        "remarks": remarks,
        if (image != null) "image": await MultipartFile.fromFile(image.path),
      });

      // Print the body being sent
      print("POST Body:");
      print({
        "expensesTitle": title,
        "amount": amount.toString(),
        "remarks": remarks,
        "image": image != null ? "File: ${image.path}" : null,
        "titleType": title.runtimeType.toString(), // Print the data type of title
      });

      // Send the POST request
      final response = await dio.post(
        'https://dashlogistics.dev/api/v1/employee/expenses',
        data: formData,
      );

      // Print the response
      print("Response: ${response.statusCode} - ${response.data}");
    }
TopSnackBar.showSuccess(
      context,
      'Expenses submitted successfully',
    
    );
    // Reset expense fields after successful submission
    _expenseFields.clear();
    _addExpenseField();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExpensesHistoryScreen()),
    );
  } catch (e) {
    if (e is DioException && e.response != null) {
      print('Error response: ${e.response?.data}');
      TopSnackBar.show(
        context,
        'Error submitting expenses',
      );
    }
    print('Error submitting expenses: $e');
  } finally {
    setState(() {
      _isLoading = false; // Hide loader
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add Expenses', style: TextStyle(color: Colors.red)),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExpensesHistoryScreen()),
              );
            },
            child: const Text(
              'History    ',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _expenseFields.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButtonFormField<String>(
                            value: _expenseFields[index]['title'],
                            items: _expenseTitles
                                .map((title) => DropdownMenuItem(
                                      value: title,
                                      child: Text(title),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _expenseFields[index]['title'] = value;
                              });
                            },
                            decoration: const InputDecoration(labelText: 'Title'),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _expenseFields[index]['amountController'],
                            decoration: const InputDecoration(labelText: 'Amount'),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _expenseFields[index]['remarksController'],
                            decoration: const InputDecoration(labelText: 'Remarks'),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _pickImage(ImageSource.camera, index),
                                icon: const Icon(Icons.camera_alt, color: Colors.white),
                                label: const Text('Capture', style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _pickImage(ImageSource.gallery, index),
                                icon: const Icon(Icons.image),
                                label: const Text('Select'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              ),
                              // if (_expenseFields[index]['image'] != null)
                              //   IconButton(
                              //     icon: const Icon(Icons.image_search),
                              //     onPressed: () {
                              //       showDialog(
                              //         context: context,
                              //         builder: (_) => Dialog(
                              //           child: Image.file(_expenseFields[index]['image']),
                              //         ),
                              //       );
                              //     },
                              //   ),


                              if (_expenseFields[index]['image'] != null)
  IconButton(
    icon: const Icon(Icons.image_search),
    onPressed: () {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(8.0),
            minScale: 0.5,
            maxScale: 4.0,
            child: Image.file(_expenseFields[index]['image']),
          ),
        ),
      );
    },
  ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(12.0),child: ElevatedButton(
            onPressed: _submitExpenses,
            child: const Text('Submit', style: TextStyle(fontSize: 24)), // Increased text size
         
             style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize:
                    Size(double.infinity, 50), // Full width and fixed height
              ),
            ),),
            
        ],
      ),
    );
  }
}

class ExpensesHistoryScreen extends StatefulWidget {
  const ExpensesHistoryScreen({Key key}) : super(key: key);

  @override
  _ExpensesHistoryScreenState createState() => _ExpensesHistoryScreenState();
}

class _ExpensesHistoryScreenState extends State<ExpensesHistoryScreen> {
  List<dynamic> _expenses = [];
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }




  Future<void> _fetchExpenses() async {
    _isLoading=true;
  setState(() {
    _isLoading = true; // Show loader
  });
  try {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null) {
      throw Exception('No token found in SharedPreferences');
    }

    Dio dio = Dio();
    dio.options.headers = {'Authorization': 'Bearer $token'};

    // Fetch expenses from the API
    final response = await dio.get('https://dashlogistics.dev/api/v1/employee/expenses');

    print('Expenses response: ${response.data}');

    // Extract and process data
    if (response.data != null && response.data['data'] != null) {
      final data = response.data['data'];

      // Check if data is a List or a single Map
      if (data is List) {
        setState(() {
          _expenses = List<Map<String, dynamic>>.from(data);
        });
      } else if (data is Map) {
        setState(() {
          _expenses = [data]; // Wrap the map in a list
        });
      } else {
        print("Unexpected data format: ${data.runtimeType}");
      }
    } else {
      print('Invalid or empty response from API.');
    }
  } catch (e) {
    print('Error fetching expenses: $e');
  } finally {
    setState(() {
      _isLoading = false; // Hide loader
    });
  }
}


  Future<void> _deleteExpense(int id) async {
    try {
  final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      if (token == null) {
        throw Exception('No token found in SharedPreferences');
      }

      Dio dio = Dio();
      dio.options.headers = {'Authorization': 'Bearer $token'};
      await dio.delete('https://dashlogistics.dev/api/v1/employee/expenses/$id');
      _fetchExpenses();
    } catch (e) {
      print('Error deleting expense: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Expenses History', style: TextStyle(color: Colors.red)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _expenses.isEmpty
          ? const Center(child: Text('No expenses added yet.'))
          :ListView.builder(
  itemCount: _expenses.length,
  itemBuilder: (context, index) {
    final expense = _expenses[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 6.0,
        shadowColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          leading: expense['image'] != null
            ? GestureDetector(
              onTap: () {
                showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(8.0),
                  minScale: 0.5,
                  maxScale: 4.0,
                 // child: Image.file(File(expense['image'])),
             child: Image.network(
            expense['image'] ,
            height: 400, // Larger height for clear view
            width: 800,  // Larger width for clear view
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.broken_image,
              size: 100,
              color: Colors.grey,
            ),
          ),
                  ),
                ),
                );
              },
              child: 
              // CircleAvatar(
              //   backgroundImage: FileImage(File(expense['image'])),
              // ),
              CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Icon(Icons.image, color: Colors.blue.shade600),
              ),
              
              )
            :  CircleAvatar(
               // backgroundImage: FileImage(File(expense['image'])),
               backgroundColor: MyColors.grey,
              ),
          title: Text(
            expense['expensesTitle'],
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4.0),
              Text(
                expense['remarks'] ?? 'No remarks provided',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14.0),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Amount: ${expense['amount'] ?? ''}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.orange,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Do you want to delete this expense?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _deleteExpense(expense['id']);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  },
),

    );
  }
}
