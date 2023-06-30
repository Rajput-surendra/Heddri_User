import 'package:eshop_multivendor/Screen/Cart.dart';
import 'package:flutter/material.dart';

import '../Helper/Color.dart';
import '../Helper/Session.dart';

class OrderType extends StatefulWidget {
  const OrderType({Key? key}) : super(key: key);

  @override
  State<OrderType> createState() => _OrderTypeState();
}

class _OrderTypeState extends State<OrderType> {

  String  currentIndex = 'Individual Ordering';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getSimpleAppBar(getTranslated(context, "ORDER_TYPE")!, context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/4,
              width : MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: colors.whiteTemp,
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select Order Type",style: TextStyle(fontWeight: FontWeight.bold,color: colors.primary),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          currentIndex = 'Individual Ordering';
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(

                                border: Border.all(width: 2,color: currentIndex == 'Individual Ordering' ? Colors.green : Colors.grey),
                                borderRadius: BorderRadius.circular(100)

                            ),
                            child:   Container(
                              width: 2,
                              decoration: BoxDecoration(
                                  color:  currentIndex == 'Individual Ordering' ? Colors.green : Colors.transparent,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text("Individual Ordering",style: TextStyle(
                              fontWeight: FontWeight.normal
                          ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          currentIndex = 'Tiffin Order';
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(

                                border: Border.all(width: 2,color:currentIndex == 'Tiffin Order' ? Colors.green : Colors.grey),
                                borderRadius: BorderRadius.circular(100)

                            ),
                            child: Container(
                              width: 2,
                              decoration: BoxDecoration(
                                  color: currentIndex == 'Tiffin Order' ? Colors.green : Colors.transparent,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text("Tiffin Order",style: TextStyle(
                              fontWeight: FontWeight.normal
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          currentIndex ='Bulk Ordering for Organisation';
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(

                                border: Border.all(width: 2,color: currentIndex == 'Bulk Ordering for Organisation' ? Colors.green : Colors.grey),
                                borderRadius: BorderRadius.circular(100)

                            ),
                            child: Container(
                              width: 2,
                              decoration: BoxDecoration(
                                  color: currentIndex == 'Bulk Ordering for Organisation' ? Colors.green : Colors.transparent,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text("Bulk Ordering for Organisation",style: TextStyle(
                              fontWeight: FontWeight.normal
                          ))
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: (){
                Navigator.pop(context,currentIndex);
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Center(child: Text("Submit",style: TextStyle(color: colors.whiteTemp),)),
              ),
            )
          ],
        )


      ),

    );
  }
}
