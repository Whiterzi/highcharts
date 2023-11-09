import 'dart:html';
import 'dart:async';

import "dart:js";
import 'dart:js_util';


import 'package:rikulo_highcharts/rikulo_highcharts.dart';

void main() {
  if  (context['Highcharts'] == null) {
    Timer(const Duration(milliseconds: 50), main);
    return;
  }

  _main();
}

void _main() {
  final columnChart = ColumnChart(
      titleText: 'Monthly Average Rainfall',
      subtitleText: 'Source: WorldClimate.com');
  querySelector('#columnChart')?.append(columnChart.element);
  _renderColumnChart(columnChart);

  final pieChart = PieChart(
      titleText: 'Browser market shares in January, 2018');
  querySelector('#pieChart')?.append(pieChart.element);
  _renderPieChart(pieChart);

  final donutChart = DonutChart(
      titleText: 'Browser market share, January, 2018',
      subtitleText: 'Source: <a href="http://statcounter.com" target="_blank">statcounter.com</a>');
  querySelector('#donutChart')?.append(donutChart.element);
  _renderDonutChart(donutChart);


  final areaChart = AreaChart(
      titleText: 'US and USSR nuclear stockpiles',
      subtitleText: 'Sources: <a href="https://thebulletin.org/2006/july/global-nuclear-stockpiles-1945-2006">'
          'thebulletin.org</a> &amp; <a href="https://www.armscontrol.org/factsheets/Nuclearweaponswhohaswhat">armscontrol.org</a>');
  querySelector('#areaChart')?.append(areaChart.element);
  _renderAreaChart(areaChart);

  querySelector('#update-area')?.onClick.listen((event) {
    final chartSeries = areaChart.chartSeries;
    if (chartSeries.length > 1)
      chartSeries[1].remove();
    else {
      areaChart.addSeries(areaChart.series[1]);
    }
  });
}

void _renderColumnChart(ColumnChart chart) {
  final model = DefaultCategoryModel<String, String>();

  model.setValue("Tokyo", "Jan", 49.9);
  model.setValue("Tokyo", "Feb", 71.5);
  model.setValue("Tokyo", "Mar", 106.4);
  model.setValue("Tokyo", "Apr", 129.2);
  model.setValue("Tokyo", "May", 144.0);
  model.setValue("Tokyo", "Jun", 176.0);
  model.setValue("Tokyo", "Jul", 135.6);
  model.setValue("Tokyo", "Aug", 148.5);
  model.setValue("Tokyo", "Sep", 216.4);
  model.setValue("Tokyo", "Oct", 194.1);
  model.setValue("Tokyo", "Nov", 95.6);
  model.setValue("Tokyo", "Dec", 54.4);
  model.setValue("New York", "Jan", 83.6);
  model.setValue("New York", "Feb", 78.8);
  model.setValue("New York", "Mar", 98.5);
  model.setValue("New York", "Apr", 93.4);
  model.setValue("New York", "May", 106.0);
  model.setValue("New York", "Jun", 84.5);
  model.setValue("New York", "Jul", 105.0);
  model.setValue("New York", "Aug", 104.3);
  model.setValue("New York", "Sep", 91.2);
  model.setValue("New York", "Oct", 83.5);
  model.setValue("New York", "Nov", 106.6);
  model.setValue("New York", "Dec", 92.3);
  model.setValue("London", "Jan", 48.9);
  model.setValue("London", "Feb", 38.8);
  model.setValue("London", "Mar", 39.3);
  model.setValue("London", "Apr", 41.4);
  model.setValue("London", "May", 47.0);
  model.setValue("London", "Jun", 48.3);
  model.setValue("London", "Jul", 59.0);
  model.setValue("London", "Aug", 59.6);
  model.setValue("London", "Sep", 52.4);
  model.setValue("London", "Oct", 65.2);
  model.setValue("London", "Nov", 59.3);
  model.setValue("London", "Dec", 51.2);
  model.setValue("Berlin", "Jan", 42.4);
  model.setValue("Berlin", "Feb", 33.2);
  model.setValue("Berlin", "Mar", 34.5);
  model.setValue("Berlin", "Apr", 39.7);
  model.setValue("Berlin", "May", 52.6);
  model.setValue("Berlin", "Jun", 75.5);
  model.setValue("Berlin", "Jul", 57.4);
  model.setValue("Berlin", "Aug", 60.4);
  model.setValue("Berlin", "Sep", 47.6);
  model.setValue("Berlin", "Oct", 39.1);
  model.setValue("Berlin", "Nov", 46.8);
  model.setValue("Berlin", "Dec", 51.1);

  chart.xAxis = ChartXAxis(crosshair: true);
  chart.yAxis = ChartYAxis(
      min: 0,
      title: ChartTitle(
        text: 'Rainfall (mm)'
      ));

  chart.plotOptions = ChartPlotOptions(
      column: ColumnPlotOptions(
        pointPadding: 0.2,
        borderWidth: 0,
        events: EventPlotOptions(legendItemClick: jsFunction((self, _) {
          print(getProperty(self, 'color'));
        }))));

  chart.tooltip = ChartTooltip(
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
          '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
      footerFormat: '</table>',
      shared: true,
      useHTML: true
  );

  chart.model = model;
  chart.update();
}

