import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../apis/expenses.dart';
import '../helpers/AppTheme.dart';
import '../helpers/SizeConfig.dart';
import '../helpers/otherHelpers.dart';
import '../locale/MyLocalizations.dart';
import '../models/expenses.dart';
import '../models/system.dart';

class Expense extends StatefulWidget {
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> expenseCategories = [],
      expenseSubCategories = [],
      paymentMethods = [],
      paymentAccounts = [],
      locationListMap = [
        {'id': 0, 'name': 'set location'}
      ],
      taxListMap = [
        {'id': 0, 'name': 'Tax rate', 'amount': 0}
      ];
  Map<String, dynamic> selectedLocation = {'id': 0, 'name': 'set location'},
      selectedTax = {'id': 0, 'name': 'Tax rate', 'amount': 0},
      selectedExpenseCategoryId = {'id': 0, 'name': 'Select'},
      selectedExpenseSubCategoryId = {'id': 0, 'name': 'Select'};
  TextEditingController expenseAmount = new TextEditingController(),
      expenseNote = new TextEditingController(),
      payingAmount = new TextEditingController();

  Map<String, dynamic> selectedPaymentAccount = {'id': null, 'name': "None"},
      selectedPaymentMethod = {
        'name': 'name',
        'value': 'value',
        'account_id': null
      };
  String symbol = '';

  static int themeType = 1;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(themeType);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(themeType);

  @override
  void initState() {
    super.initState();
    setLocationMap();
    setTaxMap();
    setPaymentDetails(selectedLocation['id']);
    Helper().syncCallLogs();
  }

  @override
  void dispose() {
    expenseAmount.dispose();
    expenseNote.dispose();
    payingAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(AppLocalizations.of(context).translate('expenses'),
            style: AppTheme.getTextStyle(themeData.textTheme.headline6,
                fontWeight: 600)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MySize.size20!),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate('location') +
                            ' : ',
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.headline6,
                            fontWeight: 700,
                            letterSpacing: -0.2),
                      ),
                      locations(),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate('tax') + ' : ',
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.headline6,
                            fontWeight: 700,
                            letterSpacing: -0.2),
                      ),
                      taxes(),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(MySize.size8!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MySize.screenWidth! * 0.4,
                    child: Text(
                      "${AppLocalizations.of(context).translate('expense_categories')} : ",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTheme.getTextStyle(
                          themeData.textTheme.headline6,
                          fontWeight: 700,
                          letterSpacing: -0.2),
                    ),
                  ),
                  SizedBox(
                      width: MySize.screenWidth! * 0.45,
                      child: expenseCategory()),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(MySize.size8!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MySize.screenWidth! * 0.4,
                    child: Text(
                      "${AppLocalizations.of(context).translate('sub_categories')} : ",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTheme.getTextStyle(
                          themeData.textTheme.headline6,
                          fontWeight: 700,
                          letterSpacing: -0.2),
                    ),
                  ),
                  SizedBox(
                      width: MySize.screenWidth! * 0.45,
                      child: expenseSubCategory()),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(MySize.size8!),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.length < 1) {
                          return AppLocalizations.of(context)
                              .translate('please_enter_expense_amount');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefix: Text(symbol),
                        labelText: AppLocalizations.of(context)
                            .translate('expense_amount'),
                        border: themeData.inputDecorationTheme.border,
                        enabledBorder: themeData.inputDecorationTheme.border,
                        focusedBorder:
                            themeData.inputDecorationTheme.focusedBorder,
                      ),

  }
}