-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Okt 2025 pada 20.19
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `raport`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `nomor_hp` varchar(13) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`id`, `user_id`, `nama_lengkap`, `jenis_kelamin`, `tanggal_lahir`, `email`, `nomor_hp`, `avatar`, `created_at`, `updated_at`) VALUES
(1, 1, 'Admin', 'L', '1998-05-30', 'admin@mail.com', '085232077932', 'default.png', '2025-10-23 05:55:35', '2025-10-23 05:55:35');

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota_ekskul`
--

CREATE TABLE `anggota_ekskul` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `anggota_kelas_id` bigint(20) UNSIGNED NOT NULL,
  `ekskul_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota_kelas`
--

CREATE TABLE `anggota_kelas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `siswa_id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `pendaftaran` enum('1','2','3','4','5') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `catatan_wali_kelas`
--

CREATE TABLE `catatan_wali_kelas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `anggota_kelas_id` bigint(20) UNSIGNED NOT NULL,
  `catatan` varchar(200) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `deskripsi_nilai_siswa`
--

CREATE TABLE `deskripsi_nilai_siswa` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pembelajaran_id` bigint(20) UNSIGNED NOT NULL,
  `nilai_akhir_raport_id` bigint(20) UNSIGNED NOT NULL,
  `deskripsi_pengetahuan` varchar(200) NOT NULL,
  `deskripsi_keterampilan` varchar(200) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `ekskul`
--

CREATE TABLE `ekskul` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tapel_id` bigint(20) UNSIGNED NOT NULL,
  `pembina_id` bigint(20) UNSIGNED NOT NULL,
  `nama_ekskul` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `guru`
--

CREATE TABLE `guru` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `gelar` varchar(10) NOT NULL,
  `nip` varchar(18) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `tempat_lahir` varchar(30) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `nuptk` varchar(16) DEFAULT NULL,
  `alamat` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kd_mapel`
--

CREATE TABLE `kd_mapel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mapel_id` bigint(20) UNSIGNED NOT NULL,
  `tingkatan_kelas` varchar(2) NOT NULL,
  `jenis_kompetensi` enum('1','2') NOT NULL,
  `semester` enum('1','2') NOT NULL,
  `kode_kd` varchar(10) NOT NULL,
  `kompetensi_dasar` varchar(255) NOT NULL,
  `ringkasan_kompetensi` varchar(150) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kehadiran_siswa`
--

CREATE TABLE `kehadiran_siswa` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `anggota_kelas_id` bigint(20) UNSIGNED NOT NULL,
  `sakit` int(11) NOT NULL,
  `izin` int(11) NOT NULL,
  `tanpa_keterangan` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas`
--

CREATE TABLE `kelas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tapel_id` bigint(20) UNSIGNED NOT NULL,
  `guru_id` bigint(20) UNSIGNED NOT NULL,
  `tingkatan_kelas` varchar(2) NOT NULL,
  `nama_kelas` varchar(30) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kenaikan_kelas`
--

CREATE TABLE `kenaikan_kelas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `anggota_kelas_id` bigint(20) UNSIGNED NOT NULL,
  `keputusan` enum('1','2','3','4') NOT NULL,
  `kelas_tujuan` varchar(25) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kkm_mapel`
--

