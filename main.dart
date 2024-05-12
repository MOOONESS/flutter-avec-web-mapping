import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert'; // Ensure this import is present for Encoding

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Full Screen Leaflet Map'),
        ),
        body: FullScreenMap(),
      ),
    );
  }
}

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'about:blank',
      javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
        _loadHtmlFromAssets();
      },
    );
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Leaflet Map</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
  <style>
    #map { width: 100vw; height: 100vh; }
  </style>
</head>
<body>
<div id="map"></div>
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script src="https://unpkg.com/leaflet-ajax/dist/leaflet.ajax.min.js"></script>
<script>
  var map = L.map('map').setView([35, 10], 7);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors'
  }).addTo(map);

  
</script>
</body>
</html>
    ''';

    _controller.loadUrl(Uri.dataFromString(
        fileHtmlContents,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
}
