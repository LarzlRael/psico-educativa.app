part of '../custom_widgets.dart';

Widget buildSkeletonItem() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[600]!,
    highlightColor: Colors.grey,
    child: Container(
      height: 100,
      color: Colors.grey[600],
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            color: Colors.grey[600],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  color: Colors.grey[600],
                ),
                SizedBox(height: 10),
                Container(
                  height: 20,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
