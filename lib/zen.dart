import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ZenPage extends StatelessWidget {
  final Function(String) onDateTimeReceived;
  const ZenPage({super.key, required this.onDateTimeReceived});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(title: Text("ZEN")),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
          ),
          onPressed: () {
            String endDateTime = DateFormat('yyyy-MM-dd – kk:mm:ss').format(DateTime.now());
            onDateTimeReceived(endDateTime);
            Navigator.pop(context);
          },
          child: SvgPicture.asset('assets/Enso.svg', // Replace with your asset path
            width: 150.0, // Optional, to set the width
            height: 150.0, // Optional, to set the height
          ),
        ),
      ),
    );
  }
}