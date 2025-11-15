import 'dart:io';

import 'package:ezak/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<void> useLocalCert() async{
  if(defaultTargetPlatform.isMobile()) {
    final data = await rootBundle.load("assets/intermediate_ca.crt");
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }
}