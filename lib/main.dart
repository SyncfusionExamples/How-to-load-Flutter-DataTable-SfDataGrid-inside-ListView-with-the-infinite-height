import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MaterialApp(home: SfDataGridDemo()));
}

class SfDataGridDemo extends StatefulWidget {
  const SfDataGridDemo({Key? key}) : super(key: key);

  @override
  _SfDataGridDemoState createState() => _SfDataGridDemoState();
}

class _SfDataGridDemoState extends State<SfDataGridDemo> {
  List<Employee> _employees = <Employee>[];
  late EmployeeDataGridSource _employeeDataSource;

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataGridSource(employeeData: _employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Syncfusion Flutter DataGrid')),
        body: ListView(children: <Widget>[
          Card(child: dataGrid()),
          Card(child: dataGrid())
        ]));
  }

  SfDataGrid dataGrid() {
    return SfDataGrid(
        shrinkWrapRows: true,
        source: _employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  child: const Text('ID'))),
          GridColumn(
              columnName: 'name',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Name'))),
          GridColumn(
              columnName: 'designation',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Designation',
                      overflow: TextOverflow.ellipsis))),
          GridColumn(
              columnName: 'salary',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  child: const Text('Salary'))),
        ]);
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'Lara', 'Project Lead', 40000),
      Employee(10002, 'James', 'Developer', 23000),
      Employee(10003, 'Kathryn', 'Project Lead', 43500),
      Employee(10004, 'Michael', 'Manager', 50000),
      Employee(10005, 'Martin', 'Developer', 25000),
      Employee(10006, 'Jack', 'Project Lead', 54000),
      Employee(10007, 'Balnc', 'UI Designer', 28500),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 26000),
      Employee(10010, 'Grimes', 'Developer', 35000)
    ];
  }
}

class EmployeeDataGridSource extends DataGridSource {
  EmployeeDataGridSource({required List<Employee> employeeData}) {
    _dataGridRows = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _dataGridRows = [];

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}
