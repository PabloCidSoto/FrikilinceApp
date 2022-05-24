/// Vertical bar chart with bar label renderer example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:proyectofinal/models/orders_model.dart';
import 'package:flutter/src/painting/basic_types.dart' as basic;


class VerticalBarLabelChart extends StatelessWidget {
  

  VerticalBarLabelChart();

  /// Creates a [BarChart] with sample data and no transition.
  

  // [BarLabelDecorator] will automatically position the label
  // inside the bar if the label will fit. If the label will not fit,
  // it will draw outside of the bar.
  // Labels can always display inside or outside using [LabelPosition].
  //
  // Text style for inside / outside can be controlled independently by setting
  // [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  @override
  Widget build(BuildContext context) {
    final List<OrdersModel>? orders = ModalRoute.of(context)!.settings.arguments as List<OrdersModel>?;
    final List<charts.Series<dynamic,String>>? seriesList = _createSampleData(orders!);
    final bool? animate;  

    return Scaffold(
      appBar: AppBar(title: Text("Gráfico anual"), backgroundColor: basic.Color.fromRGBO(1, 161, 16, 1)),
      body: charts.BarChart(
        seriesList!,
        animate: true,
        // Set a bar label decorator.
        // Example configuring different styles for inside/outside:
        //       barRendererDecorator: new charts.BarLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        barRendererDecorator: charts.BarLabelDecorator<String>(),
        domainAxis: charts.OrdinalAxisSpec(),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Orders, String>> _createSampleData(List<OrdersModel> orders) {
    int ene = 0;
    int feb = 0;
    int mar = 0;
    int abr = 0;
    int may = 0;
    int jun = 0;
    int jul = 0;
    int ago = 0;
    int sep = 0;
    int oct = 0;
    int nov = 0;
    int dic = 0;

    for(int i = 0; i < orders.length; i++){
      switch (orders[i].createdAt!.month) {
        case 1:
          ene++;
          break;
        case 2:
          feb++;
          break;
        case 3:
          mar++;
          break;
        case 4:
          abr++;
          break;
        case 5:
          may++;
          break;
        case 6:
          jun++;
          break;
        case 7:
          jul++;
          break;
        case 8:
          ago++;
          break;
        case 9:
          sep++;
          break;
        case 10:
          oct++;
          break;
        case 11:
          nov++;
          break;
        case 12:
          dic++;
          break;
        default:
      }
    }

    final data = [
      Orders('ENE', ene),
      Orders('FEB', feb),
      Orders('MAR', mar),
      Orders('ABR', abr),
      Orders('MAY', may),
      Orders('JUN', jun),
      Orders('JUL', jul),
      Orders('AGO', ago),
      Orders('SEP', sep),
      Orders('OCT', oct),
      Orders('NOV', nov),
      Orders('DIC', dic),
    ];

    return [
      charts.Series<Orders, String>(
          id: 'Pedidos',
          domainFn: (Orders sales, _) => sales.month,
          measureFn: (Orders sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (Orders sales, _) =>
              '${sales.sales.toString()}')
    ];
  }
}

/// Sample ordinal data type.
class Orders {
  final String month;
  final int sales;

  Orders(this.month, this.sales);
}