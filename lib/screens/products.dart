import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:search_choices/search_choices.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:search_choices/search_choices.dart';

import '../apis/contact_payment.dart';
import '../helpers/AppTheme.dart';
import '../helpers/SizeConfig.dart';
import '../helpers/otherHelpers.dart';
import '../locale/MyLocalizations.dart';
import '../models/contact_model.dart';
import '../models/system.dart';

class ContactPayment extends StatefulWidget {
  @override
  _ContactPaymentState createState() => _ContactPaymentState();
}

class _ContactPaymentState extends State<ContactPayment> {
  final _formKey = GlobalKey<FormState>();
  int selectedCustomerId = 0;
  List<Map<String, dynamic>> customerListMap = [],
      paymentAccounts = [],
      paymentMethods = [],
      locationListMap = [
        {'id': 0, 'name': 'set location'}
      ];
  Map<String, dynamic> selectedLocation = {'id': 0, 'name': 'set location'},
      selectedCustomer = {'id': 0, 'name': 'select customer', 'mobile': ' - '};
  String due = '0.00';
  Map<String, dynamic> selectedPaymentAccount = {'id': null, 'name': "None"},
      selectedPaymentMethod = {
        'name': 'name',
        'value': 'value',
        'account_id': null
      };

  String symbol = '';
  var payingAmount = new TextEditingController();

  static int themeType = 1;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(themeType);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(themeType);

  @override
  void initState() {
    super.initState();
    selectCustomer();
    setPaymentDetails();
    setLocationMap();
    Helper().syncCallLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(AppLocalizations.of(context).translate('contact_payment'),
            style: AppTheme.getTextStyle(themeData.textTheme.headline6,
                fontWeight: 600)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MySize.size10!),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customerList(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('due')
                              .toUpperCase(),
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.subtitle1,
                              fontWeight: 600,
                              letterSpacing: -0.2),
                        ),
                        // Padding(padding: EdgeInsets.symmetric(vertical: MySize.size4)),
                        Text(
                          Helper().formatCurrency(due),
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.headline5,
                              fontWeight: 600,
                              letterSpacing: -0.2),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: MySize.size4!)),
                Visibility(
                  visible: (selectedCustomerId != 0),
                  child: Column(
                    children: [
                      TextFormField(
                          decoration: InputDecoration(
                            prefix: Text(symbol),
                            labelText: AppLocalizations.of(context)
                                .translate('payment_amount'),
                            border: themeData.inputDecorationTheme.border,
                            enabledBorder:
                                themeData.inputDecorationTheme.border,
                            focusedBorder:
                                themeData.inputDecorationTheme.focusedBorder,
                          ),
                          controller: payingAmount,
                          validator: (newValue) {
                            if ((newValue == '' ||
                                    double.parse(newValue!) < 0.01) ||
                                double.parse(newValue) >
                                    double.parse(due.toString())) {
                              return AppLocalizations.of(context)
                                  .translate('enter_valid_payment_amount');
                            } else {
                              return null;
                            }
                          },
                          textAlign: TextAlign.end,
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.subtitle2,
                              fontWeight: 400,
                              letterSpacing: -0.2),
                          inputFormatters: [
                            // ignore: deprecated_member_use
                            FilteringTextInputFormatter(
                                RegExp(r'^(\d+)?\.?\d{0,2}'),
                                allow: true)
                          ],
                          keyboardType: TextInputType.number,
                          onChanged: (value) {}),
                      Padding(
                        padding: EdgeInsets.all(MySize.size10!),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)
                                      .translate('location') +
                                  ' : ',
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.headline6,
                                  fontWeight: 700,
                                  letterSpacing: -0.2),
                            ),
                            locations(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(MySize.size10!),
                        child: paymentOptions(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(MySize.size10!),
                        child: paymentAccount(),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: themeData.colorScheme.primary,
                      ),
                      onPressed: () async {
                        await onSubmit();
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('submit'),
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.headline6,
                            color: themeData.colorScheme.onPrimary,
                            fontWeight: 700,
                            letterSpacing: -0.2),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }