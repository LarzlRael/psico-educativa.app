part of '../custom_widgets.dart';

DataRow customDataRow(
  String title,
  String content,
) {
  final isArray = content.contains(',');

  final arrayInfo = isArray ? content.split(',') : [content];
  return DataRow(
    cells: [
      // Title Cell
      DataCell(
        SimpleText(
          title,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      // Content Cell
      DataCell(
        arrayInfo.length > 1
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight:
                      300, // Ajusta la altura máxima a un valor razonable
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: arrayInfo
                        .map(
                          (e) => Row(
                            children: [
                              Flexible(
                                child: SimpleText(
                                  e,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            : SimpleText(
                content,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
      ),
    ],
  );
}
