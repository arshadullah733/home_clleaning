import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeclean/barber/barbar_profile.dart';
import 'package:homeclean/customerRegister.dart';

class Barbar extends StatefulWidget {
  @override
  _BarbarState createState() => _BarbarState();
}

class _BarbarState extends State<Barbar> {
  var value = 'Barber';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => User(value: value)));
              },
              child: Text(
                'Registor',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('$value').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                backgroundColor: Colors.red,
                body: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                    color: Colors.white,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                snapshot.data.docs[index]['ImageUrl']),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(
                            snapshot.data.docs[index]['Name'],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BarbarProfile(
                                        username: value, number: index)));
                          },
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Image(
                          image: NetworkImage(
                              snapshot.data.docs[index]['ImageUrl']),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}