// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:customer/View/Widgets/color.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                  width: screenWidth / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: TabBar(
                      dividerColor: Colors.white,
                      controller: _tabController,
                      labelColor: Colors.purple,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(text: 'DRIVER'),
                        Tab(text: 'PASSENGER'),
                      ]
                  )
              )
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
                DriverChat(),
                PassengerChat(),
              ])),
        ])

    );
  }
}

class DriverChat extends StatefulWidget {
  const DriverChat({super.key});

  @override
  State<DriverChat> createState() => _DriverChatState();
}

class _DriverChatState extends State<DriverChat> {
  bool isChecked = false;
  String selectedUser = "";
  String searchQuery = "";
  String drivernumber = "";
  List<Map<String, dynamic>> chatMessages = [];
  TextEditingController messageController = TextEditingController();
  String messageSearchQuery = "";
  Map<String, int> driverMessageCounts =
  {}; // NEW: To track count of messages from drivers
  bool sendingMessage = false;
  String role = "";
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }


  //Function to read message

  //Send message to driver




  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

    return Container(
        width: w,
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children:  [
              /// LEFT PANEL - USER LIST
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(children: [
                        /// Top Driver Section
                        Container(
                            margin: const EdgeInsets.all(
                                10), // Space from edges
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                                color: const Color(0xFFBDBDBD),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(0, 3)),
                                ]),
                            alignment: Alignment.center,
                            child: const Text("DRIVER",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black))),

                        /// Search Bar
                        Container(
                            color: const Color(0xFFD9D9D9),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(children: [
                              TextField(
                                  style:
                                  const TextStyle(color: Colors.black),
                                  cursorColor: Colors.white,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.black54),
                                      filled: true,
                                      fillColor: Color(0xFFD9D9D9),
                                      border: InputBorder.none),
                                  onChanged: (text) {
                                    if (mounted) {
                                      setState(() {
                                        searchQuery = text.toLowerCase();
                                      });
                                    }
                                  }),

                              // divider
                              const Padding(
                                  padding: EdgeInsets.only(
                                      left: 40,
                                      right: 10,
                                      top: 3,
                                      bottom: 5),
                                  child: Divider(
                                    color:
                                    Colors.white, // **White Divider**
                                    thickness: 2, // **Thin Line**
                                  )),
                            ])),

                        /// User List
                        Expanded(
                            child: ListView.builder(
                              // itemCount: drivers.length,
                                itemCount: 2,
                                itemBuilder: (context, index) {


                                  return Column(children: [
                                    /// User Item
                                    GestureDetector(
                                        onTap: () {

                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                     "fgdfdgdfgdfgd",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color:Colors
                                                              .red))),


                                                Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            12)),
                                                    child: Text(
                                                        "Unread",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 12))),
                                            ])),

                                    const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                            color: Colors.white,
                                            thickness: 2)),
                                  ]);
                                })),

                        /// Multi Select Checkbox
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              Checkbox(
                                  value: isChecked,
                                  activeColor: Colors.blue,
                                  onChanged: (bool? value) {
                                    if (mounted) {
                                      setState(() {
                                        isChecked = value ?? false;
                                      });
                                    }
                                  }),
                              const Text("Multi select"),
                            ])),
                      ]))),

              Container(width: 20, color: const Color(0xFFFAF3EC)),

              /// RIGHT PANEL - CHAT AREA
              Expanded(
                  flex: 3, // Adjusted width
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(children: [
                        /// Search Message Bar
                        Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                                color: Color(0xFFBDBDBD),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(children: [
                                        Icon(Icons.search,
                                            color: Colors.black54),
                                        SizedBox(width: 10),
                                        SizedBox(
                                            width: 200,
                                            child: TextField(
                                                style: TextStyle(
                                                    color: Colors.black),
                                                cursorColor: Colors.black,
                                                decoration: InputDecoration(
                                                    hintText:
                                                    "Search message",
                                                    hintStyle: TextStyle(
                                                        color:
                                                        Colors.black54),
                                                    border:
                                                    InputBorder.none),
                                                onChanged: (val) {
                                                  if (mounted) {
                                                    setState(() {
                                                      messageSearchQuery =
                                                          val;
                                                    });
                                                  }
                                                })),
                                      ])),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text("Message body",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 5, 128, 228)))),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          style: IconButton.styleFrom(
                                              backgroundColor:
                                              CustomColor.black),
                                          icon: Icon(Icons.refresh,
                                              color:
                                              CustomColor.Text_Color),
                                          onPressed: () {

                                          })),
                                ])),

                        /// Chat Messages
                        Expanded(
                            child: Container(
                                color: const Color(0xFFD9D9D9),
                                child: ListView.builder(
                                    reverse:
                                    true, // ✅ Latest messages on top
                                    controller:
                                    _scrollController, // ✅ Auto-scroll support
                                    itemCount: chatMessages.where((msg) {
                                      if (messageSearchQuery.isEmpty) {
                                        return true;
                                      }
                                      String content =
                                      (msg["message"] ?? "")
                                          .toString()
                                          .toLowerCase();
                                      return content.contains(
                                          messageSearchQuery.toLowerCase());
                                    }).length,
                                    itemBuilder: (context, index) {
                                      // var filteredMessages =
                                      //     chatMessages.where((msg) {
                                      //   if (messageSearchQuery.isEmpty) {
                                      //     return true;
                                      //   }
                                      //   String content =
                                      //       (msg["message"] ?? "")
                                      //           .toString()
                                      //           .toLowerCase();
                                      //   return content.contains(
                                      //       messageSearchQuery
                                      //           .toLowerCase());
                                      // }).toList();

                                      var filteredMessages = chatMessages
                                          .where((msg) {
                                        if (messageSearchQuery
                                            .isEmpty) {
                                          return true;
                                        }
                                        String content =
                                        (msg["message"] ?? "")
                                            .toString()
                                            .toLowerCase();
                                        return content.contains(
                                            messageSearchQuery
                                                .toLowerCase());
                                      })
                                          .toList()
                                          .reversed
                                          .toList(); // ✅ Reversed filtered list
                                      var msg = filteredMessages[index];
                                      bool isAdmin = msg["from"]
                                          .toString()
                                          .toLowerCase() ==
                                          role.toLowerCase().toString();
                                      bool isDriver =
                                          msg["from"] == selectedUser;

                                      if (isAdmin) {
                                        return adminBubble(msg["message"],
                                            msg["timestamp"]);
                                      } else if (isDriver) {
                                        return chatBubble(
                                          msg["message"],
                                          msg["timestamp"],
                                          Colors.blueAccent,
                                          Colors.lightBlueAccent,
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }))),

                        /// Template Buttons
                        Column(children: [
                          Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 45),
                                    templateButton("Template 1"),
                                    const SizedBox(width: 25),
                                    templateButton("Template 2"),
                                    const SizedBox(width: 25),
                                    templateButton("Template 3"),
                                  ])),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                  color: Colors.white, thickness: 2)),
                          Container(
                              padding: const EdgeInsets.all(10),
                              color: const Color(0xFFD9D9D9),
                              child: Row(children: [
                                // Icon(Icons.emoji_emotions_outlined,
                                //     color: Colors.black54),
                                SizedBox(width: 10),
                                // Expanded(
                                //     child: TextField(
                                //         controller: messageController,
                                //         decoration: InputDecoration(
                                //             hintText: "Type your message",
                                //             hintStyle: TextStyle(
                                //                 color: Colors.black54),
                                //             border: InputBorder.none))),
                                Expanded(
                                    child: RawKeyboardListener(
                                        focusNode:
                                        FocusNode(), // Required for capturing key events

                                        child: TextField(
                                            controller: messageController,
                                            maxLength: 50,
                                            maxLines:
                                            null, // Allows new lines with Shift+Enter
                                            keyboardType:
                                            TextInputType.multiline,
                                            decoration:
                                            const InputDecoration(
                                                hintText:
                                                "Type your message",
                                                hintStyle: TextStyle(
                                                    color:
                                                    Colors.black54),
                                                border: InputBorder
                                                    .none)))),

                                GestureDetector(
                                    onTap: () {

                                    },
                                    child: sendingMessage
                                        ? CircularProgressIndicator(
                                        color: Colors.white)
                                        : Icon(Icons.send,
                                        color: Colors.blue)),
                              ])),
                        ]),
                      ]))),
            ])
        )
    );
  }

  // Chat Bubble for User
  Widget chatBubble(
      String text, String time, Color startColor, Color endColor) {
    String formattedTime = formatDateTime(time);
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          const Icon(Icons.person, color: Colors.blue),
          const SizedBox(width: 10),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 300,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        gradient:
                        LinearGradient(colors: [startColor, endColor]),
                        borderRadius: BorderRadius.circular(15)),
                    child: SelectableText(text,
                        style: const TextStyle(
                            overflow: TextOverflow.fade,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black))),
                Text(formattedTime, style: TextStyle(fontSize: 10))
              ]),
        ]));
  }

  /// Admin Chat Bubble
  Widget adminBubble(String text, String isoTime) {
    String formattedTime = formatDateTime(isoTime);

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(
                    width: 300,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              padding:
                              const EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Colors.greenAccent,
                                    Colors.blueAccent
                                  ]),
                                  borderRadius: BorderRadius.circular(15)),
                              child: SelectableText(text,
                                  style: const TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontWeight: FontWeight.bold))),
                          Text(formattedTime, style: TextStyle(fontSize: 10))
                        ])),
                const SizedBox(width: 10),
                const Icon(Icons.person, color: Colors.red),
              ]),
            ]));
  }

  String formatDateTime(String isoString) {
    try {
      DateTime dateTime = DateTime.parse(isoString);

      String date = DateFormat('dd/MM/yy').format(dateTime); // 07/04/25
      String time = DateFormat('h:mm a').format(dateTime); // 5:12 PM

      return "$date at $time";
    } catch (e) {
      print("Invalid time format: $isoString");
      return isoString; // fallback
    }
  }

  /// Template Button
  Widget templateButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }
}

