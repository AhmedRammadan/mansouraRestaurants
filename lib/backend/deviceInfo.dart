

import 'package:device_id/device_id.dart';

Future<String> getDeviceID() async {
  return await  DeviceId.getID;
}