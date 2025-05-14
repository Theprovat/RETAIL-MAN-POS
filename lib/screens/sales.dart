import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:search_choices/search_choices.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../apis/api.dart';
import '../apis/sell.dart';
import '../helpers/AppTheme.dart';
import '../helpers/SizeConfig.dart';
import '../helpers/otherHelpers.dart';
import '../locale/MyLocalizations.dart';
import '../models/contact_model.dart';
import '../models/paymentDatabase.dart';
import '../models/sell.dart';
import '../models/sellDatabase.dart';
import '../models/system.dart';
import '../pages/login.dart';
import 'elements.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List sellList = [];
  List<String> paymentStatuses = ['all'], invoiceStatuses = ['final', 'draft'];
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false,
      synced = true,
      canViewSell = false,
      canEditSell = false,
      canDeleteSell = false,
      showFilter = false,
      changeUrl = false;
  Map<dynamic, dynamic> selectedLocation = {'id': 0, 'name': 'All'},
      selectedCustomer = {'id': 0, 'name': 'All', 'mobile': ''};
  String selectedPaymentStatus = '';
  String? startDateRange, endDateRange; // selectedInvoiceStatus = 'all';
  List<Map<dynamic, dynamic>> allSalesListMap = [],
      customerListMap = [
        {'id': 0, 'name': 'All', 'mobile': ''}
      ],
      locationListMap = [
        {'id': 0, 'name': 'All'}
      ];
  String symbol = '';
  String? nextPage = '', url = Api().apiUrl + "sell?order_by_date=desc";
  static int themeType = 1;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(themeType);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(themeType);

  @override
  void initState() {
    super.initState();
    setCustomers();
    setLocations();
    if ((synced)) refreshSales();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setAllSalesList();
      }
    });
    Helper().syncCallLogs();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  setCustomers() async {
    customerListMap.addAll(await Contact().get());
    setState(() {});
  }

  setLocations() async {
    await System().get('location').then((value) {
      value.forEach((element) {
        setState(() {
          locationListMap.add({
            'id': element['id'],
            'name': element['name'],
          });
        });
      });
    });
    await System().refreshPermissionList().then((value) async {
      await getPermission().then((value) {
        changeUrl = true;
        onFilter();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate('sales'),
              style: AppTheme.getTextStyle(themeData.textTheme.headline6,
                  fontWeight: 600)),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if (await Helper().checkConnectivity()) {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Row(
                          children: [
                            CircularProgressIndicator(),
                            Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(AppLocalizations.of(context)
                                    .translate('sync_in_progress'))),
                          ],
                        ),
                      );
                    },
                  );
                  await Sell().createApiSell(syncAll: true).then((value) {
                    Navigator.pop(context);
                    setState(() {
                      synced = true;
                      sells();
                    });
                  });
                } else
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)
                          .translate('check_connectivity'));
              },
              child: Text(
                AppLocalizations.of(context).translate('sync'),
                style: AppTheme.getTextStyle(themeData.textTheme.subtitle1,
                    fontWeight: (synced) ? 500 : 900, letterSpacing: -0.2),
              ),
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(
                icon: Icon(Icons.line_weight),
                child: Text(
                    AppLocalizations.of(context).translate('recent_sales'))),
            Tab(
              icon: Icon(Icons.line_style),
              child: Text(AppLocalizations.of(context).translate('all_sales')),
            )
          ]),
        ),
        body: TabBarView(children: [currentSales(), allSales()]),
        bottomNavigationBar: posBottomBar('sale', context),
      ),
    );
  }

  //Fetch permission from database
  getPermission() async {
    var activeSubscriptionDetails = await System().get('active-subscription');
    if (activeSubscriptionDetails.length > 0) {
      if (await Helper().getPermission("sell.update")) {
        canEditSell = true;
      }
      if (await Helper().getPermission("sell.delete")) {
        canDeleteSell = true;
      }
    }
    if (await Helper().getPermission("view_paid_sells_only")) {
      paymentStatuses.add('paid');
      selectedPaymentStatus = 'paid';
    }
    if (await Helper().getPermission("view_due_sells_only")) {
      paymentStatuses.add('due');
      selectedPaymentStatus = 'due';
    }
    if (await Helper().getPermission("view_partial_sells_only")) {
      paymentStatuses.add('partial');
      selectedPaymentStatus = 'partial';
    }
    if (await Helper().getPermission("view_overdue_sells_only")) {
      paymentStatuses.add('overdue');
      selectedPaymentStatus = 'overdue';
    }
    //await Helper().getPermission("sell.view")
    if (await Helper().getPermission("direct_sell.view")) {
      url = Api().apiUrl + "sell?order_by_date=desc";
      if (paymentStatuses.length < 2) {
        paymentStatuses.addAll(['paid', 'due', 'partial', 'overdue']);
        selectedPaymentStatus = 'all';
      }
      setState(() {
        canViewSell = true;
      });
    } else if (await Helper().getPermission("view_own_sell_only")) {
      url = Api().apiUrl + "sell?order_by_date=desc&user_id=$USERID";
      if (paymentStatuses.length < 2) {
        paymentStatuses.addAll(['paid', 'due', 'partial', 'overdue']);
        selectedPaymentStatus = 'all';
      }
      setState(() {
        canViewSell = true;
      });
    }
  }

  refreshSales() async {
    if (await Helper().checkConnectivity()) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child:
                      Text(AppLocalizations.of(context).translate('loading')),
                ),
              ],
            ),
          );
        },
      );
      //update sells from api
      // await updateSellsFromApi().then((value) {
      sells();
      Navigator.pop(context);
      // });
    } else {
      sells();
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('check_connectivity'));
    }
  }

  //fetch current sales from database
  sells() async {
    sellList = [];
    await SellDatabase().getSells(all: true).then((value) {
      value.forEach((element) async {
        if (element['is_synced'] == 0) synced = false;
        var customerDetail =
            await Contact().getCustomerDetailById(element['contact_id']);
        var locationName =
            await Helper().getLocationNameById(element['location_id']);
        setState(() {
          sellList.add({
            'id': element['id'],
            'transaction_date': element['transaction_date'],
            'invoice_no': element['invoice_no'],
            'customer_name': customerDetail['name'],
            'mobile': customerDetail['mobile'],
            'contact_id': element['contact_id'],
            'location_id': element['location_id'],
            'location_name': locationName,
            'status': element['status'],
            'tax_rate_id': element['tax_rate_id'],
            'discount_amount': element['discount_amount'],
            'discount_type': element['discount_type'],
            'sale_note': element['sale_note'],
            'staff_note': element['staff_note'],
            'invoice_amount': element['invoice_amount'],
            'pending_amount': element['pending_amount'],
            'is_synced': element['is_synced'],
            'is_quotation': element['is_quotation'],
            'invoice_url': element['invoice_url'],
            'transaction_id': element['transaction_id']
          });
        });
      });
    });
    await Helper().getFormattedBusinessDetails().then((value) {
      symbol = value['symbol'];
    });
  }

  //refresh sales list
  updateSellsFromApi() async {
    //get synced sells transactionId
    List transactionIds = await SellDatabase().getTransactionIds();

    if (transactionIds.isNotEmpty) {
      //fetch specified sells by transactionId from api
      List specificSales = await SellApi().getSpecifiedSells(transactionIds);

      specificSales.forEach((element) async {
        //fetch sell from database with respective transactionId
        List sell = await SellDatabase().getSellByTransactionId(element['id']);

        if (sell.length > 0) {
          //Updating latest data in sell_payments
          //delete payment lines with reference to its sellId
          await PaymentDatabase().delete(sell[0]['id']);
          element['payment_lines'].forEach((value) async {
            //store payment lines from response
            await PaymentDatabase().store({
              'sell_id': sell[0]['id'],
              'method': value['method'],
              'amount': value['amount'],
              'note': value['note'],
              'payment_id': value['id'],
              'is_return': value['is_return'],
              'account_id': value['account_id']
            });
          });

          //Updating latest data in sell_lines
          //delete sell_lines with reference to its sellId
          await SellDatabase().deleteSellLineBySellId(sell[0]['id']);

          element['sell_lines'].forEach((value) async {
            //   //store sell lines from response
            await SellDatabase().store({
              'sell_id': sell[0]['id'],
              'product_id': value['product_id'],
              'variation_id': value['variation_id'],
              'quantity': value['quantity'],
              'unit_price': value['unit_price_before_discount'],
              'tax_rate_id': value['tax_id'],
              'discount_amount': value['line_discount_amount'],
              'discount_type': value['line_discount_type'],
              'note': value['sell_line_note'],
              'is_completed': 1
            });
          });
          //update latest sells details
          updateSells(element);
        }
      });
    }
  }