class PassengerChat extends StatefulWidget {
  const PassengerChat({super.key});

  @override
  State<PassengerChat> createState() => _PassengerChatState();
}

class _PassengerChatState extends State<PassengerChat> {
  bool isChecked = false;
  String selectedUser = "";
  List<dynamic> customers = [];
  String searchQuery = "";
  String customernumber = "";
  List<Map<String, dynamic>> chatMessages = [];
  TextEditingController messageController = TextEditingController();
  String messageSearchQuery = "";
  Map<String, int> customerMessageCounts =
  {}; // NEW: To track count of messages from drivers
  bool sendingMessage = false;
  String role = "";
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

    return Container(
        width: w,
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              /// LEFT PANEL - USER LIST
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(children: [
                        /// Top Driver Section
                        Container(
                          margin:
                          const EdgeInsets.all(10), // Space from edges
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFBDBDBD),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "PASSENGER",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        /// Search Bar
                        Container(
                            color: const Color(0xFFD9D9D9),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(children: [
                              TextField(
                                  style:
                                  const TextStyle(color: Colors.black),
                                  cursorColor: Colors.white,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.search,
                                        color: Colors.black54),
                                    filled: true,
                                    fillColor: Color(0xFFD9D9D9),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (text) {
                                    if (mounted) {
                                      setState(() {
                                        searchQuery = text.toLowerCase();
                                      });
                                    }
                                  }),

                              // divider
                              const Padding(
                                  padding: EdgeInsets.only(
                                      left: 40,
                                      right: 10,
                                      top: 3,
                                      bottom: 5),
                                  child: Divider(
                                    color:
                                    Colors.white, // **White Divider**
                                    thickness: 2, // **Thin Line**
                                  )),
                            ])),

                        /// User List
                        Expanded(
                            child: ListView.builder(
                              // itemCount: drivers.length,
                                itemCount: customers.where((customer) {
                                  String customerName =
                                  customer["customerName"]
                                      .toString()
                                      .toLowerCase();
                                  return customerName.contains(searchQuery);
                                }).length,
                                itemBuilder: (context, index) {
                                  var filteredCustomers =
                                  customers.where((customer) {
                                    String customerName =
                                    customer["customerName"]
                                        .toString()
                                        .toLowerCase();
                                    return customerName
                                        .contains(searchQuery);
                                  }).toList();
                                  String driverKey =
                                  (filteredCustomers[index]
                                  ["customerName"] ??
                                      "")
                                      .toLowerCase();
                                  int unreadCount =
                                      customerMessageCounts[driverKey] ?? 0;
                                  return Column(children: [
                                    /// User Item
                                    GestureDetector(
                                        onTap: () {

                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      filteredCustomers[
                                                      index][
                                                      "customerName"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: selectedUser ==
                                                              filteredCustomers[index]
                                                              [
                                                              "customerName"]
                                                                  .toString()
                                                              ? Colors.blue
                                                              : Colors
                                                              .black))),
                                              // if ((customerMessageCounts[
                                              //             filteredCustomers[
                                              //                     index][
                                              //                 "customerName"]] ??
                                              //         0) >
                                              //     0)
                                              //   Container(
                                              //       padding: EdgeInsets
                                              //           .symmetric(
                                              //               horizontal: 8,
                                              //               vertical: 4),
                                              //       decoration:
                                              //           BoxDecoration(
                                              //         color: Colors.red,
                                              //         borderRadius:
                                              //             BorderRadius
                                              //                 .circular(12),
                                              //       ),
                                              //       child: Text(
                                              //           "${customerMessageCounts[filteredCustomers[index]["customerName"]]} Unread",
                                              //           style: TextStyle(
                                              //               color: Colors
                                              //                   .white,
                                              //               fontSize: 12))),
                                              if (unreadCount > 0)
                                                Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            12)),
                                                    child: Text(
                                                        "$unreadCount Unread",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 12))),
                                            ])),

