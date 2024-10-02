// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flare_flutter/flare_actor.dart'; // For animations
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'UltaChatri',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false, // Removed the debug tag
//       home: RainStatusScreen(),
//     );
//   }
// }
//
// class RainStatusScreen extends StatefulWidget {
//   const RainStatusScreen({super.key});
//
//   @override
//   RainStatusScreenState createState() => RainStatusScreenState();
// }
//
// class RainStatusScreenState extends State<RainStatusScreen> {
//   final databaseReference = FirebaseDatabase.instance.ref();
//   bool isRaining = true;
//   bool ledState = true;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   List<String> notifications = [];
//
//   @override
//   void initState() {
//     super.initState();
//     setupFirebaseListener();
//     setupNotification();
//   }
//
//   void setupNotification() {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   void showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, title, body, platformChannelSpecifics);
//
//     setState(() {
//       notifications.add('$title: $body at ${DateTime.now()}');
//     });
//   }
//
//   void setupFirebaseListener() {
//     databaseReference.child('rainStatus').onValue.listen((event) {
//       int rainValue = (event.snapshot.value as int);
//       if (rainValue == 1 && !isRaining) {
//         setState(() {
//           isRaining = true;
//         });
//         showNotification("It is raining", "The umbrella is opening.");
//       } else if (rainValue == 0 && isRaining) {
//         setState(() {
//           isRaining = false;
//         });
//         showNotification("It stopped raining", "The umbrella is closing.");
//       }
//     });
//
//     databaseReference.child('ledState').onValue.listen((event) {
//       setState(() {
//         ledState = (event.snapshot.value as bool);
//       });
//     });
//   }
//
//   void toggleLed() {
//     databaseReference.child('ledState').set(!ledState);
//   }
//
//   // Method to display notifications in a modal
//   void showNotifications() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Notifications'),
//           content: SizedBox(
//             width: double.maxFinite,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: notifications.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(notifications[index]),
//                 );
//               },
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               child: Text("Close"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'UltaChatri',
//           style: TextStyle(color: Colors.white), // App name color
//         ),
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 8.0), // Add padding on the left side
//           child: SizedBox(
//             width: 40, // Adjust the width to decrease the size of the logo
//             height: 40, // Adjust the height to decrease the size of the logo
//             child: Image.asset('assets/logo.jpeg'), // Your logo here
//           ),
//         ),
//         backgroundColor: Colors.purpleAccent[700], // Changed app bar color
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.notifications_active, // Changed to notification icon
//               color: Colors.blue[900], // Icon color
//             ),
//             onPressed: showNotifications, // Show notifications on click
//           ),
//         ],
//       ),
//
//       body: Container(
//         // Background changes based on rainStatus
//         decoration: BoxDecoration(
//           image: isRaining
//               ? DecorationImage(
//             image: AssetImage("assets/rain_bg.gif"), // Rain background
//             fit: BoxFit.cover,
//           )
//               : DecorationImage(
//             image: AssetImage("assets/sunny_bg.gif"), // Sunny background
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
//             crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
//             children: <Widget>[
//               Text(
//                 isRaining ? 'It is Raining' : 'Not Raining',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               isRaining
//                   ? SizedBox(
//                 height: 200,
//                 child: FlareActor(
//                   "assets/rain_animation.flr", // Rain animation
//                   animation: "rain",
//                 ),
//               )
//                   : Icon(Icons.wb_sunny, size: 100, color: Colors.orange),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: toggleLed,
//                 child: Text(ledState ? 'Turn LED Off' : 'Turn LED On'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






//2nd
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flare_flutter/flare_actor.dart'; // For animations
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UltaChatri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Removed the debug tag
      home: RainStatusScreen(),
    );
  }
}

class RainStatusScreen extends StatefulWidget {
  const RainStatusScreen({super.key});

  @override
  RainStatusScreenState createState() => RainStatusScreenState();
}


class RainStatusScreenState extends State<RainStatusScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();
  bool isRaining = false;  // Represents rain status from Firebase (1 or 0)
  bool ledState = false;   // LED state from Firebase
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    setupFirebaseListener();
    setupNotification();
  }

  void setupNotification() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);

    setState(() {
      notifications.add('$title: $body at ${DateTime.now()}');
    });
  }





  void setupFirebaseListener() {
    databaseReference.child('rainStatus').onValue.listen((event) {
      int rainValue = (event.snapshot.value as int);
      if (rainValue == 1 && !isRaining) {
        setState(() {
          isRaining = true;
        });
        showNotification("It is raining", "The umbrella is opening.");
      } else if (rainValue == 0 && isRaining) {
        setState(() {
          isRaining = false;
        });
        showNotification("It stopped raining", "The umbrella is closing.");
      }
    });

    databaseReference.child('ledState').onValue.listen((event) {
      setState(() {
        ledState = (event.snapshot.value as bool);
      });
    });
  }

  void toggleLed() {
    databaseReference.child('ledState').set(!ledState);
  }

  // Method to display notifications in a modal
  void showNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notifications'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(notifications[index]),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UltaChatri',
          style: TextStyle(color: Colors.white), // App name color
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0), // Add padding on the left side
          child: SizedBox(
            width: 40, // Adjust the width to decrease the size of the logo
            height: 40, // Adjust the height to decrease the size of the logo
            child: Image.asset('assets/logo.jpeg'), // Your logo here
          ),
        ),
        backgroundColor: Colors.purpleAccent[700], // Changed app bar color
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active, // Notification icon
              color: Colors.blue[900], // Icon color
            ),
            onPressed: showNotifications, // Show notifications on click
          ),
        ],
      ),

      body: Container(
        // Background changes based on rainStatus
        decoration: BoxDecoration(
          image: isRaining
              ? const DecorationImage(
            image: AssetImage("assets/rain_bg.gif"), // Rain background
            fit: BoxFit.cover,
          )
              : const DecorationImage(
            image: AssetImage("assets/sunny_bg.gif"), // Sunny background
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
            children: <Widget>[
              Text(
                isRaining ? 'It is Raining' : 'Not Raining',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              isRaining
                  ? const Icon(Icons.cloud, size: 100, color: Colors.grey) // Cloud icon when raining
                  : const Icon(Icons.wb_sunny, size: 100, color: Colors.orange), // Sun icon when not raining
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: toggleLed,
                child: Text(
                    ledState ? 'Turn LED Off' : 'Turn LED On'), // Adjust button text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
