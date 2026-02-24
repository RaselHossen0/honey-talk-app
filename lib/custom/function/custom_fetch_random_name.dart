import 'dart:math';

class CustomFetchRandomName {
  static String onGet() {
    List<String> randomNames = [
      "Emily Johnson",
      "Liam Smith",
      "Isabella Martinez",
      "Noah Brown",
      "Sofia Davis",
      "Oliver Wilson",
      "Mia Anderson",
      "James Thomas",
      "Ava Robinson",
      "Benjamin Lee",
      "Charlotte Miller",
      "Lucas Garcia",
      "Amelia White",
      "Ethan Harris",
      "Harper Clark",
      "Alexander Lewis",
      "Evelyn Walker",
      "Daniel Hall",
      "Grace Young",
      "Michael Allen",
      "Samuel Scott",
      "Victoria Nelson",
      "David Adams",
      "Chloe Baker",
      "Henry Carter",
      "Madison Rogers",
      "Sebastian Murphy",
      "Ella Reed",
      "Jack Peterson",
      "Scarlett Brooks",
      "William Bennett",
      "Lily Rivera",
      "Joseph Foster",
      "Zoe Coleman",
      "Matthew Kelly",
      "Natalie Bailey",
      "Elijah Richardson",
      "Hannah Perry",
      "Mason Cox",
      "Layla Ramirez",
      "Logan Gray",
      "Aubrey Cooper",
      "Jayden Howard",
      "Aria Torres",
      "Gabriel Ward",
      "Lillian Bell",
      "Carter Mitchell",
      "Penelope Perez",
      "Dylan Parker",
      "Riley Evans"
    ];

    Random random = Random();
    return randomNames[random.nextInt(randomNames.length)];
  }
}
