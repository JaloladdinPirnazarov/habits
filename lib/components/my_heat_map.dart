import '../utils/importer.dart';

class MyHeatMap extends StatelessWidget {
  final DateTime startDate;
  final Map<DateTime, int> dataSets;
  const MyHeatMap({super.key, required this.startDate, required this.dataSets});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: HeatMap(
            startDate: startDate,
            endDate: DateTime.now(),
            datasets: dataSets,
            colorMode: ColorMode.color,
            defaultColor: Theme.of(context).colorScheme.primary,
            textColor: Colors.white,
            showColorTip: false,
            showText: true,
            size: 30,
            colorsets: {
              1: Colors.green.shade200,
              2: Colors.green.shade300,
              3: Colors.green.shade400,
              4: Colors.green.shade500,
              5: Colors.green.shade600,
              6: Colors.green.shade800,
              7: Colors.green.shade900,
            }),
      )
    );
  }
}
