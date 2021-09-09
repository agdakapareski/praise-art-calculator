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
  // var hargaDesain = durasiController.text == ''
  //       ? 0
  //       : 1000 * int.parse(durasiController.text);
  //   double format = (hitungHPP(
  //             panjangController.text == ''
  //                 ? 0
  //                 : int.parse(panjangController.text),
  //             lebarController.text == '' ? 0 : int.parse(lebarController.text),
  //             selectedKetebalan == null ? 0 : double.parse(selectedKetebalan!),
  //             selectedMaterial == null ? 'none' : selectedMaterial!,
  //             selectedKerumitan == null ? 'low' : selectedKerumitan!,
  //             selectedFinishing == null ? 'none' : selectedFinishing!,
  //           ) /
  //           1000) +
  //       0.5;
  //   round = (format.roundToDouble()) *
  //       1000 *
  //       (jumlahController.text == '' ? 1 : int.parse(jumlahController.text));

  //   hpp = hargaDesain + round;
  //   String formattedHpp = NumberFormat.simpleCurrency(
  //     name: 'Rp. ',
  //     locale: 'id',
  //   ).format(hpp);

  //   hargaJual = hpp +
  //       (hpp *
  //           (profitController.text == ''
  //               ? 0
  //               : int.parse(profitController.text) / 100));
  //   String formattedHargaJual = NumberFormat.simpleCurrency(
  //     name: 'Rp. ',
  //     locale: 'id',
  //   ).format(hargaJual);
  //   double berat = hitungBerat(
  //     panjangController.text == '' ? 0 : int.parse(panjangController.text),
  //     lebarController.text == '' ? 0 : int.parse(lebarController.text),
  //     selectedKetebalan == null ? 0 : double.parse(selectedKetebalan!),
  //     selectedMaterial == null ? 'none' : selectedMaterial!,
  //   );

  //   double estimasiBerat = berat - (berat * 0.3);
  // double formattedHpp = ((hpp / 1000) + 0.5).roundToDouble() * 1000;

  // fungsi untuk menghitung harga pokok yang akan ditampilkan pada kalkulator
  // double hargaPokok(double formattedHpp, int jumlah) {
  //   double hargaPokok = formattedHpp * jumlah;
  //   return hargaPokok;
  // }

  // fungsi untuk menghitung harga jual yang akan ditampilkan pada kalkulator
  // double hargaJual(double hpp, int profit) {
  //   double hargaJual = hpp + (hpp * profit / 100);
  //   return hargaJual;
  // }

  // fungsi untuk mengubah format harga yang semula number
  // menjadi string dengan format (Rp. XXX.XXX,00)
  // hargaText(double harga) {
  //   String formatted =
  //       NumberFormat.simpleCurrency(name: 'Rp. ', locale: 'id').format(harga);

  //   return formatted;
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
            hpp = 0;
            hargaJual = 0;
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
              width > 899
                  ? Expanded(
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
                    )
                  : SizedBox(),
              Expanded(
                child: Container(
                  height: height,
                  padding: width > 899
                      ? EdgeInsets.only(
                          right: 100,
                          top: 80,
                        )
                      : EdgeInsets.all(18),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      width <= 899
                          ? Container(
                              margin: EdgeInsets.only(bottom: 18),
                              child: Image.asset(
                                'assets/logo-praise-art.png',
                                height: 80,
                              ),
                            )
                          : SizedBox(),
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
                            onChanged: (value) {
                              setState(() {
                                hpp = hitungHPP(
                                  panjangController.text == ''
                                      ? 0
                                      : int.parse(panjangController.text),
                                  lebarController.text == ''
                                      ? 0
                                      : int.parse(lebarController.text),
                                  selectedKetebalan == null
                                      ? 0
                                      : double.parse(selectedKetebalan!),
                                  selectedMaterial ?? 'none',
                                  selectedKerumitan ?? '',
                                  selectedFinishing ?? 'none',
                                  durasiController.text == ''
                                      ? 0
                                      : int.parse(durasiController.text),
                                  int.parse(jumlahController.text),
                                );
                                hargaJual = hitungHargaJual(
                                  hpp,
                                  profitController.text == ''
                                      ? 0
                                      : int.parse(profitController.text),
                                );
                              });
                            },
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
                                  onChanged: (value) {
                                    setState(() {
                                      berat = hitungBerat(
                                        panjangController.text == ''
                                            ? 0
                                            : int.parse(panjangController.text),
                                        lebarController.text == ''
                                            ? 0
                                            : int.parse(lebarController.text),
                                        selectedKetebalan == null
                                            ? 0
                                            : double.parse(selectedKetebalan!),
                                        selectedMaterial ?? 'none',
                                      );
                                      hpp = hitungHPP(
                                        panjangController.text == ''
                                            ? 0
                                            : int.parse(panjangController.text),
                                        lebarController.text == ''
                                            ? 0
                                            : int.parse(lebarController.text),
                                        selectedKetebalan == null
                                            ? 0
                                            : double.parse(selectedKetebalan!),
                                        selectedMaterial ?? 'none',
                                        selectedKerumitan ?? '',
                                        selectedFinishing ?? 'none',
                                        durasiController.text == ''
                                            ? 0
                                            : int.parse(durasiController.text),
                                        int.parse(jumlahController.text),
                                      );
                                      hargaJual = hitungHargaJual(
                                        hpp,
                                        profitController.text == ''
                                            ? 0
                                            : int.parse(profitController.text),
                                      );
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      berat = hitungBerat(
                                        panjangController.text == ''
                                            ? 0
                                            : int.parse(panjangController.text),
                                        lebarController.text == ''
                                            ? 0
                                            : int.parse(lebarController.text),
                                        selectedKetebalan == null
                                            ? 0
                                            : double.parse(selectedKetebalan!),
                                        selectedMaterial ?? 'none',
                                      );

                                      hpp = hitungHPP(
                                        panjangController.text == ''
                                            ? 0
                                            : int.parse(panjangController.text),
                                        lebarController.text == ''
                                            ? 0
                                            : int.parse(lebarController.text),
                                        selectedKetebalan == null
                                            ? 0
                                            : double.parse(selectedKetebalan!),
                                        selectedMaterial ?? 'none',
                                        selectedKerumitan ?? '',
                                        selectedFinishing ?? 'none',
                                        durasiController.text == ''
                                            ? 0
                                            : int.parse(durasiController.text),
                                        int.parse(jumlahController.text),
                                      );
                                      hargaJual = hitungHargaJual(
                                        hpp,
                                        profitController.text == ''
                                            ? 0
                                            : int.parse(profitController.text),
                                      );
                                    });
                                  },
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
                                            selectedKetebalan = val as String?;
                                            berat = hitungBerat(
                                              panjangController.text == ''
                                                  ? 0
                                                  : int.parse(
                                                      panjangController.text),
                                              lebarController.text == ''
                                                  ? 0
                                                  : int.parse(
                                                      lebarController.text),
                                              selectedKetebalan == null
                                                  ? 0
                                                  : double.parse(
                                                      selectedKetebalan!),
                                              selectedMaterial ?? 'none',
                                            );
                                            hpp = hitungHPP(
                                              panjangController.text == ''
                                                  ? 0
                                                  : int.parse(
                                                      panjangController.text),
                                              lebarController.text == ''
                                                  ? 0
                                                  : int.parse(
                                                      lebarController.text),
                                              selectedKetebalan == null
                                                  ? 0
                                                  : double.parse(
                                                      selectedKetebalan!),
                                              selectedMaterial ?? 'none',
                                              selectedKerumitan ?? '',
                                              selectedFinishing ?? 'none',
                                              durasiController.text == ''
                                                  ? 0
                                                  : int.parse(
                                                      durasiController.text),
                                              int.parse(jumlahController.text),
                                            );
                                            hargaJual = hitungHargaJual(
                                              hpp,
                                              profitController.text == ''
                                                  ? 0
                                                  : int.parse(
                                                      profitController.text),
                                            );
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
                                      berat = hitungBerat(
                                        panjangController.text == ''
                                            ? 0
                                            : int.parse(panjangController.text),
                                        lebarController.text == ''
                                            ? 0
                                            : int.parse(lebarController.text),
                                        selectedKetebalan == null
                                            ? 0
                                            : double.parse(selectedKetebalan!),
                                        selectedMaterial ?? 'none',
                                      );
                                      hpp = hitungHPP(
                                        panjangController.text == ''
                                            ? 0
                                            : int.parse(panjangController.text),
                                        lebarController.text == ''
                                            ? 0
                                            : int.parse(lebarController.text),
                                        selectedKetebalan == null
                                            ? 0
                                            : double.parse(selectedKetebalan!),
                                        selectedMaterial ?? 'none',
                                        selectedKerumitan ?? '',
                                        selectedFinishing ?? 'none',
                                        durasiController.text == ''
                                            ? 0
                                            : int.parse(durasiController.text),
                                        int.parse(jumlahController.text),
                                      );
                                      hargaJual = hitungHargaJual(
                                        hpp,
                                        profitController.text == ''
                                            ? 0
                                            : int.parse(profitController.text),
                                      );
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
                                      hpp = hitungHPP(
                                        panjangController.text == ''
                                            ? 0
                                            : int.parse(panjangController.text),
                                        lebarController.text == ''
                                            ? 0
                                            : int.parse(lebarController.text),
                                        selectedKetebalan == null
                                            ? 0
                                            : double.parse(selectedKetebalan!),
                                        selectedMaterial ?? 'none',
                                        selectedKerumitan ?? '',
                                        selectedFinishing ?? 'none',
                                        durasiController.text == ''
                                            ? 0
                                            : int.parse(durasiController.text),
                                        int.parse(jumlahController.text),
                                      );
                                      hargaJual = hitungHargaJual(
                                        hpp,
                                        profitController.text == ''
                                            ? 0
                                            : int.parse(profitController.text),
                                      );
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
                                      hpp = hitungHPP(
                                        panjangController.text == ''
                                            ? 0
                                            : int.parse(panjangController.text),
                                        lebarController.text == ''
                                            ? 0
                                            : int.parse(lebarController.text),
                                        selectedKetebalan == null
                                            ? 0
                                            : double.parse(selectedKetebalan!),
                                        selectedMaterial ?? 'none',
                                        selectedKerumitan ?? '',
                                        selectedFinishing ?? 'none',
                                        durasiController.text == ''
                                            ? 0
                                            : int.parse(durasiController.text),
                                        int.parse(jumlahController.text),
                                      );
                                      hargaJual = hitungHargaJual(
                                        hpp,
                                        profitController.text == ''
                                            ? 0
                                            : int.parse(profitController.text),
                                      );
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
                                  onChanged: (value) {
                                    setState(() {
                                      hpp = hitungHPP(
                                        panjangController.text == ''
                                            ? 0
                                            : int.parse(panjangController.text),
                                        lebarController.text == ''
                                            ? 0
                                            : int.parse(lebarController.text),
                                        selectedKetebalan == null
                                            ? 0
                                            : double.parse(selectedKetebalan!),
                                        selectedMaterial ?? 'none',
                                        selectedKerumitan ?? '',
                                        selectedFinishing ?? 'none',
                                        durasiController.text == ''
                                            ? 0
                                            : int.parse(durasiController.text),
                                        int.parse(jumlahController.text),
                                      );
                                      hargaJual = hitungHargaJual(
                                        hpp,
                                        profitController.text == ''
                                            ? 0
                                            : int.parse(profitController.text),
                                      );
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      hargaJual = hitungHargaJual(
                                        hpp,
                                        profitController.text == ''
                                            ? 0
                                            : int.parse(profitController.text),
                                      );
                                    });
                                  },
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
                            (berat - (berat * 0.3)).toStringAsFixed(2) + ' Kg',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Harga Pokok : '),
                          Text(
                            NumberFormat.simpleCurrency(
                                    name: 'Rp. ', locale: 'id')
                                .format(hpp),
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
                                ClipboardData(
                                  text: NumberFormat.simpleCurrency(
                                          name: 'Rp. ', locale: 'id')
                                      .format(hargaJual),
                                ),
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
                          Text(
                            NumberFormat.simpleCurrency(
                                    name: 'Rp. ', locale: 'id')
                                .format(hargaJual),
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
  }
}
