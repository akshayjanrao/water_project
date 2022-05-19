import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:watersupply/check_out_page.dart';
import 'package:watersupply/custome_plan.dart';

class ProductPage extends StatefulWidget {
  String image;

  ProductPage({Key? key, required this.image}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int itemCount = 1;
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
   
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  void selectDate() {
    showDialog(
        context: context,
        builder: (context) {
          return SizedBox(

            width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).size.height*0.45,
            child: SimpleDialog(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title:const Text("select Date"),
              children: [
                SizedBox(
                   width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).size.height*0.45,
                  child: SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                      initialSelectedDate: DateTime.now(),
                      minDate: DateTime.now(),
                      selectionMode: DateRangePickerSelectionMode.range,
                      initialSelectedRange: PickerDateRange(
                          DateTime.now(),
                          DateTime.now().add(const Duration(days: 30)))),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Name")),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200),
            child: Column(
              children: [
                Image.asset(
                  "assets/water_image.png",
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Product One:",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "\$135",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              // counting page

              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        itemCount = itemCount + 1;

                        setState(() {});
                        // calculateTotal();
                      },
                      child: const Icon(
                        Icons.add,
                        size: 20,
                      ),
                    ),
                    Text(
                      "${itemCount}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    InkWell(
                      onTap: () {
                        if (itemCount != 1) {
                          itemCount = itemCount - 1;

                          setState(() {});
                        }
                        // calculateTotal();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 20,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is  ",
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w300,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
            child: Center(
          child: Wrap(
            spacing: 14,
            children: [
              TextButton(
                onPressed: () {
                  selectDate();
                },
                child: Text(
                  'Daily',
                  style: GoogleFonts.raleway(fontSize: 16, color: Colors.green),
                ),
                style: TextButton.styleFrom(
                    // backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.green,
                        ))),
              ),
              TextButton(
                onPressed: () {
                  selectDate();
                },
                child: Text('Alternate Days',
                    style:
                        GoogleFonts.raleway(fontSize: 16, color: Colors.green)),
                style: TextButton.styleFrom(
                    // backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.green,
                        ))),
              ),
              TextButton(
                onPressed: () {
                  selectDate();
                },
                child: Text('One Time',
                    style:
                        GoogleFonts.raleway(fontSize: 16, color: Colors.green)),
                style: TextButton.styleFrom(
                    // backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.green,
                        ))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CustomPlan() ));
                },
                child: Text('Custom',
                    style:
                        GoogleFonts.raleway(fontSize: 16, color: Colors.green)),
                style: TextButton.styleFrom(
                    // backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.green,
                        ))),
              ),
            ],
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total:"),
                      Text(
                        "70(approx)/per day",
                        style: GoogleFonts.poppins(
                            color: Colors.green, fontSize: 13),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextButton(
                      onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
                      },
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                    ),
                  )
                ]),
          ),
        )
      ]),
    );
  }
}
