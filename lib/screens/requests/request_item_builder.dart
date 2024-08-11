// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liliijar_system/cubit/cubit.dart';
import 'package:liliijar_system/db/db.dart';

import '../../models/request_model.dart';

Widget requestItemBuilder(RequestModel model,context)  {

  var product;
  product= dbGetOne(modelName: 'categories', id: model.id!);
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),border: Border.all(color: Colors.grey,width: 2)),

    height: 150,
    padding: EdgeInsets.all(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text('Name: ${model.name??''}',style:  TextStyle(fontWeight: FontWeight.w700,fontSize: 15,letterSpacing: 1),),
            Text('Phone: ${model.phone??''}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15,letterSpacing: 1),),

            Text('product:${model.productName}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15,letterSpacing: 1,overflow: TextOverflow.ellipsis),maxLines: 1,overflow: TextOverflow.ellipsis,),
            Spacer(),
            Row(
              children: [
                ElevatedButton(onPressed: () {
                  dbDeleteItem(modelName: 'requests', id: model.id!);

                }, child: Row(
                  children: [
                    Icon(Icons.not_interested,color: Colors.red,),
                    Text(' Cancel',style: TextStyle(color: Colors.red),),
                  ],
                )),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: () {

                  cubit.get(context).confirmRequest(model);
                }, child: Row(
                  children: [
                    Icon(Icons.schedule_send,color: Colors.green,),
                    Text(' Confirm',style: TextStyle(color: Colors.green),),
                  ],
                )),
              ],
            )
          ],
        ),
      ],
    ),
  );
}