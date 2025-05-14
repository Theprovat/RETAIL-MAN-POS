import 'dart:async';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../helpers/AppTheme.dart';
import '../helpers/SizeConfig.dart';
import '../helpers/otherHelpers.dart';
import '../locale/MyLocalizations.dart';
import '../models/paymentDatabase.dart';
import '../models/sell.dart';
import '../models/sellDatabase.dart';
import '../models/system.dart';
import 'login.dart';

class CheckOut extends StatefulWidget {
  @override
  CheckOutState createState() => CheckOutState();
}

class CheckOutState extends State<CheckOut> {
  List<Map> paymentMethods = [];
  int? sellId;
  double totalPaying = 0.0;
  String symbol = '',
      invoiceType = "Mobile",
      transactionDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  Map? argument;
  List<Map> payments = [],
      paymentAccounts = [
        {'id': null, 'name': "None"}
      ];
  List<int> deletedPaymentId = [];
  late Map<String, dynamic> paymentLine;
  List sellDetail = [];
  double invoiceAmount = 0.00, pendingAmount = 0.00, changeReturn = 0.00;
  TextEditingController dateController = new TextEditingController(),
      saleNote = new TextEditingController(),
      staffNote = new TextEditingController(),
      shippingDetails = new TextEditingController(),
      shippingCharges = new TextEditingController();
  bool _printInvoice = true,
      printWebInvoice = false,
      saleCreated = false,
      isLoading = false;
  static int themeType = 1;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(themeType);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(themeType);

  @override
  void initState() {
    super.initState();
    getInitDetails();
  }

  getInitDetails() async {
    setState(() {
      isLoading = true;
    });
    await Helper().getFormattedBusinessDetails().then((value) {
      symbol = value['symbol'];
    });
  }

  setPaymentAccounts() async {
    List payments =
        await System().get('payment_method', argument!['locationId']);
    await System().getPaymentAccounts().then((value) {
      value.forEach((element) {
        List<String> accIds = [];
        //check if payment account is assigned to any payment method
        // of selected location.
        payments.forEach((paymentMethod) {
          if ((paymentMethod['account_id'].toString() ==
                  element['id'].toString()) &&
              !accIds.contains(element['id'].toString())) {
            setState(() {
              paymentAccounts
                  .add({'id': element['id'], 'name': element['name']});
            });
          }
        });
      });
    });
  }

  @override
  void didChangeDependencies() {
    argument = ModalRoute.of(context)!.settings.arguments as Map?;
    invoiceAmount = argument!['invoiceAmount'];
    setPaymentAccounts().then((value) {
      if (argument!['sellId'] == null) {
        setPaymentDetails().then((value) {
          payments.add({
            'amount': invoiceAmount,
            'method': paymentMethods[0]['name'],
            'note': '',
            'account_id': paymentMethods[0]['account_id']
          });
          calculateMultiPayment();
        });
      } else {
        setPaymentDetails().then((value) {
          onEdit(argument!['sellId']);
        });
      }
    });
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    staffNote.dispose();
    saleNote.dispose();
    super.dispose();
  }

  onEdit(sellId) async {
    sellDetail = await SellDatabase().getSellBySellId(sellId);
    this.sellId = argument!['sellId'];
    await SellDatabase().getSellBySellId(sellId).then((value) {
      shippingCharges.text = value[0]['shipping_charges'].toString();
      shippingDetails.text = value[0]['shipping_details'] ?? '';
      saleNote.text = value[0]['sale_note'] ?? '';
      staffNote.text = value[0]['staff_note'] ?? '';
      invoiceAmount =
          argument!['invoiceAmount'] + double.parse(shippingCharges.text);
    });
    payments = [];
    List paymentLines = await PaymentDatabase().get(sellId, allColumns: true);
    paymentLines.forEach((element) {
      if (element['is_return'] == 0) {
        payments.add({
          'id': element['id'],
          'amount': element['amount'],
          'method': element['method'],
          'note': element['note'],
          'account_id': element['account_id']
        });
      }
    });
    calculateMultiPayment();
    if (this.mounted) {
      setState(() {});
    }
  }
