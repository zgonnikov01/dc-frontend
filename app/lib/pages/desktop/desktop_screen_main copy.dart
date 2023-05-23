import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:p2/api_service/api_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../card_new.dart';
import 'package:p2/api_service/api_service_models.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  final DateTime now = DateTime.now();
  late DateTime start;
  late DateTime end;

  late String dropdownValueSector;
  List<String> sectorItems = [];

  late String dropdownValueCity;
  List<String> cityItems = [];

  late String dropdownValueStore;
  List<String> storeItems = [];

  // String dropdownValueCashier = 'Все продавцы';
  // late List<String> cashierItems;

  Future getSources() async {
    try {
      if (sectorItems.isNotEmpty) {
        return;
      }
      AvailableSources sources = (await ApiService().getAvailableSources())!;
      sectorItems = sources.sectors;
      cityItems = sources.cities;
      storeItems = sources.stores;
      if (sectorItems.isEmpty) {
        sectorItems.add('');
      }
      if (cityItems.isEmpty) {
        cityItems.add('');
      }
      if (storeItems.isEmpty) {
        storeItems.add('');
      }
      dropdownValueSector = sectorItems[0];
      dropdownValueCity = cityItems[0];
      dropdownValueStore = storeItems[0];
      log('_getSources()');
    } catch (e) {
      log(e.toString());
    }
  }

  late Map<String, CardDataModel>? _cardsData = {};
  Future _getData() async {
    try {
      //log('$start, $end');
      _cardsData = (await ApiService().getCardsData(start, end,
          dropdownValueSector, dropdownValueCity, dropdownValueStore))!;
      log('_getData()');
    } catch (e) {
      log(e.toString());
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    callboth();
    start = DateTime(now.year, now.month, 1);
    end = ((now.month < 12)
            ? DateTime(now.year, now.month + 1, 1)
            : DateTime(now.year + 1, 1, 1))
        .subtract(const Duration(days: 1));
  }

  Future<void> callboth() async {
    getSources();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    final theme = Theme.of(context).colorScheme;
    return FutureBuilder(
        future: callboth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // return const Center(
            //     child: CircularProgressIndicator());
            return const SizedBox();
          } else {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),

              color: theme.background,
              //color: Color(0xFFF5F5F5),

              // child: GridView.count(
              //   crossAxisCount: 1,
              //   mainAxisSpacing: 10,
              //   crossAxisSpacing: 10,
              //   children: cards,
              // ),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.outline),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: FutureBuilder(
                              future: getSources(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  // return const Center(
                                  //     child: CircularProgressIndicator());
                                  return const SizedBox(
                                      width: double.infinity, height: 50);
                                } else {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            right: 30, left: 30),
                                        child: DropdownButton(
                                          value: dropdownValueSector,
                                          items:
                                              sectorItems.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(
                                              () {
                                                dropdownValueSector = newValue!;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: DropdownButton(
                                          value: dropdownValueCity,
                                          items: cityItems.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValueCity = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: DropdownButton(
                                          value: dropdownValueStore,
                                          items: storeItems.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValueStore = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                      // Container( TODO ???
                                      //   padding: const EdgeInsets.only(right: 30),
                                      //   child: DropdownButton(
                                      //     value: dropdownValueCashier,
                                      //     items: cashierItems.map((String items) {
                                      //       return DropdownMenuItem(
                                      //         value: items,
                                      //         child: Text(items),
                                      //       );
                                      //     }).toList(),
                                      //     // After selecting the desired option,it will
                                      //     // change button value to selected value
                                      //     onChanged: (String? newValue) {
                                      //       setState(() {
                                      //         dropdownValueCashier = newValue!;
                                      //       });
                                      //     },
                                      //   ),
                                      // ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                content: SizedBox(
                                                  width: 400,
                                                  height: 300,
                                                  child: SfDateRangePicker(
                                                      view: DateRangePickerView
                                                          .month,
                                                      selectionMode:
                                                          DateRangePickerSelectionMode
                                                              .extendableRange,
                                                      monthViewSettings:
                                                          const DateRangePickerMonthViewSettings(
                                                              firstDayOfWeek:
                                                                  2),
                                                      initialSelectedRange:
                                                          PickerDateRange(
                                                              start, end),
                                                      onSelectionChanged:
                                                          (_range) {
                                                        setState(() {
                                                          start = _range
                                                              .value.startDate;
                                                          end = _range
                                                              .value.endDate;
                                                          log('startend: $start, $end');
                                                        });
                                                      }),
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                              PhosphorIcons.calendar),
                                        ),
                                      ),
                                      // Container(
                                      //   padding: EdgeInsets.only(right: 30),
                                      //   child: DropdownButton(
                                      //     value: dataItems[0],
                                      //     items: dataItems,
                                      //     onChanged: (value) {},
                                      //     // After selecting the desired option,it will
                                      //     // change button value to selected value

                                      //     // onChanged: (String? newValue) {
                                      //     //   setState(() {
                                      //     //     dropdownValueCashier = newValue!;
                                      //     //   });
                                      //     // },
                                      //   ),
                                      // ),
                                    ],
                                  );
                                }
                              })),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: _getData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: (MediaQuery.of(context)
                                                    .size
                                                    .width ~/
                                                250)
                                            .toInt(),
                                        mainAxisExtent: 207,
                                        //childAspectRatio: 6 / 5,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5),
                                //const SliverGridDe legateWithMaxCrossAxisExtent(
                                //    maxCrossAxisExtent: 240,
                                //    mainAxisExtent: 207,
                                //    //childAspectRatio: 6 / 5,
                                //    crossAxisSpacing: 5,
                                //    mainAxisSpacing: 5),
                                //padding: const EdgeInsets.all(10),
                                itemCount: _cardsData!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //var e = stats.entries.toList()[index];
                                  var e = _cardsData!.entries.toList()[index];

                                  final name = e.key;
                                  final plan = e.value.plan;
                                  final pred = e.value.pred;
                                  final fact = e.value.fact;
                                  //final containerWidth = MediaQuery.of(context).size.width - 10; // minus paddings +spcgs
                                  //final cardCount = (containerWidth / (270 + 10)).floor(); // plus spacings
                                  //final cardWidth = containerWidth / cardCount - 11;
                                  //final cardWidth = cardCount == 1 ? containerWidth - 10 : 270.0;
                                  //print(cardWidth);
                                  bool state = true;
                                  return StatCard(
                                      width: MediaQuery.of(context).size.width <
                                              500
                                          ? MediaQuery.of(context).size.width -
                                              50
                                          : 240,
                                      name: name,
                                      plan: plan.toDouble(),
                                      pred: pred.toDouble(),
                                      fact: fact.toDouble(),
                                      state: state,
                                      start: start,
                                      end: end,
                                      sector: dropdownValueSector,
                                      city: dropdownValueCity,
                                      store: dropdownValueStore);
                                }
                                //separatorBuilder: (BuildContext context, int index) => const Divider(),
                                );
                          }
                        }),
                  ),
                ],
              ),
            );
          }
        });
  }
}
