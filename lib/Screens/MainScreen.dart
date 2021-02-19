import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:khatu/methods/get.dart';
import 'package:khatu/model/Model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            const url = 'https://www.shrishyamdarshan.in/darshan-booking/';
            if (await canLaunch(url)) {
              await launch(
                url,
                forceWebView: true,
                enableJavaScript: true,
                enableDomStorage: true,
              );
            } else {
              throw 'Could not launch $url';
            }
          },
          label: Text("Book"),
          icon: Icon(Icons.book_online),
        ),
        body: FutureBuilder(
          future: getBookings(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              MyModel model = snapshot.data;
              return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setLocalState) {
                return Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: model.selection2.length * 5,
                        itemBuilder: (context, dateIndex) {
                          dateIndex = 0;
                          bool selected = false;
                          selectedIndex == dateIndex ? selected = true : false;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                selectedIndex = dateIndex;
                                setLocalState(() {});
                              },
                              child: Column(
                                children: [
                                  // Text(model.selection2[dateIndex].date.year.toString()),
                                  Text(DateFormat.MMM().format(new DateTime.now())),
                                  SizedBox(height: 5),

                                  CircleAvatar(
                                    backgroundColor: selected ? Colors.red : Colors.transparent,
                                    child: Text(
                                      model.selection2[dateIndex].date.day.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: selected ? Colors.white : Colors.red,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(DateFormat.E().format(model.selection2[dateIndex].date)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        title: Text("Time Slots", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        trailing: Text("Slots Available", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () {
                          setState(() {});

                          return Future.delayed(Duration(seconds: 4), () {
                            return null;
                          });
                        },
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, timeSlotIndex) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ListTile(
                                  title: Text(model.selection2[selectedIndex].timeSlots[timeSlotIndex + 1].time),
                                  trailing: Text(
                                    model.selection2[selectedIndex].timeSlots[timeSlotIndex + 1].available,
                                    style: TextStyle(
                                        color: int.parse(model
                                                    .selection2[selectedIndex].timeSlots[timeSlotIndex + 1].available) >
                                                0
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, i) => Divider(),
                            itemCount: model.selection2[selectedIndex].timeSlots.length - 1),
                      ),
                    ),
                  ],
                );
              });
              // );
            } else {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48.0,
                          height: 48.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 40.0,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: 10,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
