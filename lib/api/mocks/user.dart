
import 'dart:convert';

mockUser() {
  return jsonEncode(
    {
      "list": [
        {
          "id": 1,
          "name": "Arnaud",
          "password": "000000",
          "avatar": "https://picsum.photos/200?random=1"
        },
        {
          "id": 2,
          "name": "Samuel",
          "password": "111111",
          "avatar": "https://picsum.photos/200?random=2"
        },
        {
          "id": 3,
          "name": "Marion",
          "password": "222222",
          "avatar": "https://picsum.photos/200?random=3"
        },
        {
          "id": 4,
          "name": "Claire",
          "password": "333333",
          "avatar": "https://picsum.photos/200?random=4"
        },
        {
          "id": 5,
          "name": "Nicolas",
          "password": "444444",
          "avatar": "https://picsum.photos/200?random=5"
        },
        {
          "id": 6,
          "name": "Frédéric",
          "password": "555555",
          "avatar": "https://picsum.photos/200?random=6"
        },
        {
          "id": 7,
          "name": "Guilhem",
          "password": "666666",
          "avatar": "https://picsum.photos/200?random=7"
        },
        {
          "id": 8,
          "name": "Marylou",
          "password": "777777",
          "avatar": "https://picsum.photos/200?random=8"
        },
        {
          "id": 9,
          "name": "Philippe",
          "password": "888888",
          "avatar": "https://picsum.photos/200?random=9"
        },
        {
          "id": 10,
          "name": "Alicia",
          "password": "999999",
          "avatar": "https://picsum.photos/200?random=10"
        },
        {
          "id": 11,
          "name": "Maxime",
          "password": "123456",
          "avatar": "https://picsum.photos/200?random=11"
        }
      ]
    }
  );
}