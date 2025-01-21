// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/api/DetailApi.dart';
// import 'package:logistics/newChange/weightTextField.dart';
// import 'package:logistics/packagedetailpage/detail_presenter.dart';
//  import 'package:logistics/response/PackageDetailM.dart';
// import 'package:logistics/utils/color.dart';

// // import '../response/PackageDetailM.dart';

// class StatusChangePopUp extends StatelessWidget {

//   final String buttonText;
//  final String finalPackageWeight;
//   final VoidCallback onTrackNextTap;
//   final VoidCallback onCancelTap;
//   final VoidCallback onDetailTap;
//   final String currentStatus;
//   final String newStatus;
//   PackageDetailM detail=PackageDetailM();

// //PackageDetailM detail=PackageDetailM() ;

//    StatusChangePopUp(
//       {Key key,
//       this.finalPackageWeight,
//       this.buttonText,
//       this.currentStatus,
//       this.newStatus,
//       @required this.onTrackNextTap,
//       @required this.onDetailTap,
//       @required this.onCancelTap})
//       : super(key: key);

//     WeightInputDialog newweightobj=WeightInputDialog();

//   @override
//   Widget build(BuildContext context) {
//     TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return new AlertDialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(14.0))),
//       insetPadding: EdgeInsets.all(16),
//       contentPadding: EdgeInsets.fromLTRB(25, 38, 25, 38),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       content: SingleChildScrollView(
//         child: Container(
//           child: new Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
//                 child: Text(
//                   "Do you want to change the status from",
//                   style: TextStyle(
//                       fontFamily: "Roboto",
//                       fontWeight: FontWeight.w700,
//                       color: MyColors.ligtBlack,
//                       fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     height: 65,
//                     width: 72,
//                     margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                     child: Center(
//                         child: Text(
//                       currentStatus,
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w500,
//                           color: MyColors.ligtBlack,
//                           fontSize: 12),
//                       textAlign: TextAlign.center,
//                     )),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: MyColors.lightGrey,
//                     ),
//                   ),
//                   Center(
//                     child: Container(
//                       margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                       height: 65,
//                       width: 72,
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Image.asset("assets/images/middivider.png"),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 65,
//                     width: 72,
//                     margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                     child: Center(
//                         child: Text(
//                       newStatus,
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w500,
//                           color: MyColors.white,
//                           fontSize: 12),
//                       textAlign: TextAlign.center,
//                     )),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: MyColors.lightSky,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 13,),

//     if (newweightobj.newweight1 == "")
//     if(currentStatus=="Order Placed" )

//      Text(
//   '" Current Weight is ${finalPackageWeight} kg"',

//   style: TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//     color: Colors.blue,
//   ),
// )
//   else
//                          SizedBox(),
//    //if(newweightobj.newweight1=="")
//  if(currentStatus=="Order Placed")

//                       Container(
//                     width: 138,
//                     height: 48,
//                     margin: EdgeInsets.fromLTRB(0, 32, 8, 11),
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         backgroundColor: MyColors.blue,
//                       ),
//                       onPressed: () {
//                         // Navigate to a new screen
//                         Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => WeightInputDialog()),
//                         );

