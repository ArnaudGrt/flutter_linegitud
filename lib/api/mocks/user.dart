
import 'dart:convert';

mockUser() {
  return jsonEncode(
    {
      "list": [
        {
          "id": 1,
          "name": "Arnaud",
          "password": "000000",
          "icon": "sports_martial_arts"
        },
        {
          "id": 2,
          "name": "Samuel",
          "password": "111111",
          "icon": "sports_handball"
        },
        {
          "id": 3,
          "name": "Marion",
          "password": "222222",
          "icon": "sports_gymnastics"
        },
        {
          "id": 4,
          "name": "Claire",
          "password": "333333",
          "icon": "sports_bar"
        },
        {
          "id": 5,
          "name": "Nicolas",
          "password": "444444",
          "icon": "sports_rugby"
        },
        {
          "id": 6,
          "name": "Frédéric",
          "password": "555555",
          "icon": "sports_tennis"
        }
      ]
    }
  );
}