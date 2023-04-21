import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterLogo(),
              titlePadding: EdgeInsets.zero,
              title: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Color(0x70000000),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sliver',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return Column(
                  children: [
                    buildContainers('TEXT1', Colors.red),
                    Container(
                        color: Colors.orange,
                        child: buildAnimatedContainers(
                            'TEXT2', Colors.redAccent, 0)),
                    Container(
                        color: Colors.amber,
                        child:
                            buildAnimatedContainers('TEXT3', Colors.orange, 1)),
                    buildAnimatedContainers('TEXT4', Colors.amber, 2),
                  ],
                );
              },
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            // 화면에 표시될 위젯을 설정
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.green,
                  child: Text(
                    'Grid Item $index',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAnimatedContainers(String text, Color color, int index) {
    List<bool> selected = [false, false, false];
    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          onTap: () {
            setState(() {
              for (int i = 0; i < selected.length; i++) {
                if (i == index) {
                  selected[i] = !selected[i];
                }
              }
            });
          },
          child: AnimatedContainer(
            height: selected[index] ? 150 : 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
              color: color,
            ),
            duration: Duration(milliseconds: 600),
            curve: Curves.fastOutSlowIn,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      selected[index]
                          ? CupertinoIcons.arrowtriangle_up_fill
                          : CupertinoIcons.arrowtriangle_down_fill,
                      color: Colors.white,
                    ),
                    Text(
                      text,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildContainers(String text, Color color) {
    return Container(
      color: Colors.redAccent,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
          color: color,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Text(
                text,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
