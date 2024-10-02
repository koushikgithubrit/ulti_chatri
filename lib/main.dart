// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flare_flutter/flare_actor.dart'; // For rain animation
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'UltaChatri',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RainStatusScreen(),
//     );
//   }
// }
//
// class RainStatusScreen extends StatefulWidget {
//   @override
//   RainStatusScreenState createState() => RainStatusScreenState();
// }
//
// class RainStatusScreenState extends State<RainStatusScreen> {
//   final databaseReference = FirebaseDatabase.instance.ref();
//   bool isRaining = false;
//   bool ledState = false;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('UltaChatri'),
//         // leading: Image.asset('assets/logo.png'), // Your logo here
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             isRaining ? 'It is Raining' : 'Not Raining',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           isRaining
//               ? Container(
//             height: 200,
//             child: FlareActor(
//               "assets/rain_animation.flr", // Your Flare rain animation
//               animation: "rain",
//             ),
//           )
//               : Icon(Icons.wb_sunny, size: 100, color: Colors.orange),
//           SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: toggleLed,
//             child: Text(ledState ? 'Turn LED Off' : 'Turn LED On'),
//           ),
//         ],
//       ),
//     );
//   }
// }






import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flare_flutter/flare_actor.dart'; // For animations

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  @override
  RainStatusScreenState createState() => RainStatusScreenState();
}

class RainStatusScreenState extends State<RainStatusScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();
  bool isRaining = false;
  bool ledState = false;
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
          title: Text('Notifications'),
          content: Container(
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
              child: Text("Close"),
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
        title: Text(
          'UltaChatri',
          style: TextStyle(color: Colors.yellowAccent), // App name color
        ),
        leading: Image.asset('assets/logo.jpeg'), // Your logo here
        backgroundColor: Colors.deepPurpleAccent, // Changed app bar color
        actions: [
          IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: AlwaysStoppedAnimation(1.0),
              color: Colors.yellow,
            ),
            onPressed: showNotifications, // Show notifications on click
          ),
        ],
      ),
      body: Container(
        // Background changes based on rainStatus
        decoration: BoxDecoration(
          image: isRaining
              ? DecorationImage(
            image: AssetImage("assets/rain_bg.gif"), // Rain background
            fit: BoxFit.cover,
          )
              : DecorationImage(
            image: AssetImage("assets/sunny_bg.gif"), // Sunny background
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isRaining ? 'It is Raining' : 'Not Raining',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            isRaining
                ? Container(
              height: 200,
              child: FlareActor(
                "assets/rain_animation.flr", // Rain animation
                animation: "rain",
              ),
            )
                : Icon(Icons.wb_sunny, size: 100, color: Colors.orange),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: toggleLed,
              child: Text(ledState ? 'Turn LED Off' : 'Turn LED On'),
            ),
          ],
        ),
      ),
    );
  }
}
