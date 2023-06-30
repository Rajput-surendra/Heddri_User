import 'dart:convert';

import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/Constant.dart';
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:eshop_multivendor/Model/MyPlansModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../Helper/Session.dart';
import '../Model/MembarshipPlaneMdel.dart';
import '../Provider/CartProvider.dart';
import '../Provider/SettingProvider.dart';
import 'Cart.dart';
import 'Dashboard.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({Key? key}) : super(key: key);

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  get numberTruthList => null;
  MembarshipPlaneMdel? MembarShipPlan;

// @override
// void initState(){
//   super.initState();
//   membarshipPlan();
// }

  String? name,planType,amount;

  late Razorpay _razorpay;

  int? finalPrice;
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      return membarshipPlan();
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  int currentIndex =  1;

  String? login_status;

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  int? pricerazorpayy;

  void openCheckout() async {
    pricerazorpayy= int.parse(amount.toString())*100;
    var options = {
      'key': 'rzp_test_CzVEZjetT2Hvfw€',
      'amount': '$pricerazorpayy',
      'name': 'Heddari',
      'description': 'Heddari',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {

    // RazorpayDetailApi();
    // purchesPlan(plansid,amounts);
    customerPurchase(name.toString(),planType.toString(),amount.toString());
    Fluttertoast.showToast(
        msg: "Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );

    Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));

  }

  MembarshipPlaneMdel? membarshipPlaneMdel;

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);
    Fluttertoast.showToast(
        msg: "Payment cancelled by user",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!, toastLength: Toast.LENGTH_SHORT);
  }

  membarshipPlan()async{
    var headers = {
      'Cookie': 'ci_session=b476500b0ada9e8ab9b8b786e998747866613345'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}membership_plan'));
    request.fields.addAll({
      'user_id ': '${CUR_USERID}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
           final jsonResponse = MembarshipPlaneMdel.fromJson(json.decode(finalResult));
          // Fluttertoast.showToast(msg: jsonResponse.message.toString());
          setState(() {
            membarshipPlaneMdel  = jsonResponse;
          });
      return MembarshipPlaneMdel.fromJson(json.decode(finalResult));
    }

    else {
    print(response.reasonPhrase);
    }

  }

  customerPurchase(String name,String planType,String amount)async{
    var headers = {
      'Cookie': 'ci_session=629e899e0579c8cf237a9201340daf9455f07193'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}customer_purchase'));
    request.fields.addAll({
      'user_id': ' ${CUR_USERID}',
      'name': '${CUR_USERNAME}',
      'email': '${CUR_USEREMAIL}',
      'plan_name': '${name}',
      'plan_type': '${planType}',
      'price': '${amount}',
      'start_date': ' ',
      'end_date': ''
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("sdd ${response.statusCode}");
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print(" checking response here ${jsonResponse}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  MyPlansModel? myPlansModel;
  getMyPlans()async{
    var headers = {
      'Cookie': 'ci_session=c324d924ce54a17a21b6218e981a5d1ff3815554'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}member_ship_customer'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = MyPlansModel.fromJson(json.decode(finalResponse));
      print("final response of get my plans $jsonResponse");
      setState(() {
        myPlansModel = jsonResponse;
      });
      return MyPlansModel.fromJson(json.decode(finalResponse));
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(getTranslated(context, "PLAN")!, context),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      setState((){
                        currentIndex = 1;
                      });
                      membarshipPlan();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2.5,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                      decoration: BoxDecoration(
                        color: currentIndex == 1 ? colors.primary : Colors.grey[400],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text("All plans",style:TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState((){
                        currentIndex = 2;
                      });
                      getMyPlans();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width/2.5,
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                      decoration: BoxDecoration(
                        color:currentIndex == 2 ? colors.primary : Colors.grey[400],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text("My plans",style:TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
            currentIndex == 1 ? Container(
            //  height: MediaQuery.of(context).size.height/2,
              child:  membarshipPlaneMdel == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: membarshipPlaneMdel!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return   membarshipPlaneMdel!.data == null ? Container(child: Center(child: Text("No Plans to show"),),) :  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            name  =  membarshipPlaneMdel!.data![index].plan.toString();
                            planType = membarshipPlaneMdel!.data![index].planType.toString();
                            amount = membarshipPlaneMdel!.data![index].price.toString();
                          });
                          openCheckout();
                          // customerPurchase(MembarShipPlan!.data![index].plan.toString(),MembarShipPlan!.data![index].planType.toString(),MembarShipPlan!.data![index].price.toString());
                        },
                        child: Container(
                            padding: EdgeInsets.all(7),

                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Plan : ",style: TextStyle(color: colors.primary),)),
                                      Expanded(child: Text("${membarshipPlaneMdel!.data![index].plan}")),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Status : ",style: TextStyle(color: colors.primary),)),
                                      Expanded(child: Text("${membarshipPlaneMdel!.data![index].status}")),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Plan Type : ",style: TextStyle(color: colors.primary),)),
                                      Expanded(child: Text("${membarshipPlaneMdel!.data![index].planType}")),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Price : ",style: TextStyle(color: colors.primary),)),
                                      Expanded(child: Text("${membarshipPlaneMdel!.data![index].price}")),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    );
                  })
            ) :
            Container(
              child:   myPlansModel == null ? Center(child: CircularProgressIndicator(),) : myPlansModel!.data == null ? Center(child: Text("No Plans to show"),) : ListView.builder(
                  itemCount: myPlansModel!.data!.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return myPlansModel!.data == null || myPlansModel!.data!.length == 0 ? Container(child: Center(child: Text("No Current plans"),),) : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                          });
                          // openCheckout();
                          // customerPurchase(MembarShipPlan!.data![index].plan.toString(),MembarShipPlan!.data![index].planType.toString(),MembarShipPlan!.data![index].price.toString());
                        },
                        child: Container(
                            padding: EdgeInsets.all(7),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Plan : ",style: TextStyle(color: colors.primary),)),
                                      Expanded(child: Text("${myPlansModel!.data![index].planName}")),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Plan Type : ",style: TextStyle(color: colors.primary),)),
                                      Expanded(child: Text("${myPlansModel!.data![index].planType}")),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Price : ",style: TextStyle(color: colors.primary),)),
                                      Expanded(child: Text("${myPlansModel!.data![index].price}")),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Expiry : ",style: TextStyle(color: colors.primary),)),
                                      Expanded(child: Text("${myPlansModel!.data![index].endDate}")),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    );
                  }),
              // child: FutureBuilder(
              //   future: getMyPlans(),
              //   builder: (BuildContext context,AsyncSnapshot snapshot){
              //     MyPlansModel? model = snapshot.data;
              //     if(snapshot.hasData){
              //       return model == null ? Center(child: CircularProgressIndicator(),) : model.data == null ? Center(child: Text("No plans to show"),) :
              //       ListView.builder(
              //           itemCount: model!.data!.length,
              //           physics: ScrollPhysics(),
              //           shrinkWrap: true,
              //           itemBuilder: (BuildContext context, int index) {
              //             return model.data == null || model.data!.length == 0 ? Container(child: Center(child: Text("No Current plans"),),) : Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: InkWell(
              //                 onTap: (){
              //                   setState(() {
              //                   });
              //                  // openCheckout();
              //                   // customerPurchase(MembarShipPlan!.data![index].plan.toString(),MembarShipPlan!.data![index].planType.toString(),MembarShipPlan!.data![index].price.toString());
              //                 },
              //                 child: Container(
              //                    padding: EdgeInsets.all(7),
              //                     margin: EdgeInsets.only(bottom: 10),
              //                     decoration: BoxDecoration(
              //                         color: Colors.white,
              //                         borderRadius: BorderRadius.circular(7)),
              //                     child: Column(
              //                       mainAxisSize: MainAxisSize.min,
              //                       children: [
              //                         Padding(
              //                           padding: const EdgeInsets.all(5.0),
              //                           child: Row(
              //                             children: [
              //                               Expanded(child: Text("Plan : ",style: TextStyle(color: colors.primary),)),
              //                               Expanded(child: Text("${model!.data![index].planName}")),
              //                             ],
              //                           ),
              //                         ),
              //
              //                         Padding(
              //                           padding: const EdgeInsets.all(5.0),
              //                           child: Row(
              //                             children: [
              //                               Expanded(child: Text("Plan Type : ",style: TextStyle(color: colors.primary),)),
              //                               Expanded(child: Text("${model!.data![index].planType}")),
              //                             ],
              //                           ),
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.all(5.0),
              //                           child: Row(
              //                             children: [
              //                               Expanded(child: Text("Price : ",style: TextStyle(color: colors.primary),)),
              //                               Expanded(child: Text("${model!.data![index].price}")),
              //                             ],
              //                           ),
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.all(5.0),
              //                           child: Row(
              //                             children: [
              //                               Expanded(child: Text("Expiry : ",style: TextStyle(color: colors.primary),)),
              //                               Expanded(child: Text("${model!.data![index].endDate}")),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     )
              //                 ),
              //               ),
              //             );
              //           });
              //     }else if (snapshot.hasError) {
              //       return Shimmer.fromColors(child: ListView.builder(
              //           itemCount:  5,
              //           itemBuilder: (c,i){
              //             return Container(
              //               margin: EdgeInsets.symmetric(vertical: 8),
              //               height: 80,
              //               width: MediaQuery.of(context).size.width,
              //             );
              //           }),  baseColor: Colors.grey[300]!,
              //         highlightColor: Colors.grey[100]!,);
              //     } else {
              //       return Container(
              //           height: MediaQuery.of(context).size.height,
              //           child: Center(child: CircularProgressIndicator()));
              //     }
              //   },
              // ),
            )
          ],
        ),
      ),

    );
  }
  // MembarShipPlan == null ? Center(child: Text("No Data Found")):
  // ListView.builder(
  // itemCount: MembarShipPlan!.data!.length,
  // itemBuilder: (BuildContext context, int index) {
  // return Padding(
  // padding: const EdgeInsets.all(8.0),
  // child: InkWell(
  // onTap: (){
  // setState(() {
  // name  = MembarShipPlan!.data![index].plan.toString();
  // planType = MembarShipPlan!.data![index].planType.toString();
  // amount = MembarShipPlan!.data![index].price.toString();
  // });
  // openCheckout();
  // // customerPurchase(MembarShipPlan!.data![index].plan.toString(),MembarShipPlan!.data![index].planType.toString(),MembarShipPlan!.data![index].price.toString());
  // },
  // child: Container(
  // height: MediaQuery.of(context).size.height/6,
  // margin: EdgeInsets.only(bottom: 10),
  // decoration: BoxDecoration(
  // color: Colors.white,
  // borderRadius: BorderRadius.circular(7)),
  // child: Column(
  // children: [
  // Padding(
  // padding: const EdgeInsets.all(5.0),
  // child: Row(
  // children: [
  // Expanded(child: Text("Plan : ",style: TextStyle(color: colors.primary),)),
  // Expanded(child: Text("${MembarShipPlan!.data![index].plan}")),
  // ],
  // ),
  // ),
  // Padding(
  // padding: const EdgeInsets.all(5.0),
  // child: Row(
  // children: [
  // Expanded(child: Text("Status : ",style: TextStyle(color: colors.primary),)),
  // Expanded(child: Text("${MembarShipPlan!.data![index].status}")),
  // ],
  // ),
  // ),
  // Padding(
  // padding: const EdgeInsets.all(5.0),
  // child: Row(
  // children: [
  // Expanded(child: Text("Plan Type : ",style: TextStyle(color: colors.primary),)),
  // Expanded(child: Text("${MembarShipPlan!.data![index].planType}")),
  // ],
  // ),
  // ),
  // Padding(
  // padding: const EdgeInsets.all(5.0),
  // child: Row(
  // children: [
  // Expanded(child: Text("Price : ",style: TextStyle(color: colors.primary),)),
  // Expanded(child: Text("${MembarShipPlan!.data![index].price}")),
  // ],
  // ),
  // ),
  // ],
  // )
  // ),
  // ),
  // );
  // }),

}
