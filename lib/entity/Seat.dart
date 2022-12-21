import 'package:seat/enums/BerthType.dart';

class Seat {
  final int seatNumber;
  final BerthType berthType;
  final String colour;

  Seat(this.seatNumber, this.berthType, this.colour);
}
