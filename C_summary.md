## Cut-off Score dan Kalibrasi

Berdasarkan kurva kalibrasi dari model regresi logistik, prediksi probabilitas default cukup selaras dengan realisasi aktual. Untuk menjaga **expected default rate ≤ 5%**, threshold probabilitas **0.05** digunakan sebagai batas keputusan.

Jika dikonversi ke skor dengan skala 300–850, cutoff berada di sekitar **score 705**. Pemohon dengan skor di atas angka ini dianggap layak (tidak default).
