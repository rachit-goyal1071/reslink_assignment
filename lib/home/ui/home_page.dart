import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reslink_test/constants/colors.dart';
import 'package:reslink_test/constants/dimensions.dart';
import 'package:reslink_test/home/repo/home_repo.dart';
import 'package:reslink_test/home/widgets/widgets.dart';
import 'package:reslink_test/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> placeList = ['Office','Bedroom','Living Room'];
  String dropDownValue = 'Office';
  List<String> airFilterName = ['AQI level','PM 1','PM 2.5', 'PM 10'];
  List<String> settingsList = [
    'Swing', 'Timer', 'Calm/Boost', 'Power', 'Air Purifier', 'Aqi'
  ];
  List<String> svgAssetsList = [
    'assets/svgs/swing.svg',
    'assets/svgs/timer.svg',
    'assets/svgs/wind.svg',
    'assets/svgs/power.svg',
    'assets/svgs/ap.svg',
    'assets/svgs/aqi.svg'
  ];
  List<int> airFilterValue = [82,37,48,62];
  double heatValue = 0.5;
  ValueNotifier<double> speedValue = ValueNotifier<double>(0.5);
  ValueNotifier<double> colorValue = ValueNotifier<double>(0.5);
  ValueNotifier<double> brightnessValue = ValueNotifier<double>(0.5);

  getScreenBrightness() async {
    final data = await HomeRepo.systemBrightness();
    setState(() {
      heatValue = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getScreenBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity !<0) {
          showModalBottomSheet(
            isDismissible: true,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  width: getScreenWidth(context),
                  height: getScreenHeight(context) * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5),
                    ],
                  ),
                  child: Column(
                    spacing: getScreenHeight(context) * 0.003,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: getScreenHeight(context) * 0.09,
                          padding: EdgeInsets.only(
                              bottom: getScreenHeight(context) * 0.03
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)
                              ),
                              boxShadow: kElevationToShadow[1]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(getScreenWidth(context) * 0.003),
                                child: Divider(
                                  color: lightGreyColor,
                                  thickness: getScreenHeight(context) * 0.005,
                                  height: getScreenHeight(context) * 0.01,
                                  indent: getScreenWidth(context) * 0.42,
                                  endIndent: getScreenWidth(context) * 0.42,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getScreenWidth(context) * 0.04
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: SvgPicture.asset(
                                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.clear),
                                          'assets/svgs/gear.svg'
                                      ),
                                    ),
                                    NormalTextBody(
                                      text: 'Title',
                                      size: 0.045,
                                    ),
                                    SimpleChildButton(
                                        onTap: () {},
                                        child: SvgPicture.asset(
                                          'assets/svgs/gear.svg',
                                          width: getScreenWidth(context) * 0.05,
                                        )
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.asset(
                            width: getScreenWidth(context) * 0.85,
                              'assets/images/filter.png'
                          ),
                          NormalTextBody(
                            weight: FontWeight.w500,
                              text: 'AQI: 500'
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getScreenHeight(context) * 0.065,
                      ),
                      SizedBox(
                        width: getScreenWidth(context) * 0.95,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Column(
                              spacing: getScreenHeight(context) * 0.07,
                              children: [
                                ValueListenableBuilder(
                                    valueListenable: speedValue,
                                    builder: (context, _, __) {
                                      return Transform.rotate(
                                        angle: (22/14)*3,
                                        child: CustomSlider(
                                            value: speedValue.value,
                                            onChanged: (value){
                                              setState(() {
                                                speedValue.value = value;
                                              });
                                            }
                                        ),
                                      );
                                    }
                                ),
                                NormalTextBody(
                                  weight: FontWeight.w500,
                                    text: 'Speed')
                              ],
                            ),
                            Positioned(
                              left: getScreenWidth(context) * 0.3,
                              child: Column(
                                spacing: getScreenHeight(context) * 0.07,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: colorValue,
                                      builder: (context, _, __) {
                                        return Transform.rotate(
                                          angle: (22/14)*3,
                                          child: CustomSlider(
                                              value: colorValue.value,
                                              onChanged: (value){
                                                setState(() {
                                                  colorValue.value = value;
                                                });
                                              }
                                          ),
                                        );
                                      }
                                  ),
                                  NormalTextBody(
                                      weight: FontWeight.w500,
                                      text: 'Color')
                                ],
                              ),
                            ),
                            Positioned(
                              left: getScreenWidth(context) * 0.6,
                              child: Column(
                                spacing: getScreenHeight(context) * 0.07,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: brightnessValue,
                                      builder: (context, _, __) {
                                        return Transform.rotate(
                                          angle: (22/14)*3,
                                          child: CustomSlider(
                                              value: brightnessValue.value,
                                              onChanged: (value) async{
                                                await HomeRepo.setApplicationBrightness(value);
                                                setState(() {
                                                  brightnessValue.value = value;
                                                });
                                              }
                                          ),
                                        );
                                      }
                                  ),
                                  NormalTextBody(
                                      weight: FontWeight.w500,
                                      text: 'Brightness')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                          horizontal: getScreenWidth(context) * 0.1
                        ),
                        width: getScreenWidth(context),
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: getScreenWidth(context)*0.1,
                          runSpacing: getScreenWidth(context)*0.14,
                          children: List.generate(6, (index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: getScreenHeight(context) * 0.075,
                                  width: getScreenHeight(context) * 0.075,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: inactiveTrackColor
                                  ),
                                  child: SimpleChildButton(
                                    onTap: () async {
                                      setState((){
                                        heatValue = 0;
                                      });
                                      await HomeRepo.setApplicationBrightness(0);
                                    },
                                    child: SvgPicture.asset(
                                      svgAssetsList[index]
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getScreenWidth(context) * 0.2,
                                  child: Center(
                                    child: NormalTextBody(
                                      size: 0.035,
                                        weight: FontWeight.w500,
                                        text: settingsList[index]),
                                  ),
                                )
                              ],
                            );
                          }
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2.5,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          leading: Icon(CupertinoIcons.bell_fill),
          actions: [
            DropdownButton<String>(
              icon: Icon(Icons.expand_more),
              underline: Container(color: Colors.transparent),
              padding: EdgeInsets.symmetric(
                horizontal: getScreenWidth(context) * 0.1
              ),
              borderRadius: BorderRadius.circular(12),
              dropdownColor: Colors.white,
              alignment: Alignment(1,1),
              value: dropDownValue,
              items: placeList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: NormalTextBody(text: value,weight: FontWeight.w500,),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropDownValue = value!;
                });
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getScreenHeight(context) * 0.04,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: getScreenHeight(context) * 0.0,
                  horizontal: getScreenWidth(context) * 0.04
              ),
              padding: EdgeInsets.symmetric(
                  vertical: getScreenHeight(context) * 0.0,
                  horizontal: getScreenWidth(context) * 0.02
              ),
              child: Container(
                height: getScreenHeight(context) * 0.2,
                width: getScreenWidth(context),
                margin: EdgeInsets.symmetric(
                  horizontal: getScreenWidth(context) * 0.02
                ),
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.3
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: airFilterName.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: getScreenHeight(context) * 0.005,
                            horizontal: getScreenWidth(context) * 0.03
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: getScreenHeight(context) * 0.005,
                          horizontal: getScreenHeight(context) * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: inactiveTrackColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getScreenWidth(context) * 0.02
                              ),
                              child: NormalTextBody(
                                text: airFilterName[index],
                                size: 0.03,
                                weight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              height: getScreenHeight(context) * 0.06,
                              width: getScreenHeight(context) * 0.06,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: getScreenHeight(context) * 0.005,
                                horizontal: getScreenHeight(context) * 0.005,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffEDEFF1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: NormalTextBody(
                                text: '${airFilterValue[index]}',
                                size: 0.05,
                                color: primaryBlueColor,
                              ),
                            )
                          ],
                        ),
                      );
                    }
                ),
              ),
            ),
            Container(
              width: getScreenWidth(context),
              height: getScreenHeight(context) * 0.34,
              margin: EdgeInsets.only(
                bottom: getScreenHeight(context) * 0.04
              ),
              child: Swiper(
                itemCount: 3,
                pagination: SwiperPagination(
                    margin: EdgeInsets.symmetric(
                        vertical:
                        getScreenHeight(context) * 0.01),
                    alignment: Alignment(0, 1.3),
                    builder: CustomSwiperPaginationBuilder()),
                itemBuilder: (context, indexU) {
                  return Image.asset(
                    'assets/images/device.png',
                    height: getScreenHeight(context) * 0.32,
                    width: getScreenWidth(context) * 0.6,
                    fit: BoxFit.fitHeight,
                    colorBlendMode: BlendMode.color,
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: getScreenHeight(context) * 0.08
              ),
              width: getScreenWidth(context),
              child: Row(
                spacing: getScreenWidth(context) * 0.05,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: getScreenHeight(context) * 0.075,
                    width: getScreenHeight(context) * 0.075,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: inactiveTrackColor
                    ),
                    child: SimpleChildButton(
                      onTap: () async {
                        setState((){
                          heatValue = 0;
                        });
                        await HomeRepo.setApplicationBrightness(0);
                      },
                      child: Container(
                        height: getScreenHeight(context) * 0.042,
                        width: getScreenHeight(context) * 0.042,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xffcd4e4e)
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomSlider(
                          value: heatValue,
                          onChanged: (value) async {
                            await HomeRepo.setApplicationBrightness(value);
                            setState(() {
                              heatValue = value;
                            });
                          }
                      ),
                      NormalTextBody(
                        size: 0.059,
                          weight: FontWeight.w500,
                          text: '${(heatValue * 10).toInt()}',
                        color: ((heatValue * 10).toInt() < 5 )? darkBlackShade:inactiveTrackColor,
                      )
                    ],
                  ),
                  Container(
                    height: getScreenHeight(context) * 0.075,
                    width: getScreenHeight(context) * 0.075,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: inactiveTrackColor
                    ),
                    child: SimpleChildButton(
                      onTap: () async{
                          setState(() {
                            heatValue = 1;
                          });
                          await HomeRepo.setApplicationBrightness(1);
                      },
                      child: SvgPicture.asset(
                          'assets/svgs/sun.svg'
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
