import 'dart:async';
import 'dart:convert';

import 'package:eshop_multivendor/Helper/Constant.dart';
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Model/Get_memberShipPlan_model.dart';
import '../Provider/SettingProvider.dart';


class CarrierCategeory extends StatefulWidget {
  String? bannerCarrier;
   CarrierCategeory({Key? key,this.bannerCarrier}) : super(key: key);

  @override
  State<CarrierCategeory> createState() => _CarrierCategeoryState();
}

class _CarrierCategeoryState extends State<CarrierCategeory> {

  Razorpay razorpay = Razorpay();

  String? id,price,type,name;
String? razorpayId;

  Future<void> _getdateTime() async {
      dates.clear();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> newDate = [];
      newDate = prefs.getStringList('deliveryDate')!;
      dates = newDate.map((e) => DateTime.parse(e)).toList();
      try {
        var parameter = {TYPE: PAYMENT_METHOD, USER_ID: CUR_USERID};
        Response response =
        await post(getSettingApi, body: parameter, headers: headers)
            .timeout(Duration(seconds: timeOut));
        print("pppp ${parameter}  and ${getSettingApi} ");
        if (response.statusCode == 200) {
          var getdata = json.decode(response.body);
          print(getdata);
          bool error = getdata["error"];
          // String msg = getdata["message"];
          if (!error) {
            var data = getdata["data"];
            var payment = data["payment_method"];
             razorpayId = payment["razorpay_key_id"];
          } else {
            // setSnackbar(msg);
          }
        }

      } on TimeoutException catch (_) {
      }
    }

  TextEditingController startDateController =  TextEditingController();
  TextEditingController endDateController =  TextEditingController();
  TextEditingController startCustomDateController =  TextEditingController();
  TextEditingController endCustomDateController =  TextEditingController();
  TextEditingController dayController =  TextEditingController();
  TextEditingController customdayController =  TextEditingController();
  TextEditingController addressController =  TextEditingController();

