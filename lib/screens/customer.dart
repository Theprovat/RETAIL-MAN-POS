import '../apis/contact.dart';
import '../helpers/AppTheme.dart';
import '../helpers/SizeConfig.dart';
import '../helpers/otherHelpers.dart';
import '../helpers/style.dart' as style;
import '../locale/MyLocalizations.dart';
import '../models/contact_model.dart';
import '../models/sell.dart';
import '../models/sellDatabase.dart';
import 'elements.dart';
import 'login.dart';

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  Map? argument;
  final _formKey = GlobalKey<FormState>();

  String transactionDate =
      DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
  List<Map<String, dynamic>> customerListMap = [];
  Map<String, dynamic> selectedCustomer = {
    'id': 0,
    'name': 'select customer',
    'mobile': ' - '
  };
  TextEditingController prefix = new TextEditingController(),
      firstName = new TextEditingController(),
      middleName = new TextEditingController(),
      lastName = new TextEditingController(),
      mobile = new TextEditingController(),
      addressLine1 = new TextEditingController(),
      addressLine2 = new TextEditingController(),
      city = new TextEditingController(),
      state = new TextEditingController(),
      country = new TextEditingController(),
      zip = new TextEditingController();

  static int themeType = 1;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(themeType);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(themeType);

  @override
  void initState() {
    super.initState();
    selectCustomer();
  }

  @override
  void didChangeDependencies() {
    argument = ModalRoute.of(context)!.settings.arguments as Map?;

    if (argument!['customerId'] != null) {
      Future.delayed(Duration(milliseconds: 400), () async {
        await Contact()
            .getCustomerDetailById(argument!['customerId'])
            .then((value) {
          if (this.mounted) {
            setState(() {
              selectedCustomer = {
                'id': argument!['customerId'],
                'name': value['name'],
                'mobile': value['mobile']
              };
            });
          }
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate('customer'),
              style: AppTheme.getTextStyle(themeData.textTheme.headline6,
                  fontWeight: 600)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return newCustomer();
                },
                fullscreenDialog: true));
          },
          child: Icon(MdiIcons.accountPlus),
          elevation: 2,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: MySize.size120!, left: MySize.size20!),
                child: Card(child: customerList()),
              ),
              Center(
                child: Visibility(
                  visible: (selectedCustomer['id'] == 0),
                  child: Text(
                      AppLocalizations.of(context).translate(
                          'please_select_a_customer_for_checkout_option'),
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: (selectedCustomer['id'] != 0),
          child: Row(
            mainAxisAlignment: (argument!['is_quotation'] == null)
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.center,
            children: [
              Visibility(
                visible: argument!['is_quotation'] == null,
                child: TextButton(
                  onPressed: (addQuotation),
                  style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: style.StyleColors().mainColor(1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('add_quotation'),
                        style: AppTheme.getTextStyle(
                            Theme.of(context).textTheme.bodyText1,
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    ],
                  ),
                ),
              ),
              cartBottomBar(
                  '/checkout',
                  AppLocalizations.of(context).translate('pay_&_checkout'),
                  context,
                  Helper().argument(
                      locId: argument!['locationId'],
                      taxId: argument!['taxId'],
                      discountType: argument!['discountType'],
                      discountAmount: argument!['discountAmount'],
                      invoiceAmount: argument!['invoiceAmount'],
                      customerId: selectedCustomer['id'],
                      sellId: argument!['sellId'])),
            ],
          ),
        ));
  }