                                    const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                            color: Colors.white,
                                            thickness: 2)),
                                  ]);
                                })),

                        /// Multi Select Checkbox
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              Checkbox(
                                  value: isChecked,
                                  activeColor: Colors.blue,
                                  onChanged: (bool? value) {
                                    if (mounted) {
                                      setState(() {
                                        isChecked = value ?? false;
                                      });
                                    }
                                  }),
                              const Text("Multi select"),
                            ])),
                      ]))),

              Container(width: 20, color: const Color(0xFFFAF3EC)),

              /// RIGHT PANEL - CHAT AREA
              Expanded(
                  flex: 3, // Adjusted width
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(children: [
                        /// Search Message Bar
                        Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Color(0xFFBDBDBD),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(children: [
                                        Icon(Icons.search,
                                            color: Colors.black54),
                                        SizedBox(width: 10),
                                        SizedBox(
                                            width: 200,
                                            child: TextField(
                                                style: TextStyle(
                                                    color: Colors.black),
                                                cursorColor: Colors.black,
                                                decoration: InputDecoration(
                                                  hintText:
                                                  "Search message",
                                                  hintStyle: TextStyle(
                                                      color:
                                                      Colors.black54),
                                                  border: InputBorder.none,
                                                ),
                                                onChanged: (val) {
                                                  if (mounted) {
                                                    setState(() {
                                                      messageSearchQuery =
                                                          val;
                                                    });
                                                  }
                                                })),
                                      ])),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text("Message body",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 5, 128, 228)))),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          style: IconButton.styleFrom(
                                              backgroundColor:
                                              CustomColor.black),
                                          icon: Icon(Icons.refresh,
                                              color:
                                              CustomColor.Text_Color),
                                          onPressed: () {
                                          })),
                                ])),

                        /// Chat Messages
                        Expanded(
                            child: Container(
                                color: const Color(0xFFD9D9D9),
                                child: ListView.builder(
                                    reverse:
                                    true, // ✅ Latest messages on top
                                    controller:
                                    _scrollController, // ✅ Auto-scroll support
                                    itemCount: chatMessages.where((msg) {
                                      if (messageSearchQuery.isEmpty) {
                                        return true;
                                      }
                                      String content =
                                      (msg["message"] ?? "")
                                          .toString()
                                          .toLowerCase();
                                      return content.contains(
                                          messageSearchQuery.toLowerCase());
                                    }).length,
                                    itemBuilder: (context, index) {
                                      var filteredMessages = chatMessages
                                          .where((msg) {
                                        if (messageSearchQuery
                                            .isEmpty) {
                                          return true;
                                        }
                                        String content =
                                        (msg["message"] ?? "")
                                            .toString()
                                            .toLowerCase();
                                        return content.contains(
                                            messageSearchQuery
                                                .toLowerCase());
                                      })
                                          .toList()
                                          .reversed
                                          .toList(); // ✅ Reversed filtered list

                                      var msg = filteredMessages[index];
                                      bool isAdmin = msg["from"]
                                          .toString()
                                          .toLowerCase() ==
                                          role.toString().toLowerCase();
                                      bool isCustomer =
                                          msg["from"] == selectedUser;
                                      if (isAdmin) {
                                        return adminBubble(msg["message"],
                                            msg["timestamp"]);
                                      } else if (isCustomer) {
                                        return chatBubble(
                                          msg["message"],
                                          msg["timestamp"],
                                          Colors.blueAccent,
                                          Colors.lightBlueAccent,
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }))),

                        /// Template Buttons
                        Column(children: [
                          Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 45),
                                    templateButton("Template 1"),
                                    const SizedBox(width: 25),
                                    templateButton("Template 2"),
                                    const SizedBox(width: 25),
                                    templateButton("Template 3"),
                                  ])),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                  color: Colors.white, thickness: 2)),
                          Container(
                              padding: const EdgeInsets.all(10),
                              color: const Color(0xFFD9D9D9),
                              child: Row(children: [
                                // Icon(Icons.emoji_emotions_outlined,
                                //     color: Colors.black54),
                                SizedBox(width: 10),
                                // Expanded(
                                //     child: TextField(
                                //         controller: messageController,
                                //         decoration: InputDecoration(
                                //             hintText: "Type your message",
                                //             hintStyle: TextStyle(
                                //                 color: Colors.black54),
                                //             border: InputBorder.none))),
                                Expanded(
                                    child: RawKeyboardListener(
                                        focusNode:
                                        FocusNode(), // Required for capturing key events

                                        child: TextField(
                                            maxLength: 200,
                                            controller: messageController,
                                            maxLines:
                                            null, // Allows new lines with Shift+Enter
                                            keyboardType:
                                            TextInputType.multiline,
                                            decoration:
                                            const InputDecoration(
                                                hintText:
                                                "Type your message",
                                                hintStyle: TextStyle(
                                                    color:
                                                    Colors.black54),
                                                border: InputBorder
                                                    .none)))),

                                GestureDetector(
                                    onTap: () {

                                    },
                                    child: Icon(Icons.send,
                                        color: Colors.blue)),
                              ])),
                        ]),
                      ]))),
            ])));
  }

  /// Chat Bubble for User
  Widget chatBubble(
      String text, String time, Color startColor, Color endColor) {
    String formattedTime = formatDateTime(time);
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          const Icon(Icons.person, color: Colors.blue),
          const SizedBox(width: 10),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 300,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        gradient:
                        LinearGradient(colors: [startColor, endColor]),
                        borderRadius: BorderRadius.circular(15)),
                    child: SelectableText(text,
                        style: const TextStyle(
                            overflow: TextOverflow.fade,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black))),
                Text(formattedTime, style: TextStyle(fontSize: 10))
              ]),
        ]));
  }

  // /// Admin Chat Bubble
  // Widget adminBubble(String text, String dateTime) {
  //   // final screenWidth = MediaQuery.of(context).size.width;
  //   // final screenHeight = MediaQuery.of(context).size.height;
  //   return Container(
  //       color: Colors.yellow,
  //       child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(mainAxisAlignment: MainAxisAlignment.end, children: [
  //               Container(
  //                   width: 300,
  //                   padding: const EdgeInsets.only(left: 20, right: 20),
  //                   decoration: BoxDecoration(
  //                       gradient: const LinearGradient(
  //                           colors: [Colors.greenAccent, Colors.blueAccent]),
  //                       borderRadius: BorderRadius.circular(15)),
  //                   child: Text(text,
  //                       style: const TextStyle(
  //                           overflow: TextOverflow.fade,
  //                           fontWeight: FontWeight.bold))),
  //               const SizedBox(width: 10),
  //               const Icon(Icons.person, color: Colors.red),
  //             ]),
  //             Text(dateTime,
  //                 style: TextStyle(color: Colors.black, fontSize: 18)),
  //           ]));
  // }
  /// Admin Chat Bubble
  Widget adminBubble(String text, String isoTime) {
    String formattedTime = formatDateTime(isoTime);

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(
                    width: 300,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              padding:
                              const EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Colors.greenAccent,
                                    Colors.blueAccent
                                  ]),
                                  borderRadius: BorderRadius.circular(15)),
                              child: SelectableText(text,
                                  style: const TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontWeight: FontWeight.bold))),
                          Text(formattedTime, style: TextStyle(fontSize: 10))
                        ])),
                const SizedBox(width: 10),
                const Icon(Icons.person, color: Colors.red),
              ]),
            ]));
  }

  String formatDateTime(String isoString) {
    try {
      DateTime dateTime = DateTime.parse(isoString);

      String date = DateFormat('dd/MM/yy').format(dateTime); // 07/04/25
      String time = DateFormat('h:mm a').format(dateTime); // 5:12 PM

      return "$date at $time";
    } catch (e) {
      print("Invalid time format: $isoString");
      return isoString; // fallback
    }
  }

  /// Template Button
  Widget templateButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }
}
