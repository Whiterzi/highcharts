# highcharts

highcharts is a wrapper of [Highcharts](https://www.highcharts.com) in Dart.

* [API Reference](https://pub.dev/documentation/rikulo_highcharts/latest/)
* [Git Repository](https://github.com/rikulo/highcharts)
* [Issues](https://github.com/rikulo/highcharts/issues)

## Install from Dart Pub Repository

Include the following in your `pubspec.yaml`:

    dependencies:
      rikulo_highcharts: any

Then run the [Pub Package Manager](http://pub.dartlang.org/doc) in Dart Editor (Tool > Pub Install). If you are using a different editor, run the command
(comes with the Dart SDK):

    pub install

## Usage

Add this lines to the main html of your application (index.html) in the head section.
```
<script src="your-js-lib/highcharts.js"></script>
```

You can create a chart object and chart model.

    import 'dart:html';
    import 'package:rikulo_highcharts/rikulo_highcharts.dart';

    main() {
      ColumnChart chart = new ColumnChart();
      querySelector('#cnt').append(chart.element);

      CategoryModel<String, String> model = new DefaultCategoryModel<String, String>();
      model.setValue('Tokyo', 'Jan', 16);
	  model.setValue('Tokyo', 'Feb', 6);
	  model.setValue('Tokyo', 'Mar', 6);
	  model.setValue('Tokyo', 'Apr', 3);

	  model.setValue('New York', 'Jan', 18);
	  model.setValue('New York', 'Feb', 12);
	  model.setValue('New York', 'Mar', 9);
	  model.setValue('New York', 'Apr', 14);

	  chart.model = model;
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/rikulo/highcharts/issues

## Who Uses

* [Quire](https://quire.io) - a simple, collaborative, multi-level task management tool.
