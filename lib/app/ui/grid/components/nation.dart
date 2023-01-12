import 'package:f1_application/util/countries.dart' as country;

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class Nation extends StatelessWidget {
  final String nation;
  final int? number;

  const Nation(this.nation, this.number, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Size flagSize = const Size(45, 45);

    return Container(
      width: screenSize.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flag.fromCode(
            country.Countries.getByNationality(nation)["flagsCode"],
            height: flagSize.height,
            width: flagSize.width,
          ),
          Text(
            "${country.Countries.getByNationality(nation)["name"]}",
            style: const TextStyle(
                fontSize: 26,
                color: Color(0xffffffff),
                shadows: [
                  Shadow(color: Color(0xff000000),
                      offset: Offset(2, 2),
                      blurRadius: 5),
                  Shadow(color: Color(0x88000000),
                      offset: Offset(1, 1),
                      blurRadius: 7),
                  Shadow(color: Color(0x22000000),
                      offset: Offset(0, 0),
                      blurRadius: 10),
                ]
            ),
          ),
          Text(
            number.toString(),
            style: const TextStyle(
                fontSize: 28,
                color: Color(0xffffffff),
                shadows: [
                  Shadow(color: Color(0xff000000),
                      offset: Offset(2, 2),
                      blurRadius: 5),
                  Shadow(color: Color(0x88000000),
                      offset: Offset(1, 1),
                      blurRadius: 7),
                  Shadow(color: Color(0x22000000),
                      offset: Offset(0, 0),
                      blurRadius: 10),
                ]
            ),
          ),
        ],
      ),
    );
  }
}
