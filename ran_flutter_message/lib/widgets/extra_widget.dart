import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/message_provider.dart';
import 'package:ran_flutter_message/widgets/circle_page_indicator.dart';
import 'package:ran_flutter_message/widgets/extra_item.dart';

class DefaultExtraWidget extends StatefulWidget {
  final Function(Map<String, Object>) onPressed;

  const DefaultExtraWidget({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  _DefaultExtraWidgetState createState() => _DefaultExtraWidgetState();
}

class _DefaultExtraWidgetState extends State<DefaultExtraWidget> {
  final _currentPageNotifier = ValueNotifier<int>(0);

  var _pageController = new PageController(initialPage: 0);

  Widget getEveryPage(int index) {
    int startIndex = index * 8;
    int endIndex = MessageProvider.extraItems.length;
    List<ExtraItemContainer> firstRow = [];
    List<ExtraItemContainer> secondRow = [];
    for (var i = startIndex; i < endIndex; i++) {
      if (i >= startIndex + 8 || i >= MessageProvider.extraItems.length) {
        break;
      }
      if (firstRow.length < 4) {
        firstRow.add(ExtraItemContainer(
          leadingIconPath: MessageProvider.extraItems[i].leadingIconPath,
          text: MessageProvider.extraItems[i].text,
          onTab: () async {
            Map<String, Object> result =
               await MessageProvider.extraItems[i].onHandle();
            if(result.isNotEmpty) {
              widget.onPressed(result);
            }
          },
        ));
      } else {
        secondRow.add(ExtraItemContainer(
          leadingIconPath: MessageProvider.extraItems[i].leadingIconPath,
          text: MessageProvider.extraItems[i].text,
          onTab: () async {
            Map<String, Object> result =
            await MessageProvider.extraItems[i].onHandle();
            if(result.isNotEmpty) {
              widget.onPressed(result);
            }
          },
        ));
      }
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: firstRow,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Row(
//            mainAxisAlignment: MainAxisAlignment.start,
            children: secondRow,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int extraItemLength = 0;
    if (MessageProvider.extraItems.length % 8 == 0) {
      extraItemLength = MessageProvider.extraItems.length ~/ 8;
    } else {
      extraItemLength = MessageProvider.extraItems.length ~/ 8 + 1;
    }
    return new Container(
        color: Color(0xffF6F6F6),
        child: Column(
          children: <Widget>[
            Container(
              height: 170.0,
              child: new PageView.builder(
                onPageChanged: (int index) {
                  _currentPageNotifier.value = index;
                },
                itemCount: extraItemLength,
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  return getEveryPage(index);
                },
              ),
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CirclePageIndicator(
                itemCount: extraItemLength,
                currentPageNotifier: _currentPageNotifier,
              ),
            ))
          ],
        ));
  }
}