CREATE TABLE `kkm_mapel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mapel_id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `kkm` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `mapel`
--

CREATE TABLE `mapel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tapel_id` bigint(20) UNSIGNED NOT NULL,
  `nama_mapel` varchar(255) NOT NULL,
  `ringkasan_mapel` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `mapping_mapel`
--

CREATE TABLE `mapping_mapel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mapel_id` bigint(20) UNSIGNED NOT NULL,
  `kelompok` enum('A','B') NOT NULL,
  `nomor_urut` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(3, '2025_10_17_144054_admins', 1),
(4, '2025_10_17_153601_riwayat_login', 1),
(5, '2025_10_17_153640_sekolah', 1),
(6, '2025_10_17_153702_guru', 1),
(7, '2025_10_17_153714_tapel', 1),
(8, '2025_10_17_153727_kelas', 1),
(9, '2025_10_17_153744_siswa', 1),
(10, '2025_10_17_153759_anggota_kelas', 1),
(11, '2025_10_17_153814_siswa_keluar', 1),
(12, '2025_10_17_153834_mapel', 1),
(13, '2025_10_17_153858_pembelajaran', 1),
(14, '2025_10_17_153913_ekskul', 1),
(15, '2025_10_17_153928_anggota_ekskul', 1),
(16, '2025_10_17_154045_nilai_ekskul', 1),
(17, '2025_10_17_154104_kehadiran_siswa', 1),
(18, '2025_10_17_154125_prestasi_siswa', 1),
(19, '2025_10_17_154141_catatan_walikelas', 1),
(20, '2025_10_17_154157_pengumuman', 1),
(21, '2025_10_17_154211_kenaikan_kelas', 1),
(22, '2025_10_17_154243_mapping_mapel', 1),
(23, '2025_10_17_154334_kkm_mapel', 1),
(24, '2025_10_17_154351_kd_mapel', 1),
(25, '2025_10_17_154412_tgl_raport', 1),
(26, '2025_10_17_154447_rencana_nilai_pengetahuan', 1),
(27, '2025_10_17_154503_rencana_nilai_keterampilan', 1),
(28, '2025_10_17_154519_rencana_bobot_penilaian', 1),
(29, '2025_10_17_154539_nilai_pengetahuan', 1),
(30, '2025_10_17_154555_nilai_keterampilan', 1),
(31, '2025_10_17_154622_nilai_pts_pas', 1),
(32, '2025_10_17_154653_nilai_akhir_raport', 1),
(33, '2025_10_17_154712_deskripsi_nilai_siswa', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilai_akhir_raport`
--

CREATE TABLE `nilai_akhir_raport` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pembelajaran_id` bigint(20) UNSIGNED NOT NULL,
  `anggota_kelas_id` bigint(20) UNSIGNED NOT NULL,
  `kkm` int(11) NOT NULL,
  `nilai_pengetahuan` int(11) NOT NULL,
  `predikat_pengetahuan` enum('A','B','C','D') NOT NULL,
  `nilai_keterampilan` int(11) NOT NULL,
  `predikat_keterampilan` enum('A','B','C','D') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilai_ekskul`
--

CREATE TABLE `nilai_ekskul` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ekskul_id` bigint(20) UNSIGNED NOT NULL,
  `anggota_ekskul_id` bigint(20) UNSIGNED NOT NULL,
  `nilai` enum('4','3','2','1') NOT NULL,
  `deskripsi` varchar(200) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilai_keterampilan`
--

CREATE TABLE `nilai_keterampilan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rencana_nilai_keterampilan_id` bigint(20) UNSIGNED NOT NULL,
  `anggota_kelas_id` bigint(20) UNSIGNED NOT NULL,
  `nilai` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilai_pengetahuan`
--

CREATE TABLE `nilai_pengetahuan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nilai_pengetahuan_id` bigint(20) UNSIGNED NOT NULL,
  `anggota_kelas_id` bigint(20) UNSIGNED NOT NULL,
  `nilai` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilai_pts_pas`
--

CREATE TABLE `nilai_pts_pas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pembelajaran_id` bigint(20) UNSIGNED NOT NULL,
  `anggota_kelas_id` bigint(20) UNSIGNED NOT NULL,
  `nilai_pts` int(11) NOT NULL,
  `nilai_pas` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembelajaran`
--

CREATE TABLE `pembelajaran` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `mapel_id` bigint(20) UNSIGNED NOT NULL,
  `guru_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengumuman`
--

CREATE TABLE `pengumuman` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(255) NOT NULL,
  `isi` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `prestasi_siswa`
--

CREATE TABLE `prestasi_siswa` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `anggota_kelas_id` bigint(20) UNSIGNED NOT NULL,
  `jenis_prestasi` enum('1','2') NOT NULL,
  `deskripsi` varchar(200) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rencana_bobot_penilaian`
