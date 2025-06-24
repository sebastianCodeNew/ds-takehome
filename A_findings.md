## 🔎 Rangkuman Temuan Anomali & Segmen Pelanggan (Bagian A)

### 1. Deteksi Anomali (Kolom Decoy)

Berdasarkan eksplorasi kolom `decoy_flag` dan `decoy_noise`, ditemukan dua pola anomali utama:

- **decoy_flag** mengandung kategori seperti A, B, dan C. Pada kategori B dan C, ditemukan pola transaksi dengan nilai `payment_value` yang sangat tinggi atau sangat rendah (bahkan mendekati nol). Ini menunjukkan kemungkinan adanya noise atau injeksi data uji dalam dataset.
- **decoy_noise** berisi nilai numerik acak yang tidak memiliki hubungan dengan perilaku transaksi pelanggan (tidak berkorelasi dengan recency, frequency, atau monetary). Nilai-nilainya tampak tidak alami dan muncul berulang dalam beberapa ID pelanggan yang berbeda.

👉 **Kesimpulan**: Kedua kolom tersebut dipastikan sebagai noise dan akan diabaikan dalam proses pemodelan karena bisa merusak akurasi prediksi.

---

### 2. Segmentasi Pelanggan

Pelanggan telah dibagi ke dalam **6 kategori RFM**:

| Segment         | Jumlah Pelanggan |
| --------------- | ---------------- |
| Lost            | 868              |
| Big Spender     | 117              |
| Needs Attention | 12               |
| Potential       | 2                |
| Loyal           | 1                |
| Champion        | 0                |

Mayoritas pelanggan berada pada kategori **Lost** dan **Big Spender**, sedangkan hanya sedikit pelanggan yang memenuhi syarat sebagai Loyal atau Potential. Tidak ditemukan pelanggan dengan karakteristik Champion pada periode ini.

---

### 3. Repeat Purchase Bulanan

Jumlah pelanggan yang melakukan pembelian lebih dari sekali dalam sebulan terus menurun dari Januari ke Oktober 2024:

- Januari: 921 pelanggan
- Februari: 670
- Maret: 440
- April: 201
- Mei: 92
- Juni: 48
- Juli: 19
- Agustus: 6
- September: 3
- Oktober: hanya 1 pelanggan

Penurunan ini mengindikasikan penurunan loyalitas atau retensi bulanan yang signifikan dan perlu ditindaklanjuti oleh tim bisnis.
