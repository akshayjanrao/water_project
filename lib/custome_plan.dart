import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPlan extends StatefulWidget {
  const CustomPlan({Key? key}) : super(key: key);

  @override
  State<CustomPlan> createState() => _CustomPlanState();
}

class _CustomPlanState extends State<CustomPlan> {
  List weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "saturday",
    "sunday"
  ];

  int daysSelected = 0;

  List<Map> selectedDay = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom")),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 80,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: AssetImage("assets/water_image.png"),
                  ),

                  title: Text("Product Page"),

                  trailing: Text("Prize"),

                  // trailing: Text(""),
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          color: Colors.grey,
          child: Column(
            children: [
              Wrap(
                spacing: 14,
                children: [
                  TextButton(
                    onPressed: () {
                      if(!selectedDay.contains({"name": "Monday", "count": 0})){
                      selectedDay.add({"name": "Monday", "count": 0});

                      }

                      setState(() {});
                    },
                    child: Text(
                      'Mon',
                      style: GoogleFonts.raleway(
                          fontSize: 16, color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: Colors.black,
                          // )
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      
                        if(selectedDay.contains({"name": "Tuesday", "count": 0})){
                      //selectedDay.add({"name": "Monday", "count": 0});
                      selectedDay.add({"name": "Tuesday", "count": 0});

                      print("testing data =>"+selectedDay.contains({"name": "Tuesday", "count": 0}).toString());

                      }

                      setState(() {});
                    },
                    child: Text('Tus',
                        style: GoogleFonts.raleway(
                            fontSize: 16, color: Colors.black)),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: Colors.black,
                          // )
                        )),
                  ),
                  TextButton(
                    onPressed: () {


                             if(!selectedDay.contains({"name": "Wednesday", "count": 0})){
                      
                      
                      selectedDay.add({"name": "Wednesday", "count": 0});

                      }
                      
                      setState(() {});
                    },
                    child: Text('Wed',
                        style: GoogleFonts.raleway(
                            fontSize: 16, color: Colors.black)),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: Colors.black,
                          // )
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      
                             if(!selectedDay.contains({"name": "Thusday", "count": 0})){
                      
                      selectedDay.add({"name": "Thusday", "count": 0});
                      }
                     
                      setState(() {});
                    },
                    child: Text('Thus',
                        style: GoogleFonts.raleway(
                            fontSize: 16, color: Colors.black)),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: Colors.black,
                          // )
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                     
                            if(!selectedDay.contains({"name": "Friday", "count": 0})){
                      
                      selectedDay.add({"name": "Friday", "count": 0});
                      
                      }
                     
                      setState(() {});
                    },
                    child: Text('Fri',
                        style: GoogleFonts.raleway(
                            fontSize: 16, color: Colors.black)),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: Colors.black,
                          // )
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      selectedDay.add({"name": "Saturday", "count": 0});

                      setState(() {});
                    },
                    child: Text('Sat',
                        style: GoogleFonts.raleway(
                            fontSize: 16, color: Colors.black)),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: Colors.black,
                          // )
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      selectedDay.add({"name": "Sunday", "count": 0});

                      setState(() {});
                    },
                    child: Text('Sun',
                        style: GoogleFonts.raleway(
                            fontSize: 16, color: Colors.black)),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: Colors.black,
                          // )
                        )),
                  ),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedDay.length,
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      height: 80,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          // selectedDay[index]["count"]
                          title: Text(selectedDay[index]["name"]),

                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.grey)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    selectedDay[index]["count"] + 1;

                                    setState(() {});
                                    // calculateTotal();
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  "${selectedDay[index]["count"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (selectedDay[index]["count"] != 1) {
                                      selectedDay[index]["count"] - 1;

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
                          ),
                        ),
                      ),
                    );
                  }))
            ],
          ),
        ))
      ]),
    );
  }
}
