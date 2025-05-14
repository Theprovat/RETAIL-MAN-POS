import 'dart:ui';

// import 'package:call_log/call_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../apis/api.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../apis/shipment.dart';
import '../helpers/AppTheme.dart';
import '../helpers/SizeConfig.dart';
import '../locale/MyLocalizations.dart';
import '../models/contact_model.dart';
import '../models/shipment.dart';
import '../models/system.dart';
// import 'googleMap.dart';

class Shipment extends StatefulWidget {
  @override
  _ShipmentState createState() => _ShipmentState();
}

class _ShipmentState extends State<Shipment> {
  List<String>? shipmentStatus;
  DateTime selectedDate = DateTime.now();
  String? nextPage = '', selectedStatus = '', selectedInlineStatus;
  List<dynamic> shipments = [];
  TextEditingController deliveredToController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

  static int themeType = 1;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(themeType);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(themeType);

  @override
  void initState() {
    super.initState();
    shipmentStatus = ShipmentModel().shipmentStatus;
    selectedStatus = shipmentStatus![0];
    getShipments();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        generateShipmentList();
      }
    });
  }

  getShipments() async {
    var date = selectedDate.toLocal().toString().split(' ')[0];
    nextPage = Api().apiUrl +
        "sell/?start_date=$date"
            "&shipping_status=$selectedStatus";
    generateShipmentList();
  }

  @override
  void dispose() {
    super.dispose();
    deliveredToController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(AppLocalizations.of(context).translate('shipment'),
            style: AppTheme.getTextStyle(themeData.textTheme.headline6,
                fontWeight: 600)),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MySize.size20!,
                  top: MySize.size5!,
                  bottom: MySize.size10!),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  status(), shipmentDatePicker(),
                  // locateShipments()
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: shipments.length,
                itemBuilder: (context, index) {
                  return block(index, shipments[index]['id'],
                      invoiceNo: shipments[index]['invoice_no'],
                      date: shipments[index]['transaction_date'],
                      customerName: shipments[index]['customerName'],
                      status: shipments[index]['shipping_status'],
                      deliverTo: shipments[index]['delivered_to'],
                      contactNo: shipments[index]['contact_no']);
                })
          ],
        ),
      ),
    );
  }

  //locate shipments in map
  Widget locateShipments() {
    return TextButton(
      style: TextButton.styleFrom(
        shape: StadiumBorder(side: BorderSide(color: customAppTheme.bgLayer3)),
      ),
      onPressed: () => Navigator.pushNamed(context, '/google_map'),
      child: Text('Map',
          style: AppTheme.getTextStyle(themeData.textTheme.subtitle1,
              color: themeData.colorScheme.onBackground)),
    );
  }

  //date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        shipments = [];
        getShipments();
      });
  }

  //widget shipment
  Widget status() {
    return PopupMenuButton(
        onSelected: (String? item) {
          setState(() {
            selectedStatus = item;
            shipments = [];
            getShipments();
          });
        },
        itemBuilder: (BuildContext context) {
          return shipmentStatus!.map((String value) {
            return PopupMenuItem(
              value: value,
              height: MySize.size36!,
              child: Text(value,
                  style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                      color: themeData.colorScheme.onBackground)),
            );
          }).toList();
        },
        color: themeData.backgroundColor,
        child: Container(
          padding: EdgeInsets.only(
              left: MySize.size12!,
              right: MySize.size12!,
              top: MySize.size8!,
              bottom: MySize.size8!),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(MySize.size20!)),
            color: customAppTheme.bgLayer1,
            border: Border.all(color: customAppTheme.bgLayer3),
          ),
          child: Row(
            children: <Widget>[
              Text(
                selectedStatus!,
                style: AppTheme.getTextStyle(
                  themeData.textTheme.bodyText1,
                  color: themeData.colorScheme.onBackground,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: MySize.size4!),
                child: Icon(
                  MdiIcons.chevronDown,
                  size: MySize.size22,
                  color: themeData.colorScheme.onBackground,
                ),
              )
            ],
          ),
        ));
  }

  //inline status
  //widget shipment
  Widget inlineStatus() {
    return PopupMenuButton(
      onSelected: (String? item) {
        setState(() {
          selectedInlineStatus = item;
        });
      },
      itemBuilder: (BuildContext context) {
        return shipmentStatus!.map((String value) {
          return PopupMenuItem(
            value: value,
            height: MySize.size36!,
            child: Text(value,
                style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                    color: themeData.colorScheme.onBackground)),
          );
        }).toList();
      },
      color: themeData.backgroundColor,
      child: Container(
        padding: EdgeInsets.only(
            left: MySize.size12!,
            right: MySize.size12!,
            top: MySize.size8!,
            bottom: MySize.size8!),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
          color: customAppTheme.bgLayer1,
          border: Border.all(color: customAppTheme.bgLayer3, width: 1),
        ),
        child: Row(
          children: <Widget>[
            Text(
              selectedInlineStatus!,
              style: AppTheme.getTextStyle(
                themeData.textTheme.bodyText1,
                color: themeData.colorScheme.onBackground,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: MySize.size4!),
              child: Icon(
                MdiIcons.chevronDown,
                size: MySize.size22,
                color: themeData.colorScheme.onBackground,
              ),
            )
          ],
        ),
      ),
    );
  }
