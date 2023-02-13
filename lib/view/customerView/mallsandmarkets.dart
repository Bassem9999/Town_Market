import 'package:flutter/material.dart';
import '../../components/components.dart';
import '../../view_model/appCubit.dart';
import 'market.dart';

class MallsAndMarkets extends StatefulWidget {
  const MallsAndMarkets({Key? key}) : super(key: key);

  @override
  State<MallsAndMarkets> createState() => _MallsAndMarketsState();
}

class _MallsAndMarketsState extends State<MallsAndMarkets> {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: cubit.getdata("markets"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                  height: 150,
                                  width: 150,
                                  child: Image(
                                    image: NetworkImage(
                                        snapshot.data[i]['imageUrl']),
                                    fit: BoxFit.contain,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data[i]['name']),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data[i]['address'],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          // goToMap(snapshot.data[i]['latitude'],snapshot.data[i]['longitude'],);
                          myPushNavigator(
                              context,
                              MarketPage(
                                marketname: snapshot.data[i]['name'],
                                address: snapshot.data[i]['address'],
                                collection: snapshot.data[i]['collection'],
                                longitude: snapshot.data[i]['longitude'],
                                latitude: snapshot.data[i]['latitude'],
                              ));
                        },
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
          },
        ));
  }
}
