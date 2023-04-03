import 'dart:io';

import 'package:fastaval_app/utils/services/config_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String mapUrl = ConfigService().getRemoteConfig('MAP_URL');
const String assetName = 'assets/svg/Hobro_Idraetscenter_kort_23.svg';

class MapService {
  final Widget svg = SvgPicture.asset(
    assetName,
    colorBlendMode: BlendMode.clear,
  );

  final Widget networkSvg = SvgPicture.network(
    'https://site-that-takes-a-while.com/image.svg',
    semanticsLabel: 'A shark?!',
    placeholderBuilder: (BuildContext context) =>
        Container(padding: const EdgeInsets.all(30.0), child: const CircularProgressIndicator()),
  );

  Future<dynamic> getMaps() async {
    var maps = await http.get(Uri.parse(mapUrl));

    if (maps.statusCode == 200) {}
  }
}