  int? days ;
  String _dateValue = '';
  DateTime? lastDAte;
  var dateFormate;
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;


  }
  Future _selectDateStart() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),

    //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print("here start date${_dateValue}");
        final startDate = DateTime.now(); // Replace with your desired start date
        final numberOfDays = int.parse(dayController.text);
         DateTime lastDAte = startDate.add(Duration(days: numberOfDays));
       print('number of days ====?${numberOfDays}_________');
        dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
        startDateController = TextEditingController(text: _dateValue);
        print('__________${picked}_________');
        lastDAte = (picked.add(Duration(days: days ?? numberOfDays)));
        print('____last date of staart date______${lastDAte}_________');
        endDateController = TextEditingController(text: DateFormat("yyyy/MM/dd").format(DateTime.parse(lastDAte.toString())));
      });
  }
  Future _selectCustomDateStart() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),

        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print("here start date${_dateValue}");
        final startDate = DateTime.now(); // Replace with your desired start date
        final numberOfDays = int.parse(customdayController.text);
        DateTime lastDAte = startDate.add(Duration(days: numberOfDays));
        print('number of days ====?${numberOfDays}_________');
        dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
        startCustomDateController = TextEditingController(text: _dateValue);
        print('__________${picked}_________');
        lastDAte = (picked.add(Duration(days: days ?? numberOfDays)));
        print('____last date of staart date______${lastDAte}_________');
        endCustomDateController = TextEditingController(text: DateFormat("yyyy/MM/dd").format(DateTime.parse(lastDAte.toString())));
      });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Future.delayed(Duration(milliseconds: 200),(){
     return  getMemberShipPlanApi();
   });
   Future.delayed(Duration(milliseconds:200),(){
    return _getdateTime();
   });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }
  void handlePaymentErrorResponse(PaymentFailureResponse response){
    print("first one here");
  }
  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    print("first one not here");
    purchasePlan(type.toString());
   }
  void handleExternalWalletSelected(ExternalWalletResponse response){

  }

  openCheckout(String amt) {
    // print("working check out thing${finalPrice}");
    double prices = double.parse(amt.toString());
      var fPrice = prices.toStringAsFixed(0);
      int finalPrice = int.parse(fPrice.toString()) * 100;
    print("working check out thing${finalPrice}");

    SettingProvider settingsProvider =
    Provider.of<SettingProvider>(this.context, listen: false);

    String? contact = settingsProvider.mobile;
    String? email = settingsProvider.email;

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "${finalPrice.toString()}",
      'name': '${settingsProvider.userName}',
      'prefill': {CONTACT: contact, EMAIL: email}
    };
    print("options are here now ${options}");
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  GetMemberShipPlanModel? getMemberShipPlanModel;
  getMemberShipPlanApi() async {
    // var headers = {
    //   'Cookie': 'ci_session=5fac07591f04aeaa2685fe133c06c6021e5c6d0a'
    // };
    // var request = http.Request('GET', Uri.parse('$baseUrl/membership_plan'));
    // request.fields.addAll({
    //   'user_id': '194'
    // });
    //
    // request.headers.addAll(headers);
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    // if (response.statusCode == 200) {
    //  var result = await response.stream.bytesToString();
    //  var finalResult = GetMemberShipPlanModel.fromJson(json.decode(result));
    //  setState(() {
    //    getMemberShipPlanModel = finalResult;
    //  });
    // }
    // else {
    // print(response.reasonPhrase);
    // }

    var headers = {
      'Cookie': 'ci_session=578477b287f3b593525dfbca1760040e864ad5c0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/membership_plan'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalresult = await response.stream.bytesToString();
      final jsonResponse = GetMemberShipPlanModel.fromJson(json.decode(finalresult));
      setState(() {
        getMemberShipPlanModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  String? UName,UEmail;
  List<String> newdates = [];
  purchasePlan(String type)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UName = prefs.getString('user_name');
    UEmail = prefs.getString('user_email');

    var dayValue = type.toString().split(" ");
    print("new selected dates are here ${dayValue[0]}");

    DateTime dateTime = DateTime.now();
    print("checking now here ${DateFormat('yyyy-MM-dd').format(dateTime)}");
    String currDate = "${DateFormat('yyyy-MM-dd').format(dateTime)}";
    var headers = {
      'Cookie': 'ci_session=e458a2089b9ad8eb84c7fbe3ff5ebf54d6bbd294'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/customer_purchase'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'name':   UName.toString(),
      'email': '${CUR_USEREMAIL}',
      'plan_name': '${name}',
      'plan_type': '${type}',
      'price': '${price}',
      'start_date': '${currDate}',
      'plan_id': '${id}'
    });
    print("yes paramter here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      setState(() {
        setSnackbar("${jsonResponse['message']}", context);
      });
      getMemberShipPlanApi();
      getNewList(int.parse(dayValue[0].toString()));
      Navigator.pop(context);
    }
    else {
      print(response.reasonPhrase);
    }

  }
  List<DateTime> dates = [];
  List<dynamic> unselectedDates = [];
  SharedPreferences? prefs;
  DateTime dateTime1 = DateTime.now();
  getNewList(int days)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentDate = DateTime.now();
    for (int i = 0; i < days; i++) {
      final date = currentDate.add(Duration(days: i));
      dates.add(date);
      newdates.add(date.toString());
    }
    prefs.setStringList('deliveryDate', newdates);
  print("final dates here ${dates} and");
    unselectedDates.clear();
    for(var i = 0;i < dates.length;i++){
      print("working");
      if(dates.contains(dates[i].isBefore(currentDate))){
        print("final dates are here ${dates[i]}");
        unselectedDates.add(dates[i]);
      }
      else{
        print("working this here ${dates[i]}");
      }
    }
  final GlobalKey<ScaffoldMessengerState> _checkscaffoldKey =
  new GlobalKey<ScaffoldMessengerState>();
 
    // if (isTodayInList) {
    //   print('Today\'s date exists in the list.');
    // } else {
    //   print('Today\'s date does not exist in the list.');
    // }
  }
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getSimpleAppBar(getTranslated(context, 'CARRIE')!,context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network("${widget.bannerCarrier}")),
              SizedBox(height: 10,),
              Text(getTranslated(context, 'MEMBER_SHIP_PNAN')!,style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 20),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == 0
                                  ? colors.primary
                                  : colors.primary.withOpacity(0.4)),
                          child: Center(
                              child: Text(
                                'Regular',
                                style: TextStyle(
                                    color: colors.whiteTemp,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == 1
                                  ? colors.primary
                                  : colors.primary.withOpacity(0.4)),
                          child: Center(
                              child: Text('Customize',
                                  style: TextStyle(
                                      color: colors.whiteTemp,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              selectedIndex == 0 ? regularPlan(): customizePlan()
            ],
          ),
        )
      )
    );
  }
  regularPlan(){
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child:getMemberShipPlanModel == null || getMemberShipPlanModel == "" ? Center(child: CircularProgressIndicator(color: colors.primary,)):
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: dayController,
                decoration: InputDecoration(

                    counterText: "",
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                    hintText: "Enter Days"
                ),
              ),
            ),
           Row(
             children: [
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 10),
                       child: Text("Start Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: colors.blackTemp),),
                     ),
                     Card(
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                       elevation: 5,
                       child: TextFormField(
                         readOnly: true,
                         onTap: (){
                           if(dayController.text.isEmpty){
                             Fluttertoast.showToast(msg: "Please Select Days",backgroundColor: colors.primary);
                           }else {
                             _selectDateStart();
                           }
                         },
                         controller:startDateController,
                         decoration: InputDecoration(
                             border: InputBorder.none,
                             counterText: "",
                             hintText: 'Start Date',hintStyle: TextStyle(fontSize: 15),
                             contentPadding: EdgeInsets.only(left: 10)
                         ),
                         validator: (v) {
                           if (v!.isEmpty) {
                             return "Start Date is required";
                           }
                         },
                       ),
                     ),
                   ],
                 ),
               ),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 10),
                       child:   Text("End Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: colors.blackTemp),),
                     ),
                     Card(
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                       elevation: 5,
                       child: TextFormField(
                         readOnly: true,
                         controller:endDateController,
                         decoration: InputDecoration(
                             border: InputBorder.none,
                             counterText: "",
                             hintText: 'End Date',hintStyle: TextStyle(fontSize: 15),
                             contentPadding: EdgeInsets.only(left: 10)
                         ),
                         validator: (v) {
                           if (v!.isEmpty) {
                             return "End Date is required";
                           }

                         },
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),

            // Text("Membership Plan",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 20),),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: getMemberShipPlanModel!.data!.length,
                itemBuilder: (context, index) {
                  print("new here now ${getMemberShipPlanModel!.data![index].purchase}");
                  return  Card(
                    color: colors.whiteTemp,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${getMemberShipPlanModel!.data![index].plan}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: colors.blackTemp),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${getMemberShipPlanModel!.data![index].planType}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: colors.blackTemp),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  '$imageUrl${getMemberShipPlanModel!.data![index].image}',fit: BoxFit.fill),
                            )),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "INR ${getMemberShipPlanModel!.data![index].price}",
                            style: const TextStyle(
                              color: colors.blackTemp,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decorationThickness: 2,
                            ),
                          ),
                        ),

                        false
                            ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: [
                                    0.1,
                                    0.7,
                                  ],
                                  colors: [
                                    colors.primary,
                                    colors.primary
                                  ],
                                ),
                                //color: colors.secondary,
                                borderRadius:
                                BorderRadius.circular(30)),
                            child: const Center(
                                child: Text(
                                  "Already Subscribed",
                                  style: TextStyle(
                                      color: colors.whiteTemp,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                          ),
                        )
                            : SizedBox(
                          height: 10,
                        ),
                        getMemberShipPlanModel!.data![index].purchase ==
                            "YES"
                            ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            onTap: (){
                              setSnackbar("Plan already purchased", context);
                              //  purchasePlan(getMemberShipPlanModel!.data![index].planType.toString());
                              //  purchasePlan("","","${getMemberShipPlanModel!.data![index].planType}","");
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              color: colors.primary,
                              child: Container(
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width /
                                    1.5,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(45)),
                                child: const Center(
                                    child: Text(
                                      "Purchased",
                                      style: TextStyle(
                                          color: colors.whiteTemp,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                              ),
                            ),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                id = getMemberShipPlanModel!.data![index].id.toString();
                                price = getMemberShipPlanModel!.data![index].price.toString();
                                type = getMemberShipPlanModel!.data![index].planType.toString();
                                name = getMemberShipPlanModel!.data![index].plan.toString();
                              });
                              print("checking detail here ${id} and ${price} and ${type} and ${name}");
                              openCheckout(getMemberShipPlanModel!.data![index].price.toString());
                              //purchasePlan(getMemberShipPlanModel!.data![index].id.toString(),getMemberShipPlanModel!.data![index].price.toString(),getMemberShipPlanModel!.data![index].planType.toString(),getMemberShipPlanModel!.data![index].plan.toString());
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              //     SubmitFromScreen(planId:getPlans!.data!.first.plans![index].id ,title: getPlans!.data!.first.plans![index].title,
                              //         amount: getPlans!.data!.first.plans![index].amount,days: getPlans!.data!.first.plans![index].timeText,Purchased: getPlans!.data!.first.plans![index].isPurchased )));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              color: colors.primary,
                              elevation: 5,
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context)
                                    .size
                                    .width /
                                    1.5,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(45)),
                                child: const Center(
                                    child: Text(
                                      "Subscribe Now",
                                      style: TextStyle(
                                          color: colors.whiteTemp,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // SizedBox(height: 15,),
            //  dates.length == 0 ? SizedBox() :  Text(getTranslated(context, 'DELIVERY')!,style: TextStyle(fontSize: 15),),
            // SizedBox(height: 10,),
            // dates.length == 0 ? SizedBox() :
            // Container(
            //    child: ListView.builder(
            //        shrinkWrap: true,
            //        physics: NeverScrollableScrollPhysics(),
            //        itemCount: dates.length,
            //        itemBuilder: (c,i){
            //      return Padding(
            //        padding:EdgeInsets.only(bottom: 5),
            //        child: Row(
            //          children: [
            //           dates[i].isBefore(dateTime1) ? Icon(Icons.check_box_outlined,color: Colors.black,) : Icon(Icons.check_box_outline_blank),
            //            SizedBox(width: 5,),
            //            Text("${DateFormat('dd-MM-yyyy').format(dates[i])}")
            //          ],
            //        ),
            //      );
            //    }),
            //  )
          ],
        )
    );
  }
  customizePlan(){
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child:getMemberShipPlanModel == null || getMemberShipPlanModel == "" ? Center(child: CircularProgressIndicator(color: colors.primary,)):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: addressController,
                decoration: InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                    hintText: "Enter address"
                ),
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: customdayController,
                decoration: InputDecoration(

                    counterText: "",
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                    hintText: "Enter Days"
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Start Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: colors.blackTemp),),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: TextFormField(
                          readOnly: true,
                          onTap: (){
                            if(dayController.text.isEmpty){
                             Fluttertoast.showToast(msg: "Please Select Days",backgroundColor: colors.primary);
                            }else {
                              _selectCustomDateStart();
                            }
                          },
                          controller:startCustomDateController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              hintText: 'Start Date',hintStyle: TextStyle(fontSize: 15),
                              contentPadding: EdgeInsets.only(left: 10)
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Start Date is required";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child:   Text("End Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: colors.blackTemp),),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: TextFormField(
                          readOnly: true,
                          controller:endCustomDateController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              hintText: 'End Date',hintStyle: TextStyle(fontSize: 15),
                              contentPadding: EdgeInsets.only(left: 10)
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "End Date is required";
                            }

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: getMemberShipPlanModel!.data!.length,
                itemBuilder: (context, index) {
                  print("new here now ${getMemberShipPlanModel!.data![index].purchase}");
                  return  Card(
                    color: colors.whiteTemp,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${getMemberShipPlanModel!.data![index].plan}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: colors.blackTemp),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${getMemberShipPlanModel!.data![index].planType}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: colors.blackTemp),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  '$imageUrl${getMemberShipPlanModel!.data![index].image}',fit: BoxFit.fill),
                            )),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "INR ${getMemberShipPlanModel!.data![index].price}",
                            style: const TextStyle(
                              color: colors.blackTemp,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decorationThickness: 2,
                            ),
                          ),
                        ),

                        false
                            ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: [
                                    0.1,
                                    0.7,
                                  ],
                                  colors: [
                                    colors.primary,
                                    colors.primary
                                  ],
                                ),
                                //color: colors.secondary,
                                borderRadius:
                                BorderRadius.circular(30)),
                            child: const Center(
                                child: Text(
                                  "Already Subscribed",
                                  style: TextStyle(
                                      color: colors.whiteTemp,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                          ),
                        )
                            : SizedBox(
                          height: 10,
                        ),
                        getMemberShipPlanModel!.data![index].purchase ==
                            "YES"
                            ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            onTap: (){
                              setSnackbar("Plan already purchased", context);
                              //  purchasePlan(getMemberShipPlanModel!.data![index].planType.toString());
                              //  purchasePlan("","","${getMemberShipPlanModel!.data![index].planType}","");
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              color: colors.primary,
                              child: Container(
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width /
                                    1.5,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(45)),
                                child: const Center(
                                    child: Text(
                                      "Purchased",
                                      style: TextStyle(
                                          color: colors.whiteTemp,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                              ),
                            ),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              if(dayController.text.isEmpty){
                                Fluttertoast.showToast(msg: "please select days");
                              }
                              else{
                              // setState(() {
                              //   id = getMemberShipPlanModel!.data![index].id.toString();
                              //   price = getMemberShipPlanModel!.data![index].price.toString();
                              //   type = getMemberShipPlanModel!.data![index].planType.toString();
                              //   name = getMemberShipPlanModel!.data![index].plan.toString();
                              // });
                              // print("checking detail here ${id} and ${price} and ${type} and ${name}");
                              openCheckout(getMemberShipPlanModel!.data![index].price.toString());
                              //purchasePlan(getMemberShipPlanModel!.data![index].id.toString(),getMemberShipPlanModel!.data![index].price.toString(),getMemberShipPlanModel!.data![index].planType.toString(),getMemberShipPlanModel!.data![index].plan.toString());
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              //     SubmitFromScreen(planId:getPlans!.data!.first.plans![index].id ,title: getPlans!.data!.first.plans![index].title,
                              //         amount: getPlans!.data!.first.plans![index].amount,days: getPlans!.data!.first.plans![index].timeText,Purchased: getPlans!.data!.first.plans![index].isPurchased )));
                            }
                            },

                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              color: colors.primary,
                              elevation: 5,
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context)
                                    .size
                                    .width /
                                    1.5,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(45)),
                                child: const Center(
                                    child: Text(
                                      "Subscribe Now",
                                      style: TextStyle(
                                          color: colors.whiteTemp,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // SizedBox(height: 15,),
            //  dates.length == 0 ? SizedBox() :  Text(getTranslated(context, 'DELIVERY')!,style: TextStyle(fontSize: 15),),
            // SizedBox(height: 10,),
            // dates.length == 0 ? SizedBox() :
            // Container(
            //    child: ListView.builder(
            //        shrinkWrap: true,
            //        physics: NeverScrollableScrollPhysics(),
            //        itemCount: dates.length,
            //        itemBuilder: (c,i){
            //      return Padding(
            //        padding:EdgeInsets.only(bottom: 5),
            //        child: Row(
            //          children: [
            //           dates[i].isBefore(dateTime1) ? Icon(Icons.check_box_outlined,color: Colors.black,) : Icon(Icons.check_box_outline_blank),
            //            SizedBox(width: 5,),
            //            Text("${DateFormat('dd-MM-yyyy').format(dates[i])}")
            //          ],
            //        ),
            //      );
            //    }),
            //  )
          ],
        )
    );
  }
}
