import 'dart:convert';

import 'package:eshop_multivendor/Helper/Constant.dart';
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Model/GetPlanListModel.dart';

class MyMemberShipPlan extends StatefulWidget {
  const MyMemberShipPlan({Key? key}) : super(key: key);

  @override
  State<MyMemberShipPlan> createState() => _MyMemberShipPlanState();
}

class _MyMemberShipPlanState extends State<MyMemberShipPlan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlanList();
  }
  GetPlanListModel? getPlanListModel;
  getPlanList() async {
    var headers = {
      'Cookie': 'ci_session=3d6d321190978acd57dfcc3c8e9ebf0c1037c01a'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/users_plans'));
    request.fields.addAll({
      'user_id': CUR_USERID.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var  result  = await response.stream.bytesToString();
      var finalResult = GetPlanListModel.fromJson(jsonDecode(result));
      setState(() {
        getPlanListModel = finalResult;

      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getSimpleAppBar(getTranslated(context, 'MEMBER_SHIP_PNAN_MY')!,context),
      body:
      getPlanListModel ==  null || getPlanListModel == ""?Center(child: CircularProgressIndicator()): Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: getPlanListModel!.data!.length,
            itemBuilder: (context, index) {
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
                      "${getPlanListModel!.data![index].planName}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: colors.blackTemp),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${getPlanListModel!.data![index].planType}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: colors.blackTemp),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    Image.asset("assets/images/thali.png"),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "INR ${getPlanListModel!.data![index].price}",
                          style: const TextStyle(
                            color: colors.blackTemp,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decorationThickness: 2,
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Start Date: "),
                             Text("End Date: "),
                           ],
                         ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getPlanListModel!.data![index].startDate}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colors.blackTemp),
                              ),
                              Text(
                                "${getPlanListModel!.data![index].endDate}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colors.blackTemp),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      )

    );
  }
}
