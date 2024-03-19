-- Init
CREATE database bankingsystem;

-- Create
-- buat table nasabah
CREATE table nasabah (
    id_nasabah bigserial primary key,
    nik int not null,
    nama varchar(255) not null,
    alamat text not null
);
-- buat table akun
CREATE table akun (
    id_akun bigserial primary key,
    id_nasabah int not null,
    saldo int not null default 0,
    exp varchar(5) not null,
    cvv int not null
);
-- buat table transaksi
CREATE table transaksi (
    id_transaksi bigserial primary key,
    id_akun int not null,
    jumlah_transfer int not null,
    penerima_akun varchar(255)
);

-- masukan data nasabah
INSERT INTO nasabah (nik, nama, alamat) 
VALUES
    (001234, 'budi', 'jakarta'),
    (002680, 'tono', 'bandung'),
    (004468, 'riski', 'jogja');
-- masukan data akun
INSERT INTO akun (id_nasabah, exp, cvv) 
VALUES
    (1, '02/22', 337),
    (2, '12/25', 232),
    (3, '08/23', 578);
-- masukan data akun
INSERT INTO transaksi (id_akun, jumlah_transfer, penerima_akun) 
VALUES
    (1, 10000, 'reza'),
    (1, 50000, 'yanto'),
    (1, 15000, 'farhan'),
    (2, 20000, 'adit'),
    (3, 30000, 'hani'),
    (1, 40000, 'yanto'),
    (2, 12000, 'ida'),
    (3, 35000, 'rama'),
    (1, 60000, 'nina'),
    (2, 45000, 'joko'),
    (3, 55000, 'siti'),
    (1, 80000, 'rudi'),
    (2, 70000, 'lina'),
    (3, 25000, 'nana'),
    (2, 25000, 'naila'),
    (1, 30000, 'adi'),
    (2, 40000, 'yuli'),
    (3, 90000, 'anto'),
    (1, 12000, 'nisa'),
    (2, 35000, 'wulan');

-- Read
-- membaca isi table transaksi
SELECT * FROM transaksi;
-- menghitung jumlah data transaksi dalam table transaksi
SELECT count(*) AS jumlah_transaksi FROM transaksi;
-- menghitung total transfer dalam table transaksi
SELECT sum(jumlah_transfer) AS total_jumlah_transaksi FROM transaksi;
-- menghitung rata rata transaksi
SELECT avg(jumlah_transfer) AS rata_rata_transfer FROM transaksi;

-- Update
-- memperbarui masa kadaluwarsa kartu pada table akun
UPDATE akun SET exp='02/27' WHERE id_nasabah=1;
-- memperbaiki nama dan memperbarui alamat nasabah
UPDATE nasabah SET nama='budianto', alamat='surabaya' WHERE id_nasabah=1;

-- Delete
-- menghapus data transaksi
DELETE FROM transaksi WHERE id_transaksi=1;

-- Common Table Expression
-- menghitung jumlah transaksi dan pengeluaran akun
WITH jumlah_transaksi_akun AS (
    SELECT id_akun, count(id_transaksi) FROM transaksi GROUP BY id_akun
), jumlah_pengeluaran_akun AS (
    SELECT id_akun, sum(jumlah_transfer) FROM transaksi GROUP BY id_akun
)
SELECT nasabah.id_nasabah,
    nasabah.nama,
    jumlah_transaksi_akun.count AS jumlah_transaksi,
    jumlah_pengeluaran_akun.sum AS jumlah_pengeluaran
FROM nasabah
LEFT JOIN jumlah_transaksi_akun ON jumlah_transaksi_akun.id_akun = nasabah.id_nasabah
LEFT JOIN jumlah_pengeluaran_akun ON jumlah_pengeluaran_akun.id_akun = nasabah.id_nasabah
ORDER BY nasabah.id_nasabah;
