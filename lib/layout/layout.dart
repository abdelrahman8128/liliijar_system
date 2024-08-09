
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Layout extends StatefulWidget {
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<cubit,States>(
        listener: (context, state) {
        },
        builder:(context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Ronald!',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        Text(
                          'What are you looking for?',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: cubit.get(context).screens[cubit.get(context).screenIndex],

            bottomNavigationBar:

            NavigationView(


              backgroundColor: Colors.black,

              onChangePage: (c) {
                setState(() {
                  cubit.get(context).screenIndex=c;
                });
              },
              color: Colors.green,

              durationAnimation: const Duration(milliseconds: 600),
              items: [

                ItemNavigationView(
                    childAfter: const Icon(
                      Icons.add_business,
                      color: Colors.green,
                      size: 30,
                    ),
                    childBefore: Icon(
                      Icons.add_business_outlined,
                      color: Colors.grey.withAlpha(60),
                      size: 30,
                    )),
                ItemNavigationView(
                    childAfter: const Icon(
                      Icons.category,
                      color: Colors.green,
                      size: 30,
                    ),
                    childBefore: Icon(
                      Icons.category_outlined,
                      color: Colors.grey.withAlpha(60),
                      size: 30,
                    )),
                ItemNavigationView(

                    childAfter: const Icon(
                      Icons.home_rounded,
                      color: Colors.green,
                      size: 30,
                    ),
                    childBefore: Icon(
                      Icons.home_outlined,
                      color: Colors.grey.withAlpha(60),
                      size: 30,
                    )),

              ],
            ),




          );
        },
    );


  }
}
