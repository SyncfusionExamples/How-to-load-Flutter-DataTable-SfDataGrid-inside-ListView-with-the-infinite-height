# How-to-load-Flutter-DataTable-SfDataGrid-inside-ListView-with-the-infinite-height

If you wrap the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) inside the [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html) widget, the DataGrid gets the height of infinity. By default, if the height of the SfDataGrid is infinity, and then DataGrid sets its height to 300. 

The Syncfusion [Flutter DataTable](https://help.syncfusion.com/flutter/datagrid/overview) provides the support to set the height based on the number of rows available in the DataGrid by using the [shrinkWrapRows](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/shrinkWrapRows.html) property.

The following steps explain how to load the DataGrid inside the ListView with the infinite height,

## STEP 1: 
Initialize the SfDataGrid widget with all the required properties and set `SfDataGrid.shrinkWrapRows` property to true. Wrap the DataGrid inside the ListView widget.

```dart
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
```

## STEP 2: 
Create a data source class by extending [DataGridSource](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource-class.html) for mapping data to the SfDataGrid.

```dart
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
```
>**NOTE**

Also, if you want to set the width based on the number of columns available in DataGrid, you can achieve it by setting the [shrinkWrapColumn](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/shrinkWrapColumns.html) property to true.