--

CREATE TABLE `rencana_bobot_penilaian` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pembelajaran_id` bigint(20) UNSIGNED NOT NULL,
  `bobot_ph` int(11) NOT NULL,
  `bobot_pts` int(11) NOT NULL,
  `bobot_pas` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rencana_nilai_keterampilan`
--

CREATE TABLE `rencana_nilai_keterampilan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pembelajaran_id` bigint(20) UNSIGNED NOT NULL,
  `kd_mapel_id` bigint(20) UNSIGNED NOT NULL,
  `kode_penilaian` varchar(4) NOT NULL,
  `teknik_penilaian` enum('1','2','3') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rencana_nilai_pengetahuan`
--

CREATE TABLE `rencana_nilai_pengetahuan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pembelajaran_id` bigint(20) UNSIGNED NOT NULL,
  `kd_mapel_id` bigint(20) UNSIGNED NOT NULL,
  `kode_penilaian` varchar(4) NOT NULL,
  `teknik_penilaian` enum('1','2','3') NOT NULL,
  `bobot_teknik_penilaian` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `riwayat_login`
--

CREATE TABLE `riwayat_login` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status_login` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `riwayat_login`
--

INSERT INTO `riwayat_login` (`id`, `user_id`, `status_login`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-10-23 07:12:23', '2025-10-23 07:12:23');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sekolah`
--

CREATE TABLE `sekolah` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_sekolah` varchar(100) NOT NULL,
  `npsn` varchar(10) NOT NULL,
  `kode_pos` varchar(5) NOT NULL,
  `nomor_telpon` varchar(13) DEFAULT NULL,
  `alamat` varchar(255) NOT NULL,
  `website` varchar(100) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL,
  `logo` varchar(255) NOT NULL,
  `kepala_sekolah` varchar(100) NOT NULL,
  `nip_kepala_sekolah` varchar(18) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED DEFAULT NULL,
  `jenis_pendaftaran` enum('1','2') NOT NULL,
  `nis` varchar(10) NOT NULL,
  `nisn` varchar(10) DEFAULT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `tempat_lahir` varchar(50) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `agama` enum('1','2','3','4','5','6','7') NOT NULL,
  `status_dalam_keluarga` enum('1','2','3') NOT NULL,
  `anak_ke` varchar(2) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `nomor_hp` varchar(13) DEFAULT NULL,
  `nama_ayah` varchar(100) NOT NULL,
  `nama_ibu` varchar(100) NOT NULL,
  `pekerjaan_ayah` varchar(100) NOT NULL,
  `pekerjaan_ibu` varchar(100) NOT NULL,
  `nama_wali` varchar(100) DEFAULT NULL,
  `pekerjaan_wali` varchar(100) DEFAULT NULL,
  `avatar` varchar(255) NOT NULL,
  `status` enum('1','2','3') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa_keluar`
--

CREATE TABLE `siswa_keluar` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `siswa_id` bigint(20) UNSIGNED NOT NULL,
  `keluar_karena` varchar(30) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `alasan_keluar` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tapel`
--

CREATE TABLE `tapel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tahun_pelajaran` varchar(9) NOT NULL,
  `semester` enum('1','2') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tapel`
--

INSERT INTO `tapel` (`id`, `tahun_pelajaran`, `semester`, `created_at`, `updated_at`) VALUES
(1, '2025/2026', '1', '2025-10-23 06:08:45', '2025-10-23 06:08:45');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tgl_raport`
--

CREATE TABLE `tgl_raport` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tapel_id` bigint(20) UNSIGNED NOT NULL,
  `tempat_penerbitan` varchar(50) NOT NULL,
  `tanggal_pembagian` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('1','2','3') NOT NULL,
  `status` tinyint(1) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `role`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$10$xarhfx3TiSVHio7D1L6M3OuHOdYAdFnbpzsgtyZq3eTRwpaw848i.', '1', 1, NULL, '2025-10-23 05:55:35', '2025-10-23 05:55:35');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_user_id_unique` (`user_id`),
  ADD UNIQUE KEY `admin_email_unique` (`email`),
  ADD UNIQUE KEY `admin_nomor_hp_unique` (`nomor_hp`);

--
-- Indeks untuk tabel `anggota_ekskul`
--
ALTER TABLE `anggota_ekskul`
  ADD PRIMARY KEY (`id`),
  ADD KEY `anggota_ekskul_anggota_kelas_id_foreign` (`anggota_kelas_id`),
  ADD KEY `anggota_ekskul_ekskul_id_foreign` (`ekskul_id`);

--
-- Indeks untuk tabel `anggota_kelas`
--
ALTER TABLE `anggota_kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `anggota_kelas_siswa_id_foreign` (`siswa_id`),
  ADD KEY `anggota_kelas_kelas_id_foreign` (`kelas_id`);

--
-- Indeks untuk tabel `catatan_wali_kelas`
--
ALTER TABLE `catatan_wali_kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `catatan_wali_kelas_anggota_kelas_id_foreign` (`anggota_kelas_id`);

--
-- Indeks untuk tabel `deskripsi_nilai_siswa`
--
ALTER TABLE `deskripsi_nilai_siswa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deskripsi_nilai_siswa_pembelajaran_id_foreign` (`pembelajaran_id`),
  ADD KEY `deskripsi_nilai_siswa_nilai_akhir_raport_id_foreign` (`nilai_akhir_raport_id`);

--
-- Indeks untuk tabel `ekskul`
--
ALTER TABLE `ekskul`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ekskul_tapel_id_foreign` (`tapel_id`),
  ADD KEY `ekskul_pembina_id_foreign` (`pembina_id`);

--
-- Indeks untuk tabel `guru`
--
ALTER TABLE `guru`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `guru_user_id_unique` (`user_id`),
  ADD UNIQUE KEY `guru_nip_unique` (`nip`),
  ADD UNIQUE KEY `guru_nuptk_unique` (`nuptk`);

--
-- Indeks untuk tabel `kd_mapel`
--
ALTER TABLE `kd_mapel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kd_mapel_mapel_id_foreign` (`mapel_id`);

--
-- Indeks untuk tabel `kehadiran_siswa`
--
ALTER TABLE `kehadiran_siswa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kehadiran_siswa_anggota_kelas_id_foreign` (`anggota_kelas_id`);

--
-- Indeks untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kelas_tapel_id_foreign` (`tapel_id`),
  ADD KEY `kelas_guru_id_foreign` (`guru_id`);

--
-- Indeks untuk tabel `kenaikan_kelas`
--
ALTER TABLE `kenaikan_kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kenaikan_kelas_anggota_kelas_id_foreign` (`anggota_kelas_id`);

--
-- Indeks untuk tabel `kkm_mapel`
--
ALTER TABLE `kkm_mapel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kkm_mapel_mapel_id_foreign` (`mapel_id`),
  ADD KEY `kkm_mapel_kelas_id_foreign` (`kelas_id`);

--
-- Indeks untuk tabel `mapel`
--
ALTER TABLE `mapel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mapel_tapel_id_foreign` (`tapel_id`);

--
-- Indeks untuk tabel `mapping_mapel`
--
ALTER TABLE `mapping_mapel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mapping_mapel_mapel_id_foreign` (`mapel_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `nilai_akhir_raport`
--
ALTER TABLE `nilai_akhir_raport`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nilai_akhir_raport_pembelajaran_id_foreign` (`pembelajaran_id`),
  ADD KEY `nilai_akhir_raport_anggota_kelas_id_foreign` (`anggota_kelas_id`);

--
-- Indeks untuk tabel `nilai_ekskul`
--
ALTER TABLE `nilai_ekskul`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nilai_ekskul_ekskul_id_foreign` (`ekskul_id`),
  ADD KEY `nilai_ekskul_anggota_ekskul_id_foreign` (`anggota_ekskul_id`);

--
-- Indeks untuk tabel `nilai_keterampilan`
--
ALTER TABLE `nilai_keterampilan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nilai_keterampilan_rencana_nilai_keterampilan_id_foreign` (`rencana_nilai_keterampilan_id`),
  ADD KEY `nilai_keterampilan_anggota_kelas_id_foreign` (`anggota_kelas_id`);

--
-- Indeks untuk tabel `nilai_pengetahuan`
--
ALTER TABLE `nilai_pengetahuan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nilai_pengetahuan_nilai_pengetahuan_id_foreign` (`nilai_pengetahuan_id`),
  ADD KEY `nilai_pengetahuan_anggota_kelas_id_foreign` (`anggota_kelas_id`);

--
-- Indeks untuk tabel `nilai_pts_pas`
--
ALTER TABLE `nilai_pts_pas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nilai_pts_pas_pembelajaran_id_foreign` (`pembelajaran_id`),
  ADD KEY `nilai_pts_pas_anggota_kelas_id_foreign` (`anggota_kelas_id`);

--
-- Indeks untuk tabel `pembelajaran`
--
ALTER TABLE `pembelajaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pembelajaran_kelas_id_foreign` (`kelas_id`),
  ADD KEY `pembelajaran_mapel_id_foreign` (`mapel_id`),
  ADD KEY `pembelajaran_guru_id_foreign` (`guru_id`);

--
-- Indeks untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pengumuman_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `prestasi_siswa`
--
ALTER TABLE `prestasi_siswa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prestasi_siswa_anggota_kelas_id_foreign` (`anggota_kelas_id`);

--
-- Indeks untuk tabel `rencana_bobot_penilaian`
--
ALTER TABLE `rencana_bobot_penilaian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rencana_bobot_penilaian_pembelajaran_id_foreign` (`pembelajaran_id`);

--
-- Indeks untuk tabel `rencana_nilai_keterampilan`
--
ALTER TABLE `rencana_nilai_keterampilan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rencana_nilai_keterampilan_pembelajaran_id_foreign` (`pembelajaran_id`),
  ADD KEY `rencana_nilai_keterampilan_kd_mapel_id_foreign` (`kd_mapel_id`);

--
-- Indeks untuk tabel `rencana_nilai_pengetahuan`
--
ALTER TABLE `rencana_nilai_pengetahuan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rencana_nilai_pengetahuan_pembelajaran_id_foreign` (`pembelajaran_id`),
  ADD KEY `rencana_nilai_pengetahuan_kd_mapel_id_foreign` (`kd_mapel_id`);

--
-- Indeks untuk tabel `riwayat_login`
--
ALTER TABLE `riwayat_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `riwayat_login_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `sekolah`
--
ALTER TABLE `sekolah`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `siswa_user_id_unique` (`user_id`),
  ADD UNIQUE KEY `siswa_nis_unique` (`nis`),
  ADD UNIQUE KEY `siswa_nisn_unique` (`nisn`),
  ADD UNIQUE KEY `siswa_nomor_hp_unique` (`nomor_hp`),
  ADD KEY `siswa_kelas_id_foreign` (`kelas_id`);

--
-- Indeks untuk tabel `siswa_keluar`
--
ALTER TABLE `siswa_keluar`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `siswa_keluar_siswa_id_unique` (`siswa_id`);

--
-- Indeks untuk tabel `tapel`
--
ALTER TABLE `tapel`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tgl_raport`
--
ALTER TABLE `tgl_raport`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tgl_raport_tapel_id_unique` (`tapel_id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_username_unique` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `anggota_ekskul`
--
ALTER TABLE `anggota_ekskul`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `anggota_kelas`
--
ALTER TABLE `anggota_kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `catatan_wali_kelas`
--
ALTER TABLE `catatan_wali_kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `deskripsi_nilai_siswa`
--
ALTER TABLE `deskripsi_nilai_siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `ekskul`
--
ALTER TABLE `ekskul`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `guru`
--
ALTER TABLE `guru`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kd_mapel`
--
ALTER TABLE `kd_mapel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kehadiran_siswa`
--
ALTER TABLE `kehadiran_siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kenaikan_kelas`
--
ALTER TABLE `kenaikan_kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kkm_mapel`
--
ALTER TABLE `kkm_mapel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `mapel`
--
ALTER TABLE `mapel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `mapping_mapel`
--
ALTER TABLE `mapping_mapel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT untuk tabel `nilai_akhir_raport`
--
ALTER TABLE `nilai_akhir_raport`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `nilai_ekskul`
--
ALTER TABLE `nilai_ekskul`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `nilai_keterampilan`
--
ALTER TABLE `nilai_keterampilan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `nilai_pengetahuan`
--
ALTER TABLE `nilai_pengetahuan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `nilai_pts_pas`
--
ALTER TABLE `nilai_pts_pas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pembelajaran`
--
ALTER TABLE `pembelajaran`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `prestasi_siswa`
--
ALTER TABLE `prestasi_siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `rencana_bobot_penilaian`
--
ALTER TABLE `rencana_bobot_penilaian`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `rencana_nilai_keterampilan`
--
ALTER TABLE `rencana_nilai_keterampilan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `rencana_nilai_pengetahuan`
--
ALTER TABLE `rencana_nilai_pengetahuan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `riwayat_login`
--
ALTER TABLE `riwayat_login`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `sekolah`
--
ALTER TABLE `sekolah`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `siswa_keluar`
--
ALTER TABLE `siswa_keluar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tapel`
--
ALTER TABLE `tapel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tgl_raport`
--
ALTER TABLE `tgl_raport`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ketidakleluasaan untuk tabel `anggota_ekskul`
--
ALTER TABLE `anggota_ekskul`
  ADD CONSTRAINT `anggota_ekskul_anggota_kelas_id_foreign` FOREIGN KEY (`anggota_kelas_id`) REFERENCES `anggota_kelas` (`id`),
  ADD CONSTRAINT `anggota_ekskul_ekskul_id_foreign` FOREIGN KEY (`ekskul_id`) REFERENCES `ekskul` (`id`);

--
-- Ketidakleluasaan untuk tabel `anggota_kelas`
--
ALTER TABLE `anggota_kelas`
  ADD CONSTRAINT `anggota_kelas_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`),
  ADD CONSTRAINT `anggota_kelas_siswa_id_foreign` FOREIGN KEY (`siswa_id`) REFERENCES `siswa` (`id`);

--
-- Ketidakleluasaan untuk tabel `catatan_wali_kelas`
--
ALTER TABLE `catatan_wali_kelas`
  ADD CONSTRAINT `catatan_wali_kelas_anggota_kelas_id_foreign` FOREIGN KEY (`anggota_kelas_id`) REFERENCES `anggota_kelas` (`id`);

--
-- Ketidakleluasaan untuk tabel `deskripsi_nilai_siswa`
--
ALTER TABLE `deskripsi_nilai_siswa`
  ADD CONSTRAINT `deskripsi_nilai_siswa_nilai_akhir_raport_id_foreign` FOREIGN KEY (`nilai_akhir_raport_id`) REFERENCES `nilai_akhir_raport` (`id`),
  ADD CONSTRAINT `deskripsi_nilai_siswa_pembelajaran_id_foreign` FOREIGN KEY (`pembelajaran_id`) REFERENCES `pembelajaran` (`id`);

--
-- Ketidakleluasaan untuk tabel `ekskul`
--
ALTER TABLE `ekskul`
  ADD CONSTRAINT `ekskul_pembina_id_foreign` FOREIGN KEY (`pembina_id`) REFERENCES `guru` (`id`),
  ADD CONSTRAINT `ekskul_tapel_id_foreign` FOREIGN KEY (`tapel_id`) REFERENCES `tapel` (`id`);

--
-- Ketidakleluasaan untuk tabel `guru`
--
ALTER TABLE `guru`
  ADD CONSTRAINT `guru_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ketidakleluasaan untuk tabel `kd_mapel`
--
ALTER TABLE `kd_mapel`
  ADD CONSTRAINT `kd_mapel_mapel_id_foreign` FOREIGN KEY (`mapel_id`) REFERENCES `mapel` (`id`);

--
-- Ketidakleluasaan untuk tabel `kehadiran_siswa`
--
ALTER TABLE `kehadiran_siswa`
  ADD CONSTRAINT `kehadiran_siswa_anggota_kelas_id_foreign` FOREIGN KEY (`anggota_kelas_id`) REFERENCES `anggota_kelas` (`id`);

--
-- Ketidakleluasaan untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `kelas_guru_id_foreign` FOREIGN KEY (`guru_id`) REFERENCES `guru` (`id`),
  ADD CONSTRAINT `kelas_tapel_id_foreign` FOREIGN KEY (`tapel_id`) REFERENCES `tapel` (`id`);

--
-- Ketidakleluasaan untuk tabel `kenaikan_kelas`
--
ALTER TABLE `kenaikan_kelas`
  ADD CONSTRAINT `kenaikan_kelas_anggota_kelas_id_foreign` FOREIGN KEY (`anggota_kelas_id`) REFERENCES `anggota_kelas` (`id`);

--
-- Ketidakleluasaan untuk tabel `kkm_mapel`
--
ALTER TABLE `kkm_mapel`
  ADD CONSTRAINT `kkm_mapel_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`),
  ADD CONSTRAINT `kkm_mapel_mapel_id_foreign` FOREIGN KEY (`mapel_id`) REFERENCES `mapel` (`id`);

--
-- Ketidakleluasaan untuk tabel `mapel`
--
ALTER TABLE `mapel`
  ADD CONSTRAINT `mapel_tapel_id_foreign` FOREIGN KEY (`tapel_id`) REFERENCES `tapel` (`id`);

--
-- Ketidakleluasaan untuk tabel `mapping_mapel`
--
ALTER TABLE `mapping_mapel`
  ADD CONSTRAINT `mapping_mapel_mapel_id_foreign` FOREIGN KEY (`mapel_id`) REFERENCES `mapel` (`id`);

--
-- Ketidakleluasaan untuk tabel `nilai_akhir_raport`
--
ALTER TABLE `nilai_akhir_raport`
  ADD CONSTRAINT `nilai_akhir_raport_anggota_kelas_id_foreign` FOREIGN KEY (`anggota_kelas_id`) REFERENCES `anggota_kelas` (`id`),
  ADD CONSTRAINT `nilai_akhir_raport_pembelajaran_id_foreign` FOREIGN KEY (`pembelajaran_id`) REFERENCES `pembelajaran` (`id`);

--
-- Ketidakleluasaan untuk tabel `nilai_ekskul`
--
ALTER TABLE `nilai_ekskul`
  ADD CONSTRAINT `nilai_ekskul_anggota_ekskul_id_foreign` FOREIGN KEY (`anggota_ekskul_id`) REFERENCES `anggota_ekskul` (`id`),
  ADD CONSTRAINT `nilai_ekskul_ekskul_id_foreign` FOREIGN KEY (`ekskul_id`) REFERENCES `ekskul` (`id`);

--
-- Ketidakleluasaan untuk tabel `nilai_keterampilan`
--
ALTER TABLE `nilai_keterampilan`
  ADD CONSTRAINT `nilai_keterampilan_anggota_kelas_id_foreign` FOREIGN KEY (`anggota_kelas_id`) REFERENCES `anggota_kelas` (`id`),
  ADD CONSTRAINT `nilai_keterampilan_rencana_nilai_keterampilan_id_foreign` FOREIGN KEY (`rencana_nilai_keterampilan_id`) REFERENCES `rencana_nilai_keterampilan` (`id`);

--
-- Ketidakleluasaan untuk tabel `nilai_pengetahuan`
--
ALTER TABLE `nilai_pengetahuan`
  ADD CONSTRAINT `nilai_pengetahuan_anggota_kelas_id_foreign` FOREIGN KEY (`anggota_kelas_id`) REFERENCES `anggota_kelas` (`id`),
  ADD CONSTRAINT `nilai_pengetahuan_nilai_pengetahuan_id_foreign` FOREIGN KEY (`nilai_pengetahuan_id`) REFERENCES `nilai_pengetahuan` (`id`);

--
-- Ketidakleluasaan untuk tabel `nilai_pts_pas`
--
ALTER TABLE `nilai_pts_pas`
  ADD CONSTRAINT `nilai_pts_pas_anggota_kelas_id_foreign` FOREIGN KEY (`anggota_kelas_id`) REFERENCES `anggota_kelas` (`id`),
  ADD CONSTRAINT `nilai_pts_pas_pembelajaran_id_foreign` FOREIGN KEY (`pembelajaran_id`) REFERENCES `pembelajaran` (`id`);

--
-- Ketidakleluasaan untuk tabel `pembelajaran`
--
ALTER TABLE `pembelajaran`
  ADD CONSTRAINT `pembelajaran_guru_id_foreign` FOREIGN KEY (`guru_id`) REFERENCES `guru` (`id`),
  ADD CONSTRAINT `pembelajaran_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`),
  ADD CONSTRAINT `pembelajaran_mapel_id_foreign` FOREIGN KEY (`mapel_id`) REFERENCES `mapel` (`id`);