//                        print(finalPackageWeight);
//                        // finalPackageWeight=n
//                        // onDetailTap();
//                         //Navigator.of(context).pop();
//                       },
//                       child:
//                       Text(
//                         "Change Weight?",
//                        //currentStatus,
//                         style: TextStyle(
//                           color: MyColors.white,
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14.0,
//                         ),
//                       ),
//                     ),
//                   )
//                   else
// SizedBox(),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     width: 138,
//                     height: 48,
//                     margin: EdgeInsets.fromLTRB(0, 32, 8, 11),
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         backgroundColor: MyColors.blue,
//                       ),
//                       onPressed: () {
//                         onDetailTap();
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(
//                         "View details",
//                         style: TextStyle(
//                           color: MyColors.white,
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 138,
//                     height: 48,
//                     margin: EdgeInsets.fromLTRB(8, 32, 0, 11),
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         backgroundColor: MyColors.primaryColor,
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         onTrackNextTap();
//                       },
//                       child: Text(
//                         "OK",
//                         style: TextStyle(
//                           color: MyColors.white,
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14.0,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Container(
//                 width: 138,
//                 height: 48,
//                 alignment: Alignment.center,
//                 margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     backgroundColor: MyColors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     onCancelTap();
//                   },
//                   child: Text(
//                     "CANCEL SCAN",
//                     style: TextStyle(
//                       color: MyColors.darkOrange,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       actions: <Widget>[],
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics/api/DetailApi.dart';
import 'package:logistics/newChange/weightTextField.dart';
import 'package:logistics/packagedetailpage/detail_presenter.dart';
import 'package:logistics/response/PackageDetailM.dart';
import 'package:logistics/utils/color.dart';

// import '../response/PackageDetailM.dart';




class StatusChangePopUp extends StatefulWidget {
  final String buttonText;
  final String finalPackageWeight;
  final VoidCallback onTrackNextTap;
  final VoidCallback onCancelTap;
  final VoidCallback onDetailTap;
  final String currentStatus;
  final String newStatus;

  StatusChangePopUp(
      {Key key,
      this.finalPackageWeight,
      this.buttonText,
      this.currentStatus,
      this.newStatus,
      @required this.onTrackNextTap,
      @required this.onDetailTap,
      @required this.onCancelTap})
      : super(key: key);

  @override
  State<StatusChangePopUp> createState() => _StatusChangePopUpState();
}

class _StatusChangePopUpState extends State<StatusChangePopUp> {
  PackageDetailM detail = PackageDetailM();
    DropdownExample dropdownExample=DropdownExample();
    RescheduleDropdown rescheduleDropdown=RescheduleDropdown();

  WeightInputDialog newweightobj = WeightInputDialog();
// @override
// void initState() {
//   super.initState();
//   DropdownExample.value1=false;
//   DropdownExample.value2=false;

//   // Your initialization code here
// }



  func() {
    final List<String> items = [
      "Delay",
      "Product Damage",
      "customer not found"
    ];
    String selectedItem;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Dropdown button
        DropdownButton<String>(
          value: selectedItem, // Currently selected value
          hint: Text("Select"), // Placeholder text
          underline: SizedBox(), // Removes the underline
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String value) {
            setState(() {
              selectedItem = value; // Update selected item
            });
          },
        ),
        SizedBox(height: 20),
        // Display the chosen option
        Text(
          selectedItem != null
              ? "Selected: $selectedItem"
              : "No option selected",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return new AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0))),
      insetPadding: EdgeInsets.all(16),
      contentPadding: EdgeInsets.fromLTRB(25, 38, 25, 38),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: SingleChildScrollView(
        child: Container(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
                child: Text(
                  // "Do you want to change the status from",
                  "Do you want to change the status to from",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                      color: MyColors.ligtBlack,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 65,
                    width: 72,
                    margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Center(
                        child: Text(
                      widget.currentStatus,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: MyColors.ligtBlack,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColors.lightGrey,
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
                      height: 65,
                      width: 72,
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset("assets/images/middivider.png"),
                      ),
                    ),
                  ),
                  Container(
                    height: 65,
                    width: 72,
                    margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Center(
                        child: Text(
                      widget.newStatus,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: MyColors.white,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColors.lightSky,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 13,
              ),

              if (newweightobj.newweight1 == "")
                if (widget.currentStatus == "Order Placed")
                  Text(
                    '" Current Weight is ${widget.finalPackageWeight} kg"',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  )
                else
                  SizedBox(),
              //if(newweightobj.newweight1=="")
              if (widget.currentStatus == "Order Placed")
                Container(
                  width: 138,
                  height: 48,
                  margin: EdgeInsets.fromLTRB(0, 32, 8, 11),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: MyColors.blue,
                    ),
                    onPressed: () {
                      // Navigate to a new screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeightInputDialog()),
                      );

                      print(widget.finalPackageWeight);
                      // finalPackageWeight=n
                      // onDetailTap();
                      //Navigator.of(context).pop();
                    },
                    child: Text(
                      "Change Weight?",
                      //currentStatus,
                      style: TextStyle(
                        color: MyColors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),

              if (widget.newStatus == "Rescheduled")
                DropdownExample(),
                 if (widget.newStatus =="Cancelled")
                  RescheduleDropdown()

              else
                SizedBox(),
              // if (   DropdownExample.value2)
              //  if (   DropdownExample.value3==null)
              //   SizedBox(
              //     height: 15,
              //      child: Text("Please Select Rescheduled Reason"),
            
              //   ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 138,
                    height: 48,
                    margin: EdgeInsets.fromLTRB(0, 32, 8, 11),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: MyColors.blue,
                      ),
                      onPressed: () {
                        widget.onDetailTap();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "View details",
                        style: TextStyle(
                          color: MyColors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                   // width: 138,
                   width: 122,
                    height: 48,
                    margin: EdgeInsets.fromLTRB(8, 32, 0, 11),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: MyColors.primaryColor,
                      ),
                      onPressed: () {
                      
                        if(widget.newStatus == "Rescheduled" && dropdownExample.value1==false) {
                          setState(() {
                          //  dropdownExample.value2=true;
                          dropdownExample.value2=true;
                          });
                        }

                        else if(widget.newStatus == "Cancelled" && rescheduleDropdown.value1==false) {
                          setState(() {
                          //  dropdownExample.value2=true;
                          rescheduleDropdown.value2=true;
                          });
                        }

                        else    {
                          // dropdownExample.value1=false;
                          // DropdownExample.value2=false;
                          // DropdownExample.value3=null;
            
                          Navigator.of(context).pop();
                          widget.onTrackNextTap();

                          //         setState(() {
                          //  ResAlert();
                          //         });
                        }

                        // Navigator.of(context).pop();
                        // widget.onTrackNextTap();
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                          color: MyColors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                width: 138,
                height: 48,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: MyColors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onCancelTap();
                  },
                  child: Text(
                    "CANCEL SCAN",
                    style: TextStyle(
                      color: MyColors.darkOrange,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[],
    );
  }
}

// class DropdownExample extends StatefulWidget {
//   @override
//   _DropdownExampleState createState() => _DropdownExampleState();

//    static bool get value1 => _DropdownExampleState.valueA;
//    static bool get value2 => _DropdownExampleState.valueB; 
//       static String get value3 => _DropdownExampleState.selectedValue; 


//     // Static setter for global access
//   static set value2(bool newValue) {
//     _DropdownExampleState.valueA = newValue;
//   }
//      // Static setter for global access
//   static set value1(bool newValue) {
//     _DropdownExampleState.valueB = newValue;
//   }

//     // Static setter for global access
//   static set value3(String newValue) {
//     _DropdownExampleState.valueC = newValue;
//   }
// }

// class _DropdownExampleState extends State<DropdownExample> {

// @override
// void initState() {
//   // valueA=false;
//   // valueB=false;
//   // valueC=null;
//     // TODO: implement initState
//     super.initState();
//   }
  
// static  String selectedValue; // Holds the selected dropdown value
//  static bool valueA = false;
// static bool valueB = false;
// static String valueC ;

  
//    //  Setter
 

//   // Function to create a dropdown button
//   Widget buildDropdown() {
//     final List<String> options = [
//       "Delay",
//       "Product Damage",
//       "Customer not found",
//       "Product Lost"
//     ];
//     return DropdownButton<String>(
//       value: selectedValue,
//       hint: Text("Select Rescheduled Reason"), // Placeholder text
//       items: options.map((String option) {
//         return DropdownMenuItem<String>(
//           value: option,
//           child: Text(option),
//         );
//       }).toList(),
//       onChanged: (String newValue) {
//         setState(() {
//           selectedValue = newValue; // Update the selected value
//           valueA = true;
//           valueB=false;
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           buildDropdown(), // Call the dropdown function
//           SizedBox(height: 20),
//           Text(
//             selectedValue != null ? " $selectedValue" : "No Reason Selected",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//             Text(
//             selectedValue != null ? "" : "Please Select Rescheduled Reason",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }



class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() => _DropdownExampleState();

  // Getter methods to access instance variables
  bool get value1 => _state?.valueA ?? false;
  bool get value2 => _state?.valueB ?? false;
  String get value3 => _state?.selectedValue;

  // Setter methods to modify instance variables
  set value1(bool newValue) {
    _state?.updateValueA(newValue);
  }

  set value2(bool newValue) {
    _state?.updateValueB(newValue);
  }

  set value3(String newValue) {
    _state?.updateSelectedValue(newValue);
  }

  // Reference to the state
  static _DropdownExampleState _state;
}

class _DropdownExampleState extends State<DropdownExample> {
  // Instance variables for the widget state
  String selectedValue; // Nullable type
  bool valueA = false;
  bool valueB = false;

  @override
  void initState() {
    super.initState();
    // Link state to the widget
    DropdownExample._state = this;
  }

  @override
  void dispose() {
    // Unlink the state from the widget
    DropdownExample._state = null;
    super.dispose();
  }

  // Method to update valueA
  void updateValueA(bool newValue) {
    setState(() {
      valueA = newValue;
    });
  }

  // Method to update valueB
  void updateValueB(bool newValue) {
    setState(() {
      valueB = newValue;
    });
  }

  // Method to update selectedValue
  void updateSelectedValue(String newValue) {
    setState(() {
      selectedValue = newValue;
    });
  }

  // Dropdown builder
  Widget buildDropdown() {
    final List<String> options = [
      "Delay",
      "Product Damage",
      "Customer not found",
      "Product Lost"
    ];
    return DropdownButton<String>(
      value: selectedValue,
      hint: Text("Select Rescheduled Reason"), // Placeholder text
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          selectedValue = newValue; // Update the selected value
          valueA = true;
          valueB = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDropdown(), // Call the dropdown function
          SizedBox(height: 20),
          Text(
            selectedValue != null ? " $selectedValue" : "No Reason Selected",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            selectedValue != null ? "" : "Please Select Rescheduled Reason",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}





class RescheduleDropdown extends StatefulWidget {
  @override
  _RescheduleDropdownState createState() => _RescheduleDropdownState();

  // Getter methods to access instance variables
  bool get value1 => _state?.valueA ?? false;
  bool get value2 => _state?.valueB ?? false;
  String get value3 => _state?.selectedValue;

  // Setter methods to modify instance variables
  set value1(bool newValue) {
    _state?.updateValueA(newValue);
  }

  set value2(bool newValue) {
    _state?.updateValueB(newValue);
  }

  set value3(String newValue) {
    _state?.updateSelectedValue(newValue);
  }

  // Reference to the state
  static _RescheduleDropdownState _state;
}

class _RescheduleDropdownState extends State<RescheduleDropdown> {
  // Instance variables for the widget state
  String selectedValue; // Nullable type
  bool valueA = false;
  bool valueB = false;

  @override
  void initState() {
    super.initState();
    // Link state to the widget
    RescheduleDropdown._state = this;
  }

  @override
  void dispose() {
    // Unlink the state from the widget
    RescheduleDropdown._state = null;
    super.dispose();
  }

  // Method to update valueA
  void updateValueA(bool newValue) {
    setState(() {
      valueA = newValue;
    });
  }

  // Method to update valueB
  void updateValueB(bool newValue) {
    setState(() {
      valueB = newValue;
    });
  }

  // Method to update selectedValue
  void updateSelectedValue(String newValue) {
    setState(() {
      selectedValue = newValue;
    });
  }

  // Dropdown builder
  Widget buildDropdown() {
    final List<String> options = [
      "Delay",
      "Product Damage",
      "Customer not found",
      "Product Lost"
    ];
    return DropdownButton<String>(
      value: selectedValue,
      hint: Text("Select Cancelled Reason"), // Placeholder text
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          selectedValue = newValue; // Update the selected value
          valueA = true;
          valueB = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDropdown(), // Call the dropdown function
          SizedBox(height: 20),
          Text(
            selectedValue != null ? " $selectedValue" : "No Reason Selected",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            selectedValue != null ? "" : "Please Select Cancelled Reason",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
