// fungsi untuk menghitung hpp + profit
hitungProfit(double hpp, double profit) {
  // variabel untuk menampung hasil perhitungan hpp + profit
  double hargaJual = 0;

  hargaJual = hpp + (hpp * profit);

  return hargaJual;
}

// fungsi untuk menghitung berat material sesuai ukuran
hitungBerat(
  int panjang,
  int lebar,
  double tebal,
  String material,
) {
  // variabel untuk menampung hasil perhitungan berat
  double berat = 0;

  // variabel berat jenis material MS
  double beratJenisMS = 7.85;

  // variabel berat jenis material AL
  double beratJenisAL = 2.7;

  if (material == 'MS' || material == 'SUS') {
    berat = (tebal * lebar.toDouble() * panjang.toDouble() * beratJenisMS) /
        1000000;
  } else if (material == 'AL') {
    berat = (tebal * lebar.toDouble() * panjang.toDouble() * beratJenisAL) /
        1000000;
  } else {
    berat = 0;
  }

  return berat;
}

// fungsi untuk menghitung hpp produk laser cutting
hitungHPP(
  int panjang,
  int lebar,
  double tebal,
  String material,
  String kerumitan,
  String finishing,
) {
  // variabel untuk menampung hasil perhitungan harga material per Kg
  double hargaMaterialPerKg = 0;

  // variabel harga materi MS
  double hargaMS = 23000;

  // variabel harga materi SUS
  double hargaSUS = 91000;

  // variabel harga materi AL
  double hargaAL = 91000;

  // variabel harga labelin produk
  double hargaLabeling = 1000;

  // variabel harga cat
  double hargaCat = 8000;

  // variabel harga cat 2 warna
  double hargaCat2Warna = 2 * hargaCat;

  // variabel harga poles
  double hargaPolish = 2000;

  // variabel harga jasa laser untuk materi MS
  double hargaLaserMS = 18000;

  // variabel harga jasa laser untuk materi AL
  double hargaLaserAL = 25000;

  // variabel untuk menampung hasil perhitungan hpp
  double hpp = 0;

  // variabel untuk menampung hasil perhitungan nilai kerumitan
  double nilaiKerumitan = 0;

  // variabel untuk menampung hasil perhitungan finishing
  double hargaFinishing = 0;

  // variabel untuk menampung hasil perhitungan harga packaging
  double hargaPackaging = 0;

  if (panjang <= 1000) hargaPackaging = 11000;
  if (panjang > 1000) hargaPackaging = 11000 * (panjang.toDouble() / 1000);

  if (material == 'MS') hargaMaterialPerKg = hargaMS;
  if (material == 'SUS') hargaMaterialPerKg = hargaSUS;
  if (material == 'AL') hargaMaterialPerKg = hargaAL;
  if (material == 'none') hargaMaterialPerKg = 0;

  if (kerumitan == 'low') nilaiKerumitan = 1.3;
  if (kerumitan == 'medium') nilaiKerumitan = 1.6;
  if (kerumitan == 'high') nilaiKerumitan = 1.9;

  if (finishing == 'cat') hargaFinishing = hargaCat;
  if (finishing == 'cat 2 warna') hargaFinishing = hargaCat2Warna;
  if (finishing == 'polish') hargaFinishing = hargaPolish;
  if (finishing == 'none') hargaFinishing = 0;

  // variabel untuk menampung hasil perhitungan berat
  double berat = 0;

  // variabel berat jenis material MS
  double beratJenisMS = 7.85;

  // variabel berat jenis material AL
  double beratJenisAL = 2.7;

  if (material == 'MS' || material == 'SUS') {
    berat = (tebal * lebar.toDouble() * panjang.toDouble() * beratJenisMS) /
        1000000;
  } else {
    berat = (tebal * lebar.toDouble() * panjang.toDouble() * beratJenisAL) /
        1000000;
  }

  if (material == "MS" || material == "SUS") {
    hpp = berat *
        nilaiKerumitan *
        (hargaMaterialPerKg +
            hargaLaserMS +
            hargaFinishing +
            hargaPackaging +
            hargaLabeling);
  } else {
    hpp = berat *
        nilaiKerumitan *
        (hargaMaterialPerKg +
            hargaLaserAL +
            hargaFinishing +
            hargaPackaging +
            hargaLabeling);
  }

  return hpp;
}