--
-- Ketidakleluasaan untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD CONSTRAINT `pengumuman_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ketidakleluasaan untuk tabel `prestasi_siswa`
--
ALTER TABLE `prestasi_siswa`
  ADD CONSTRAINT `prestasi_siswa_anggota_kelas_id_foreign` FOREIGN KEY (`anggota_kelas_id`) REFERENCES `anggota_kelas` (`id`);

--
-- Ketidakleluasaan untuk tabel `rencana_bobot_penilaian`
--
ALTER TABLE `rencana_bobot_penilaian`
  ADD CONSTRAINT `rencana_bobot_penilaian_pembelajaran_id_foreign` FOREIGN KEY (`pembelajaran_id`) REFERENCES `pembelajaran` (`id`);

--
-- Ketidakleluasaan untuk tabel `rencana_nilai_keterampilan`
--
ALTER TABLE `rencana_nilai_keterampilan`
  ADD CONSTRAINT `rencana_nilai_keterampilan_kd_mapel_id_foreign` FOREIGN KEY (`kd_mapel_id`) REFERENCES `kd_mapel` (`id`),
  ADD CONSTRAINT `rencana_nilai_keterampilan_pembelajaran_id_foreign` FOREIGN KEY (`pembelajaran_id`) REFERENCES `pembelajaran` (`id`);

--
-- Ketidakleluasaan untuk tabel `rencana_nilai_pengetahuan`
--
ALTER TABLE `rencana_nilai_pengetahuan`
  ADD CONSTRAINT `rencana_nilai_pengetahuan_kd_mapel_id_foreign` FOREIGN KEY (`kd_mapel_id`) REFERENCES `kd_mapel` (`id`),
  ADD CONSTRAINT `rencana_nilai_pengetahuan_pembelajaran_id_foreign` FOREIGN KEY (`pembelajaran_id`) REFERENCES `pembelajaran` (`id`);

--
-- Ketidakleluasaan untuk tabel `riwayat_login`
--
ALTER TABLE `riwayat_login`
  ADD CONSTRAINT `riwayat_login_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ketidakleluasaan untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD CONSTRAINT `siswa_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`),
  ADD CONSTRAINT `siswa_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ketidakleluasaan untuk tabel `siswa_keluar`
--
ALTER TABLE `siswa_keluar`
  ADD CONSTRAINT `siswa_keluar_siswa_id_foreign` FOREIGN KEY (`siswa_id`) REFERENCES `siswa` (`id`);

--
-- Ketidakleluasaan untuk tabel `tgl_raport`
--
ALTER TABLE `tgl_raport`
  ADD CONSTRAINT `tgl_raport_tapel_id_foreign` FOREIGN KEY (`tapel_id`) REFERENCES `tapel` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
