import 'package:flutter/material.dart';

List<String> material = ['MS', 'SUS', 'AL', 'none'];
List<String> ketebalan = ['0.8', '1', '1.5', '2', '2.5', '3'];
List<String> kerumitan = ['low', 'medium', 'high'];
List<String> finishing = ['none', 'cat', 'cat 2 warna', 'polish'];

double hpp = 0;
double round = 0;
double hargaJual = 0;

TextEditingController panjangController = TextEditingController();
TextEditingController lebarController = TextEditingController();
TextEditingController jumlahController = TextEditingController(text: '1');
TextEditingController durasiController = TextEditingController();
TextEditingController profitController = TextEditingController();

String? selectedMaterial;
String? selectedKetebalan;
String? selectedKerumitan;
String? selectedPackaging;
String? selectedFinishing;

double berat = 0;
