import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/ExpendTypeManagement/edit_row_dialog.dart';
import 'package:se_gay_components/common/sg_colors.dart';
import 'package:se_gay_components/common/sg_textfield.dart';

class KBView extends StatefulWidget {
  const KBView({super.key});

  @override
  State<KBView> createState() => _KBViewState();
}

class _KBViewState extends State<KBView> {
  final ScrollController horizontalController = ScrollController();
  String searchText = "";
  int? focusedRowIndex;

  // Dữ liệu mẫu
  final List<String> header1 = [
    "Stt",
    "Mã khoản",
    "Thành phần hao phí",
    "DVT",
    "M=2m",
    "M=2.5m",
    "M=3m",
    "M=3.5m",
    "M=4m",
    "M=4.5m",
    "M=5m",
    "M=5.5m",
    "M=6m",
    "M=6.5m",
    "M=7m",
    "M=7.5m",
    "M=8m",
    "M=8.5m",
    "M=9m",
    "M=9.5m",
    "M>=10m"
  ];
  final List<String> header2 = [
    "",
    "",
    "",
    "",
    "KBM20D1",
    "KBM25D1",
    "KBM30D1",
    "KBM35D1",
    "KBM40D1",
    "KBM45D1",
    "KBM50D1",
    "KBM55D1",
    "KBM60D1",
    "KBM65D1",
    "KBM70D1",
    "KBM75D1",
    "KBM80D1",
    "KBM85D1",
    "KBM90D1",
    "KBM95D1",
    "KBM100D1"
  ];
  final List<List<String>> allData = [
    [
      "1",
      "KT15",
      "Dây điện nổ mạng nổ (Md)",
      "m/1000T",
      "916.0",
      "749.0",
      "634.0",
      "549.0",
      "485.0",
      "434.0",
      "392.0",
      "358.0",
      "329.0",
      "305.0",
      "284.0",
      "266.0",
      "250.0",
      "235.0",
      "223.0",
      "211.0",
      "201.0"
    ],
    [
      "2",
      "KT11",
      "Gỗ chống 013-17",
      "m/1000T",
      "35.2",
      "28.8",
      "24.3",
      "21.1",
      "18.6",
      "16.7",
      "15.1",
      "13.8",
      "12.0",
      "11.7",
      "10.9",
      "10.2",
      "9.6",
      "9.0",
      "8.5",
      "9.3",
      "8.9",
      "8.1"
    ],
    // ... các dòng khác
  ];

  List<Widget> _buildRowCells(List<String> row, int columnCount, VoidCallback? onTap) {
    return List.generate(
      columnCount,
      (index) => InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Text(
            index < row.length ? row[index] : '',
            softWrap: true,
            maxLines: null,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _focusRow(int index) {
    setState(() {
      focusedRowIndex = index;
    });
  }

  List<List<String>> _getFilteredData() {
    if (searchText.isEmpty) return allData;
    return allData
        .where((row) => row.any((cell) => cell.toLowerCase().contains(searchText.toLowerCase())))
        .toList();
  }

  Widget _buildSearchBar(Size size) {
    return SizedBox(
      width: size.width * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SGTextField(
          backgroundColor: SGAppColors.info100,
          borderRadius: 10,
          hintText: "Nhập thông tin",
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          tooltip: "Sửa",
          onPressed: () async {
            if (focusedRowIndex == null || focusedRowIndex! >= allData.length) return;
            final row = allData[focusedRowIndex!];
            final result = await showEditRowDialog(
              context: context,
              title: 'Thông tin dòng đã chọn',
              headers: header1,
              initialValues: row,
              topCount: 3,
            );
            if (result != null) {
              print('Giá trị mới: $result');
              // Cập nhật lại dữ liệu nếu muốn
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: "Xóa",
          onPressed: () {
            if (focusedRowIndex != null) {
              _deleteRow(focusedRowIndex!);
            }
          },
        ),
      ],
    );
  }

  Widget _buildTable(List<List<String>> filteredData, int columnCount) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      defaultColumnWidth: const FixedColumnWidth(90.0),
      children: [
        // Header dòng 1
        TableRow(
          decoration: BoxDecoration(color: Colors.yellow[200]),
          children: _buildRowCells(header1, columnCount, null),
        ),
        // Header dòng 2
        TableRow(
          decoration: BoxDecoration(color: Colors.yellow[100]),
          children: _buildRowCells(header2, columnCount, null),
        ),
        // Data rows
        ...filteredData.asMap().entries.map((entry) {
          final isFocused = entry.key == focusedRowIndex;
          return TableRow(
            decoration: BoxDecoration(
              color: isFocused ? const Color.fromARGB(255, 197, 181, 34) : null,
            ),
            children: _buildRowCells(
              entry.value,
              columnCount,
              () => _focusRow(entry.key),
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<List<String>> filteredData = _getFilteredData();
    final int columnCount = header1.length;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSearchBar(size),
                _buildActionButtons(),
              ],
            ),
            // Bảng dữ liệu
            Expanded(
              child: Scrollbar(
                controller: horizontalController,
                thumbVisibility: true,
                notificationPredicate: (notification) =>
                    notification.metrics.axis == Axis.horizontal,
                child: SingleChildScrollView(
                  controller: horizontalController,
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: _buildTable(filteredData, columnCount),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm xóa dòng
  void _deleteRow(int index) {
    setState(() {
      allData.removeAt(index);
    });
  }
}
