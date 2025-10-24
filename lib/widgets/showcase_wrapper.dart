import 'package:device_frame/device_frame.dart';
import 'package:ezak/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ShowcaseWrapper extends StatelessWidget{
  final Widget body;
  const ShowcaseWrapper(this.body, {super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Nieoficjalna aplikacja do przeglądania", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
                      Text("planu zajęć PANS w Nysie", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),

                    ],
                  ),
                  Text("Pobierz na Androida", style: TextStyle(fontWeight: FontWeight.bold),),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200, maxWidth:  200),
                    child: PrettyQrView.data(
                      data: Constants.googlePlayUrl.toString(),
                    ),
                  ),
                  Text("lub odwiedź na ezak.pages.dev", style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
              DeviceFrame(device: Devices.android.googlePixel9ProXL, screen: body),
            ],
          ),
        ),
      ),
    );
  }

}