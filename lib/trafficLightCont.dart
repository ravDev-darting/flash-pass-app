import 'dart:convert';
import 'package:flash_pass/customtabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class TrafficLightScreen extends StatefulWidget {
  const TrafficLightScreen({super.key});

  @override
  _TrafficLightScreenState createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  late InAppWebViewController _webViewController;
  BluetoothDevice? _connectedDevice;
  bool _isConnecting = false;
  String _status = "Disconnected";
  final List<BluetoothDevice> _foundDevices = [];
  BluetoothCharacteristic? _txCharacteristic;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    // Check if Bluetooth is available
    if (await FlutterBluePlus.isAvailable == false) {
      _updateStatus("Bluetooth not available");
      return;
    }

    // Listen to Bluetooth state changes
    FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on) {
        _updateStatus("Ready to connect");
      } else {
        _updateStatus("Bluetooth is off");
      }
    });
  }

  Future<void> _showDeviceList() async {
    await _scanForDevices();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Available Devices",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _foundDevices.length,
                  itemBuilder: (context, index) {
                    final device = _foundDevices[index];
                    return ListTile(
                      title: Text(device.platformName),
                      subtitle: Text(device.remoteId.toString()),
                      trailing: _connectedDevice?.remoteId == device.remoteId
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        Navigator.pop(context);
                        _connectToDevice(device);
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _scanForDevices();
                },
                child: const Text("Refresh Devices"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _scanForDevices() async {
    _updateStatus("Scanning...");
    setState(() {
      _foundDevices.clear();
      _isConnecting = false;
    });

    try {
      // Stop any ongoing scan
      await FlutterBluePlus.stopScan();

      // Listen to scan results
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (!_foundDevices.contains(result.device)) {
            setState(() {
              _foundDevices.add(result.device);
            });
          }
        }
      });

      // Start scan
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 5),
      );

      // Automatically stop after 5 seconds
      await Future.delayed(const Duration(seconds: 5));
      await FlutterBluePlus.stopScan();

      if (_foundDevices.isEmpty) {
        _updateStatus("No devices found");
      } else {
        _updateStatus("Found ${_foundDevices.length} devices");
      }
    } catch (e) {
      _updateStatus(
          "Scan error: ${e.toString().contains("turned") ? "Bluetooth must be turned on" : e.toString()}");
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    setState(() {
      _isConnecting = true;
      _status = "Connecting to ${device.platformName}...";
    });

    try {
      // Connect to device
      await device.connect(autoConnect: false);

      // Discover services
      List<BluetoothService> services = await device.discoverServices();

      // Find the characteristic for sending data (this depends on your device)
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.properties.write) {
            _txCharacteristic = characteristic;
            break;
          }
        }
      }

      if (_txCharacteristic == null) {
        throw Exception("No writable characteristic found");
      }

      setState(() {
        _connectedDevice = device;
        _status = "Connected to ${device.platformName}";
        _isConnecting = false;
      });
    } catch (e) {
      _updateStatus("Connection failed: ${e.toString()}");
      setState(() => _isConnecting = false);
      await device.disconnect();
    }
  }

  Future<void> _sendSignal(String command) async {
    if (_connectedDevice == null || _txCharacteristic == null) {
      _updateStatus("Not connected to any device");
      return;
    }

    try {
      // Convert command to bytes and send
      await _txCharacteristic!.write(utf8.encode(command));
      _updateStatus("Sent command: $command");
    } catch (e) {
      _updateStatus("Failed to send: ${e.toString()}");
    }
  }

  void _updateStatus(String message) {
    setState(() => _status = message);
    debugPrint(message);
  }

  Widget _buildControlButton(String text, String command, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      ),
      onPressed: () => _sendSignal(command),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
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
          actions: [
            IconButton(
              icon: const Icon(Icons.bluetooth),
              onPressed: _showDeviceList,
              color: _connectedDevice != null ? Colors.blue : Colors.grey,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: InAppWebView(
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
                      // Future.delayed(const Duration(seconds: 2))
                      //     .then((value) => {
                      //           Navigator.pushAndRemoveUntil(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => const CustomNav(),
                      //               ),
                      //               (route) => false)
                      //         });
                    },
                  );
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _status,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton("Button (01)", "01", Colors.blue),
                  _buildControlButton("Button (10)", "10", Colors.green),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton("Button (11)", "11", Colors.orange),
                  _buildControlButton("Button (100)", "100", Colors.red),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                  onPressed: () {
                    Future.delayed(const Duration(seconds: 2)).then((value) => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CustomNav(),
                              ),
                              (route) => false)
                        });
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Home')),
            ),
            if (_isConnecting)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connectedDevice?.disconnect();
    super.dispose();
  }
}
