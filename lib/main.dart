import 'dart:async';  // Import to use Timer

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final stopwatch = Stopwatch();
  String elapsedTime = "00:00:00.000"; // Store the formatted time as a string

  // Function to start the stopwatch
  void startwatch() {
    if (!stopwatch.isRunning) {
      stopwatch.start();
      print("Stopwatch started");

      // Start a periodic timer to update the elapsed time every 9 milliseconds
      Timer.periodic(const Duration(milliseconds: 9), (timer) {
        if (stopwatch.isRunning) {
          setState(() {
            elapsedTime = formatDuration(stopwatch.elapsed);
          });
        } else {
          // Stop the timer once the stopwatch is stopped
          timer.cancel();
        }
      });
    }
  }

  // Function to stop the stopwatch
  Future<void> stopthewatch() async {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      print("Stopwatch stopped");
      setState(() {}); // Force the UI to update after stopping
    }
  }

  // Function to reset the stopwatch
  void resetwatch() {
    stopwatch.stop();
    stopwatch.reset();
    setState(() {
      elapsedTime = "00:00:00.000"; // Reset elapsed time on UI
    });
    print("Stopwatch reset");
  }

  // Function to format the elapsed time as hh:mm:ss.mmm
  String formatDuration(Duration duration) {
    // Get the hours, minutes, seconds, and milliseconds
    String hours = (duration.inHours).toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String milliseconds = (duration.inMilliseconds % 1000).toString().padLeft(3, '0');

    return "$hours:$minutes:$seconds.$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "STOPWATCH",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black12,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the elapsed time in the center
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Text(
                    elapsedTime,  // Display the formatted elapsed time here
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Row of buttons: Start, Stop, and Reset
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Stop button
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: stopthewatch,
                      icon: Icon(Icons.pause, size: 40),
                    ),
                  ),
                  // Start button
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: startwatch,
                      icon: Icon(Icons.play_arrow_rounded, size: 40),
                    ),
                  ),
                  // Reset button
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: resetwatch,
                      icon: Icon(Icons.restart_alt, size: 40),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
