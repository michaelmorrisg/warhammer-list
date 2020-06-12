import 'stat_item.dart';

class StatItemList {
  List<StatItem> statItemList = [
    StatItem(id: 1, imageText: 'PH', name: 'Pink Horror'),
    StatItem(id: 2, imageText: 'BH', name: 'Blue Horror'),
    StatItem(id: 3, imageText: 'F', name: 'Flamer'),
    StatItem(id: 4, imageText: 'LOC', name: 'Lord of Change'),
    StatItem(id: 5, imageText: 'DP', name: 'Demon Prince'),
  ];

  filterList(List selectedStatItems) {
    var list = this.statItemList;
    for (var i = 0; i < selectedStatItems.length; i ++) {
      list.removeWhere((statItem) => statItem.id == selectedStatItems[i].id);
    }
    return list.toList();
  }

  // StatItem getStatItems(index, context) {
  //   return statItemList[index];
  // }
}
