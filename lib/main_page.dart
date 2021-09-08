import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mit_calculator/Input_widget.dart';
import 'package:mit_calculator/data/formula.dart';
import 'package:mit_calculator/data/variables.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var hargaDesain = durasiController.text == ''
        ? 0
        : 1000 * int.parse(durasiController.text);
    double format = (hitungHPP(
              panjangController.text == ''
                  ? 0
                  : int.parse(panjangController.text),
              lebarController.text == '' ? 0 : int.parse(lebarController.text),
              selectedKetebalan == null ? 0 : double.parse(selectedKetebalan!),
              selectedMaterial == null ? 'none' : selectedMaterial!,
              selectedKerumitan == null ? 'low' : selectedKerumitan!,
              selectedFinishing == null ? 'none' : selectedFinishing!,
            ) /
            1000) +
        0.5;
    round = (format.roundToDouble()) *
        1000 *
        (jumlahController.text == '' ? 1 : int.parse(jumlahController.text));

    hpp = hargaDesain + round;
    String formattedHpp = NumberFormat.simpleCurrency(
      name: 'Rp. ',
      locale: 'id',
    ).format(hpp);

    hargaJual = hpp +
        (hpp *
            (profitController.text == ''
                ? 0
                : int.parse(profitController.text) / 100));
    String formattedHargaJual = NumberFormat.simpleCurrency(
      name: 'Rp. ',
      locale: 'id',
    ).format(hargaJual);
    double berat = hitungBerat(
      panjangController.text == '' ? 0 : int.parse(panjangController.text),
      lebarController.text == '' ? 0 : int.parse(lebarController.text),
      selectedKetebalan == null ? 0 : double.parse(selectedKetebalan!),
      selectedMaterial == null ? 'none' : selectedMaterial!,
    );

    double estimasiBerat = berat - (berat * 0.3);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (width > 900) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              durasiController.text = '';
              panjangController.text = '';
              lebarController.text = '';
              selectedKetebalan = null;
              selectedMaterial = null;
              selectedKerumitan = null;
              selectedFinishing = null;
              jumlahController.text = '1';
              profitController.text = '';
            });
          },
          child: Icon(
            Icons.refresh_rounded,
          ),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo-praise-art.png',
                          width: 300,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Laser Cutting Calculator',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'v 1.0.0',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: height,
                    padding: EdgeInsets.only(
                      right: 100,
                      top: 80,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pengerjaan Desain (jam)',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              controller: durasiController,
                              hintText: 'pengerjaan desain',
                              suffixText: 'jam',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Panjang (mm)',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextField(
                                    hintText: 'panjang',
                                    controller: panjangController,
                                    suffixText: 'mm',
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lebar (mm)',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextField(
                                    hintText: 'lebar',
                                    controller: lebarController,
                                    suffixText: 'mm',
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ketebalan (mm)',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 6,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: selectedKetebalan == null
                                            ? Text('ketebalan')
                                            : Text(
                                                selectedKetebalan!,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        isDense: true,
                                        style: TextStyle(color: Colors.black),
                                        items: ketebalan.map(
                                          (val) {
                                            return DropdownMenuItem<String>(
                                              value: val,
                                              child: Text(val + ' mm'),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (val) {
                                          setState(
                                            () {
                                              selectedKetebalan =
                                                  val as String?;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Material',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 6,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: selectedMaterial == null
                                      ? Text('material')
                                      : Text(
                                          selectedMaterial!,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  isDense: true,
                                  style: TextStyle(color: Colors.black),
                                  items: material.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        selectedMaterial = val as String?;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kerumitan',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 6,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: selectedKerumitan == null
                                      ? Text('kerumitan')
                                      : Text(
                                          selectedKerumitan!,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  isDense: true,
                                  style: TextStyle(color: Colors.black),
                                  items: kerumitan.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        selectedKerumitan = val as String?;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Finishing',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 6,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: selectedFinishing == null
                                      ? Text('finishing')
                                      : Text(
                                          selectedFinishing!,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  isDense: true,
                                  style: TextStyle(color: Colors.black),
                                  items: finishing.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        selectedFinishing = val as String?;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jumlah',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextField(
                                    controller: jumlahController,
                                    hintText: 'jumlah',
                                    suffixText: 'pcs',
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Profit',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextField(
                                    controller: profitController,
                                    hintText: 'profit',
                                    suffixText: '%',
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Estimasi Berat : '),
                            SelectableText(
                                estimasiBerat.toStringAsFixed(2) + ' Kg'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Harga Pokok : '),
                            SelectableText(
                              formattedHpp,
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          height: 25,
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Harga Jual : ',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: formattedHargaJual),
                                ).then((value) {
                                  final snackBar = SnackBar(
                                    content: Text('Copied to Clipboard'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                              },
                              child: Icon(
                                Icons.content_copy,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SelectableText(
                              formattedHargaJual,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              durasiController.text = '';
              panjangController.text = '';
              lebarController.text = '';
              selectedKetebalan = null;
              selectedMaterial = null;
              selectedKerumitan = null;
              selectedFinishing = null;
              jumlahController.text = '1';
              profitController.text = '';
            });
          },
          child: Icon(
            Icons.refresh_rounded,
          ),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              width: width * 0.92,
              height: height,
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/logo-praise-art.png',
                          width: 110,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Laser Cutting Calculator',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'v 1.0.0',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pengerjaan Desain (jam)',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        controller: durasiController,
                        hintText: 'pengerjaan desain',
                        suffixText: 'jam',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Panjang (mm)',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              hintText: 'panjang',
                              controller: panjangController,
                              suffixText: 'mm',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lebar (mm)',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              hintText: 'lebar',
                              controller: lebarController,
                              suffixText: 'mm',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ketebalan (mm)',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 6,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: selectedKetebalan == null
                                      ? Text('ketebalan')
                                      : Text(
                                          selectedKetebalan!,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  isDense: true,
                                  style: TextStyle(color: Colors.black),
                                  items: ketebalan.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val + ' mm'),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        selectedKetebalan = val as String?;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Material',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 6,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: selectedMaterial == null
                                ? Text('material')
                                : Text(
                                    selectedMaterial!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            isDense: true,
                            style: TextStyle(color: Colors.black),
                            items: material.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  selectedMaterial = val as String?;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kerumitan',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 6,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: selectedKerumitan == null
                                ? Text('kerumitan')
                                : Text(
                                    selectedKerumitan!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            isDense: true,
                            style: TextStyle(color: Colors.black),
                            items: kerumitan.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  selectedKerumitan = val as String?;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Finishing',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 6,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: selectedFinishing == null
                                ? Text('finishing')
                                : Text(
                                    selectedFinishing!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            isDense: true,
                            style: TextStyle(color: Colors.black),
                            items: finishing.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  selectedFinishing = val as String?;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jumlah',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              controller: jumlahController,
                              hintText: 'jumlah',
                              suffixText: 'pcs',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Profit',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              controller: profitController,
                              hintText: 'profit',
                              suffixText: '%',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estimasi Berat : '),
                      SelectableText(estimasiBerat.toStringAsFixed(2) + ' Kg'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Harga Pokok : '),
                      SelectableText(
                        formattedHpp,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 25,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Harga Jual : ',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: formattedHargaJual),
                          ).then((value) {
                            final snackBar = SnackBar(
                              content: Text('Copied to Clipboard'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
                        child: Icon(
                          Icons.content_copy,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SelectableText(
                        formattedHargaJual,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