void _renderPieChart(PieChart chart) {
  final model = DefaultSingleValueCategoryModel<String>();

  model.setValue("Firefox", 45.0);
  model.setValue("IE", 26.8);
  model.setValue("Chrome", 12.8);
  model.setValueStyle("Chrome", SeriesStyle.sliced, true);
  model.setValueStyle("Chrome", SeriesStyle.selected, true);

  model.setValue("Safari", 8.5);
  model.setValue("Opera", 6.2);
  model.setValue("Others", 0.7);

  model.setSingleSeriesStyle(SeriesStyle.colorByPoint, true);



  chart.tooltip = ChartTooltip(
      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>');

  chart.accessibility = ChartAccessibility(
      point: ChartAccessibilityPoint(valueSuffix: '%..'));

  chart.plotOptions = ChartPlotOptions(
      pie: PiePlotOptions(
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: ChartDataLabels(enabled: false),
        showInLegend: true,
        showCheckbox: true,
        events: EventPlotOptions(checkboxClick: jsFunction((self, event) {
          print('${getProperty(self, 'name')} ${getProperty(getProperty(event, 'item'), 'name')} ${getProperty(event, 'checked')}');
        }))));

  chart.model = model;
  chart.update();
}

void _renderDonutChart(DonutChart chart) {
  final colors = Highcharts.getOptions().colors,
    model = DefaultDonutModel<String, String>(),
    innerBrowserModel = DefaultSingleValueCategoryModel<String>(),
    innerVersionModel = DefaultSingleValueCategoryModel<String>(),
    browsers = {
      "MSIE": 55.11,
      "Firefox": 21.63,
      "Chrome": 11.94,
      "Opera": 2.14},
    versions = <String, Map<String, num>>{
      "MSIE": {
        "MSIE 6.0": 10.85,
        "MSIE 7.0": 10.85,
        "MSIE 8.0": 10.85,
        "MSIE 9.0": 10.85,
      },
      "Firefox": {
        "Firefox 2.0": 0.20,
        "Firefox 3.0": 0.83,
        "Firefox 3.5": 1.58,
        "Firefox 3.6": 13.12,
        "Firefox 4.0": 5.43,
      },
      "Chrome": {
        "Chrome 5.0": 0.12,
        "Chrome 6.0": 0.19,
        "Chrome 7.5": 0.12,
        "Chrome 8.6": 0.36,
        "Chrome 9.0": 0.32,
        "Chrome 10.0": 9.91,
        "Chrome 11.0": 0.50,
        "Chrome 12.0": 0.22,
      },
      "Opera": {
        "Opera 9.x": 0.12,
        "Opera 10.x": 0.37,
        "Opera 11.x": 1.65,
      },
    };

  var i = 0;
  for (final browserEntry in browsers.entries) {
    final key = browserEntry.key;

    innerBrowserModel.setValue(key, browserEntry.value);
    innerBrowserModel.setValueColor(key, colors[i]);

    for (final versionEntry in versions[key]!.entries) {
      final key = versionEntry.key;
      innerVersionModel.setValue(key, versionEntry.value);
      innerVersionModel.setValueColor(key, colors[i]);
    }
    i++;
  }

  chart.plotOptions = ChartPlotOptions(
      pie: PiePlotOptions(shadow: false,
          center: ['50%', '50%'],
          events: EventPlotOptions(click: jsFunction((self, _) {
            print(getProperty(self, 'name'));
          }))));

  chart.tooltip = ChartTooltip(valueSuffix: '%');

  model.addSeries("Browsers", innerBrowserModel);
  model.addSeries("Versions", innerVersionModel);

  model.setSeriesStyle("Browsers", SeriesStyle.size, '60%');
  model.setSeriesStyle("Browsers", SeriesStyle.dataLabels, ChartDataLabels(
      formatter: jsFunction((self, _) {
        final y = getProperty(self, 'y');
        return y is num && y > 5 ?
          getProperty(getProperty(self, 'point'), 'name'): null;
      }),
    color: '#ffffff',
    distance: -30
  ));

  model.setSeriesStyle("Versions", SeriesStyle.size, '80%');
  model.setSeriesStyle("Versions", SeriesStyle.innerSize, '60%');
  model.setSeriesStyle("Versions", SeriesStyle.dataLabels, ChartDataLabels(
      formatter: jsFunction((self, _) {
        final y = getProperty(self, 'y');
        // display only if larger than 1
        return y is num && y > 1 ?
          '<b>${getProperty(getProperty(self, 'point'), 'name')}</b> $y%': null;
      }),
  ));

  chart.model = model;
  chart.update();
}

void _renderAreaChart(AreaChart chart) {
  final model = DefaultCategoryModel<String, num>(),
    usaData = <num?>[
      null, null, null, null, null, 6, 11, 32, 110, 235,
      369, 640, 1005, 1436, 2063, 3057, 4618, 6444, 9822, 15468,
      20434, 24126, 27387, 29459, 31056, 31982, 32040, 31233, 29224, 27342,
      26662, 26956, 27912, 28999, 28965, 27826, 25579, 25722, 24826, 24605,
      24304, 23464, 23708, 24099, 24357, 24237, 24401, 24344, 23586, 22380,
      21004, 17287, 14747, 13076, 12555, 12144, 11009, 10950, 10871, 10824,
      10577, 10527, 10475, 10421, 10358, 10295, 10104, 9914, 9620, 9326,
      5113, 5113, 4954, 4804, 4761, 4717, 4368, 4018
    ],
    ussrData = <num?>[
      null, null, null, null, null, null, null, null, null, null,
      5, 25, 50, 120, 150, 200, 426, 660, 869, 1060,
      1605, 2471, 3322, 4238, 5221, 6129, 7089, 8339, 9399, 10538,
      11643, 13092, 14478, 15915, 17385, 19055, 21205, 23044, 25393, 27935,
      30062, 32049, 33952, 35804, 37431, 39197, 45000, 43000, 41000, 39000,
      37000, 35000, 33000, 31000, 29000, 27000, 25000, 24000, 23000, 22000,
      21000, 20000, 19000, 18000, 18000, 17000, 16000, 15537, 14162, 12787,
      12600, 11400, 5500, 4512, 4502, 4502, 4500, 4500
    ];

  var pointStart = 1940;
  for (final value in usaData) {
  model.setValue("USA", pointStart++, value);
  }

  pointStart = 1940;
  for (final value in ussrData) {
    model.setValue("USSR/Russia", pointStart++, value);
  }

  chart.xAxis = ChartXAxis(
    allowDecimals: false,
    labels: ChartLabels(formatter: jsFunction((self) {
      return getProperty(self, 'value');// clean, unformatted number for year
    })),
    accessibility: ChartAccessibility(
      rangeDescription: 'Range: 1940 to 2017.'));

  chart.yAxis = ChartYAxis(
    title: ChartTitle(
      text: 'Nuclear weapon states'),
    labels: ChartLabels(formatter: jsFunction((self) {
        return '${(getProperty(self, 'value') as num)/1000}k';
    })));


  chart.tooltip = ChartTooltip(
    pointFormat: '{series.name} had stockpiled <b>{point.y:,.0f}</b><br/>warheads in {point.x}');

  chart.plotOptions = ChartPlotOptions(
    area: AreaPlotOptions(
      pointStart: 1940,
      marker: ChartMarker(
        enabled: false,
        symbol: 'circle',
        radius: 2,
        states: ChartStates(
          hover: ChartHover(enabled: true))),
      events: EventPlotOptions(legendItemClick: jsFunction((self, _) {
        print(getProperty(self, 'color'));
      }))));

  chart.model = model;
  chart.update();
}