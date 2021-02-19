import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:khatu/model/Model.dart';

Future<MyModel> getBookings() async {
  MyModel model;
  String url = 'https://parsehub.com/api/v2/projects/tkHjO9T0spf1/last_ready_run/data?api_key=t-R-9Azs1SU1';
  int x = Random().nextInt(3);
  print('x' + x.toString());
  if (x == 2) {
    print("POST");
    var q = await http.post('https://parsehub.com/api/v2/projects/tkHjO9T0spf1/run?api_key=t-R-9Azs1SU1');
    print(q.body);
  }
  var req = await http.get(url);
  print(req.body);

  if (req.statusCode != 200) {
    // TODO:ERROR
  } else {
    var body = json.decode(req.body);
    model = MyModel.fromMap(body);
    print(model.selection2.length);
  }
  return model;
}
