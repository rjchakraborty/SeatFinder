import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:seat/entity/Seat.dart';
import 'package:seat/enums/BerthType.dart';
import 'package:seat/utils/AppConstants.dart';
import 'package:seat/utils/CommonUtils.dart';
import 'package:seat/utils/HexColor.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Seat> seats = [];
  static const int TOTAL_SEATS = 72;
  static const int SEATS_EACH_BERTH = 8;
  static const int SEATS_MAIN = 6;
  static const int SEATS_SIDE = 2;

  String? query;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ItemScrollController _scrollController = ItemScrollController();

  initSeatsData() {
    seats = [];
    for (int s = 1; s <= TOTAL_SEATS; s++) {
      BerthType berthType = BerthType.SIDE_UPPER;
      String colour = SIDE_UPPER_BERTH_HEX;
      if (s % SEATS_EACH_BERTH == 1 || s % SEATS_EACH_BERTH == 4) {
        berthType = BerthType.LOWER;
        colour = LOWER_BERTH_HEX;
      } else if (s % SEATS_EACH_BERTH == 2 || s % SEATS_EACH_BERTH == 5) {
        berthType = BerthType.MIDDLE;
        colour = MIDDLE_BERTH_HEX;
      } else if (s % SEATS_EACH_BERTH == 3 || s % SEATS_EACH_BERTH == 6) {
        berthType = BerthType.UPPER;
        colour = UPPER_BERTH_HEX;
      } else if (s % SEATS_EACH_BERTH == 7) {
        berthType = BerthType.SIDE_LOWER;
        colour = SIDE_LOWER_BERTH_HEX;
      } else {
        berthType = BerthType.SIDE_UPPER;
        colour = SIDE_UPPER_BERTH_HEX;
      }
      seats.add(Seat(s, berthType, colour));
    }
    if (mounted) setState(() {});
  }

  getSeatingArrangement() {
    if (seats.isNotEmpty) {
      int count = TOTAL_SEATS ~/ SEATS_EACH_BERTH;

      return ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        itemCount: count,
        itemBuilder: (context, mainIndex) {
          return Container(
            height: 125,
            padding: EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  height: 125,
                  width: 185,
                  margin: EdgeInsets.only(right: 10),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    childAspectRatio: 1.0,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: SEATS_MAIN ~/ 2,
                    children: List.generate(SEATS_MAIN, (index) {
                      var mIndex = (mainIndex * SEATS_EACH_BERTH) + index;
                      return Container(
                        height: 52,
                        width: 50,
                        decoration: BoxDecoration(color: HexColor.getColor(seats[mIndex].colour), borderRadius: BorderRadius.all(Radius.circular(4))),
                        alignment: (index < 3) ? Alignment.topCenter : Alignment.bottomCenter,
                        margin: (index < 3) ? EdgeInsets.only(bottom: 10, right: 5, left: 5) : EdgeInsets.only(top: 10, right: 5, left: 5),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: (CommonUtils.checkIfNotNull(query) && query == seats[mIndex].seatNumber.toString())
                                  ? HexColor.getColor(PRIMARY_DARK_COLOR_HEX)
                                  : HexColor.getColor(PRIMARY_LIGHT_COLOR_HEX),
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(seats[mIndex].seatNumber.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FONT_MEDIUM,
                                    fontSize: 14,
                                    color: (CommonUtils.checkIfNotNull(query) && query == seats[mIndex].seatNumber.toString())
                                        ? Colors.white
                                        : HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(seats[mIndex].berthType.toTitleString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FONT_REGULAR,
                                      fontSize: 10,
                                      color: (CommonUtils.checkIfNotNull(query) && query == seats[mIndex].seatNumber.toString())
                                          ? Colors.white
                                          : HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Spacer(),
                Container(
                  height: 125,
                  width: 51,
                  margin: EdgeInsets.only(left: 10),
                  child: GridView.count(
                    childAspectRatio: .83,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: SEATS_SIDE ~/ 2,
                    children: List.generate(SEATS_SIDE, (index) {
                      var sIndex = (mainIndex * SEATS_EACH_BERTH) + SEATS_MAIN + index;
                      return Container(
                        height: 52,
                        width: 50,
                        decoration: BoxDecoration(color: HexColor.getColor(seats[sIndex].colour), borderRadius: BorderRadius.all(Radius.circular(4))),
                        alignment: (index == 0) ? Alignment.topCenter : Alignment.bottomCenter,
                        margin: (index == 0) ? EdgeInsets.only(bottom: 10) : EdgeInsets.only(top: 10),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: (CommonUtils.checkIfNotNull(query) && query == seats[sIndex].seatNumber.toString())
                                  ? HexColor.getColor(PRIMARY_DARK_COLOR_HEX)
                                  : HexColor.getColor(PRIMARY_LIGHT_COLOR_HEX),
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(seats[sIndex].seatNumber.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FONT_MEDIUM,
                                    fontSize: 14,
                                    color: (CommonUtils.checkIfNotNull(query) && query == seats[sIndex].seatNumber.toString())
                                        ? Colors.white
                                        : HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(seats[sIndex].berthType.toTitleString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FONT_REGULAR,
                                      fontSize: 10,
                                      color: (CommonUtils.checkIfNotNull(query) && query == seats[sIndex].seatNumber.toString())
                                          ? Colors.white
                                          : HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
        },
      );
    }
    return Container();
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) initSeatsData();
    });
  }

  scrollToItem() {
    if (seats != null && seats.isNotEmpty) {
      int seatNumber = CommonUtils.getInt(query);
      if (seatNumber > 0 && seatNumber <= TOTAL_SEATS && seats.length > (seatNumber - 1)) {
        int berth = (seatNumber / SEATS_EACH_BERTH).ceil();
        _scrollController.scrollTo(index: (berth > 1) ? (berth - 1) : 0, duration: Duration(milliseconds: 500));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Seat Finder',
            maxLines: 1,
            style: TextStyle(color: HexColor.getColor(PRIMARY_COLOR_HEX), fontSize: 20, fontFamily: FONT_BOLD),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: HexColor.getColor(PRIMARY_COLOR_HEX).withOpacity(.2), blurRadius: 40, offset: Offset(0, 10))]),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    onChanged: (text) {
                      query = text;
                      if (mounted) setState(() {});
                      scrollToItem();
                    },
                    onSubmitted: (value) {
                      query = value;
                      if (mounted) setState(() {});
                      scrollToItem();
                    },
                    keyboardType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: true) : TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(width: 1, color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(width: 1, color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      hintText: 'Enter seat number...',
                      labelText: 'Search Seat',
                      hintStyle: TextStyle(color: HexColor.getColor(PRIMARY_COLOR_HEX), fontSize: 13, fontFamily: 'MontserratMedium'),
                      labelStyle: TextStyle(color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX), fontSize: 15, fontFamily: 'MontserratMedium'),
                    ),
                  ),
                ),
                Expanded(child: getSeatingArrangement()),
              ],
            )),
      ),
    );
  }
}
