import 'dart:convert';

import 'package:flash_pass/customtabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TrafficLightScreen extends StatefulWidget {
  const TrafficLightScreen({super.key});

  @override
  _TrafficLightScreenState createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  late InAppWebViewController _webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            elevation: 0,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(178, 4, 31, 5)
                            .withOpacity(.25)),
                    child: const Icon(
                      Icons.traffic_outlined,
                      size: 80,
                      color: Color.fromARGB(178, 4, 31, 5),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        " FLASH🚓PASS",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Color.fromARGB(178, 4, 31, 5),
                        ),
                      ),
                      Text(
                        "  EMERGENCY",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color.fromARGB(178, 4, 31, 5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },
        onLoadStop: (controller, url) async {
          // Set up JavaScript handler to listen for the event from JavaScript
          _webViewController.addJavaScriptHandler(
            handlerName: 'onTrafficLightGreen',
            callback: (args) {
              // args will contain the 'Green' message sent by the JavaScript code
              print("Traffic light is green: ${args[0]}");

              // Optionally, you can show an alert or update the UI here
              Future.delayed(const Duration(seconds: 2)).then((value) => {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomNav(),
                        ),
                        (route) => false)
                  });
            },
          );
        },
        onLoadError: (controller, url, code, message) {
          print("Page Load Error: $message");
        },
        onLoadHttpError: (controller, url, statusCode, description) {
          print("HTTP Load Error: $description");
        },
        onProgressChanged: (controller, progress) {
          print("Loading progress: $progress%");
        },
        onCreateWindow: (controller, createWindowRequest) async {
          return true;
        },
        onJsAlert: (controller, javascriptMessage) async {
          // Handle JavaScript alerts here if necessary
          return JsAlertResponse(handledByClient: true);
        },
        initialUrlRequest: URLRequest(
          url: Uri.dataFromString(
            '''
              <!DOCTYPE html>
              <html lang="en">
              <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Traffic Light</title>
                <style>
                  body {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                    background-color: #f0f0f0;
                  }
                  .traffic-light {
                    width: 100px;
                    height: 250px;
                    background-color: black;
                    border-radius: 10px;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    padding: 10px;
                  }
                  .light {
                    width: 80px;
                    height: 60px;
                    border-radius: 50%;
                    margin: 5px auto;
                    background-color: grey;
                    transition: background-color 1s;
                  }
                  .green { background-color: green; }
                  .yellow { background-color: yellow; }
                  .red { background-color: red; }
                </style>
              </head>
              <body>

              <div class="traffic-light">
                <div class="light red" id="red"></div>
                <div class="light yellow" id="yellow"></div>
                <div class="light green" id="green"></div>
              </div>

              <script>
                // Simulate traffic light changing
                let redLight = document.getElementById("red");
                let yellowLight = document.getElementById("yellow");
                let greenLight = document.getElementById("green");

                setTimeout(() => {
                  // Red light off, yellow light on
                  redLight.classList.remove("red");
                  yellowLight.classList.add("yellow");

                  setTimeout(() => {
                    // Yellow light off, green light on
                    yellowLight.classList.remove("yellow");
                    greenLight.classList.add("green");

                    // Notify Flutter app when the light turns green
                    if (window.flutter_inappwebview) {
                      window.flutter_inappwebview.callHandler('onTrafficLightGreen', 'Green');
                    }
                  }, 2000);
                }, 2000);
              </script>

              </body>
              </html>
            ''',
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'),
          ),
        ),
      ),
    ));
  }
}
