// import 'package:linegitud/models/line.dart';

import 'dart:convert';

mockLine() {
  return jsonEncode(
    {
      "list": [
        {
          "id": 1,
          "reason": "Sexisme",
          "sender": "Arnaud",
          "recipient": "Marion",
          "state": "validated",
          "created_at": "2024-09-01 10:58:35"
        }, 
        {
          "id": 2,
          "reason": "Racisme",
          "sender": "Nicolas",
          "recipient": "Samuel",
          "state": "validated",
          "created_at": "2024-10-02 01:02:03"
        },
        {
          "id": 3,
          "reason": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu tristique mi, eu volutpat quam. Duis pharetra, ex sed vehicula auctor, nisl tellus tristique dui, quis feugiat arcu justo et quam. Curabitur cursus, nunc vel euismod accumsan, nulla dui maximus lectus, viverra dapibus augue sem eget leo. Vivamus lacus nisl, blandit in pellentesque sit amet, fringilla ac nibh. Mauris fringilla eros libero, sollicitudin pulvinar purus sodales vel. Duis vel sapien sed turpis accumsan pulvinar a vitae mi. Duis sodales eleifend rhoncus. Morbi tellus ligula, imperdiet condimentum risus nec, euismod hendrerit sem. Nullam ac ex nec mi elementum dapibus tristique ut enim. Fusce tempus iaculis risus, sit amet elementum magna blandit nec. Mauris gravida consectetur elit at ultrices. Donec faucibus ante sit amet quam feugiat bibendum. Phasellus dignissim rhoncus massa in placerat. Aenean eget ex sit amet urna gravida venenatis.",
          "sender": "Samuel",
          "recipient": "Nicolas",
          "state": "validated",
          "created_at": "2024-11-03 05:58:12"
        },
        {
          "id": 4,
          "reason": "Aucune raison",
          "sender": "Frédéric",
          "recipient": "Claire",
          "state": "cancelled",
          "created_at": "2024-08-31 12:01:51"
        },
        {
          "id": 5,
          "reason": "Aucune raison",
          "sender": "Frédéric",
          "recipient": "Marion",
          "state": "validated",
          "created_at": "2024-08-31 12:01:51"
        }
      ] 
    }
  );
}