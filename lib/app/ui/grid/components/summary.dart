import 'package:f1_application/lib/service/grid/grid_service.dart';
import 'package:f1_application/util/build_blur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'nation.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Container(
          width: screenSize.width * 0.9,
          height: 2,
          color: const Color(0xff000000),
        ),
        const SizedBox(
          height: 20,
        ),
        buildBlur(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Color(0x88000000)
            ),
            child: Column(
              children: [
                const Text(
                  "Summary",
                  style: TextStyle(
                      fontFamily: "OleoScript",
                      fontSize: 92,
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
                _nations()
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _nations() {
    final gridService = Provider.of<GridService>(context);

    if (gridService.isGridFetching) {
      return Container();
    }

    List<Widget> nationList = gridService.nationsSummary().entries.map<Widget>((entry) => Nation(entry.key, entry.value)).toList();

    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: nationList,
      );
  }
}
