<?php

namespace App\Http\Controllers;

use App\Models\AnggotaKelas;
use App\Models\DeskripsiNilaiSiswa;
use App\Models\Guru;
use App\Models\Pengumuman;
use App\Models\RiwayatLogin;
use App\Models\Sekolah;
use App\Models\Siswa;
use App\Models\Tapel;
use App\Models\Kelas;
use App\Models\Ekskul;
use App\Models\KkmMapel;
use App\Models\NilaiAkhirRaport;
use App\Models\NilaiKeterampilan;
use App\Models\NilaiPengetahuan;
use App\Models\NilaiPtsPas;
use App\Models\Pembelajaran;
use App\Models\RencanaBobotPenilaian;
use App\Models\RencanaNilaiKeterampilan;
use App\Models\RencanaNilaiPengetahuan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function index()
    {
        $title = 'Dashboard';
        $sekolah = Sekolah::first();
        $tapel = Tapel::findorfail(session()->get('tapel_id'));
        $data_pengumuman = Pengumuman::all();
        $data_riwayat_login = RiwayatLogin::where('user_id', '!=', Auth::user()->id)->where('updated_at', '>=', Carbon::today())->orderBy('status_login', 'DESC')->orderBy('updated_at', 'DESC')->get();

        if (Auth::user()->role == 1) {
            $jumlah_guru = Guru::all()->count();
            $jumlah_siswa = Siswa::where('status', 1)->count();
            $jumlah_kelas = Kelas::where('tapel_id', $tapel->id)->count();
            $jumlah_ekskul = Ekskul::where('tapel_id', $tapel->id)->count();

            return view('dashboard.admin', compact(
                'title',
                'data_pengumuman',
                'data_riwayat_login',
                'sekolah',
                'tapel',
                'jumlah_guru',
                'jumlah_siswa',
                'jumlah_kelas',
                'jumlah_ekskul',
            ));
        } elseif (Auth::user()->role == 2) {
            $guru = Guru::where('user_id', Auth::user()->id)->first();

            if (session()->get('akses_sebagai') == 'Guru Mapel') {
                $id_kelas = Kelas::where('tapel_id', $tapel->id)->get('id');

                $jumlah_kelas_diampu = count(Pembelajaran::where('guru_id', $guru->id)->whereIn('kelas_id', $id_kelas)->where('status', 1)->groupBy('kelas_id')->get());
                $jumlah_mapel_diampu = count(Pembelajaran::where('guru_id', $guru->id)->whereIn('kelas_id', $id_kelas)->where('status', 1)->groupBy('mapel_id')->get());

                $id_kelas_diampu = Pembelajaran::where('guru_id', $guru->id)->whereIn('kelas_id', $id_kelas)->where('status', 1)->groupBy('kelas_id')->get();
                $jumlah_siswa_diampu = AnggotaKelas::whereIn('kelas_id', $id_kelas_diampu)->count();

                $jumlah_ekskul_diampu = Ekskul::where('pembina_id', $guru->id)->count();

                $data_capaian_penilaian = Pembelajaran::wher('guru_id', $guru->id)->whereIn('kelas_id', $id_kelas)->where('status', 1)->get();

                if (session()->get('kurikulum') == 'merdeka') {
                    foreach ($data_capaian_penilaian as $penilaian) {
                        $kkm = KkmMapel::where('mapel_id', $penilaian->mapel->id)->where('kelas_id', $penilaian->kelas_id)->first();

                        $rencana_pengetahuan = RencanaNilaiPengetahuan::where('pembelajaran_id', $penilaian->id)->groupBy('kode_penilaian')->get();
                        $penilaian->jumlah_rencana_pengetahuan = count($rencana_pengetahuan);

                        $rencana_keterampilan = RencanaNilaiKeterampilan::where('pembelajaran_id', $penilaian->id)->groupBy('kode_penilaian')->get();
                        $penilaian->jumlah_rencana_keterampilan = count($rencana_keterampilan);

                        $id_rencana_nilai_pengetahuan = RencanaNilaiPengetahuan::where('pembelajaran_id', $penilaian->id)->groupBy('kode_penilaian')->get('id');
                        $pengetahuan_telah_dinilai = NilaiPengetahuan::whereIn('rencana_nilai_pengetahuan_id', $id_rencana_nilai_pengetahuan)->groupBy('rencana_nilai_pengetahuan_id')->get();
                        $penilaian->jumlah_pengetahuan_telah_dinilai = count($pengetahuan_telah_dinilai);

                        $id_rencana_nilai_keterampilan = RencanaNilaiKeterampilan::where('pembelajaran_id', $penilaian->id)->groupBy('kode_penilaian')->get('id');
                        $keterampilan_telah_dinilai = NilaiKeterampilan::whereIn('rencana_nilai_keterampilan_id', $id_rencana_nilai_keterampilan)->groupBy('rencana_nilai_keterampilan_id')->get();
                        $penilaian->jumlah_keterampilan_telah_dinilai = count($keterampilan_telah_dinilai);


                        $nilai_pts_pas = NilaiPtsPas::where('pembelajaran_id', $penilaian->id)->get();
                        $penilaian->nilai_pts_pas = count($nilai_pts_pas);

                        $nilai_akhir_raport = NilaiAkhirRaport::where('pembelajaran_id', $penilaian->id)->get();
                        $penilaian->kirim_nilai_raport = count($nilai_akhir_raport);

                        $deskripsi_nilai_akhir = DeskripsiNilaiSiswa::where('pembelajaran_id', $penilaian->id)->get();
                        $penilaian->proses_deskripsi = count($deskripsi_nilai_akhir);

                        $bobot = RencanaBobotPenilaian::where('pembelajaran_id', $penilaian->id)->first();
                        if (is_null($bobot)) {
                            $penilaian->bobot_ph = null;
                            $penilaian->bobot_pts = null;
                            $penilaian->bobot_pas = null;
                        } else {
                            $penilaian->bobot_ph = $bobot->bobot_ph;
                            $penilaian->bobot_pts = $bobot->bobot_pts;
                            $penilaian->bobot_pas = $bobot->bobot_pas;
                        }

                        if (is_null($kkm)) {
                            $penilaian->kkm = null;
                        } else {
                            $penilaian->kkm = $kkm->kkm;
                        }
                    }
                }

                return view('dashboard.guru', compact(
                    'title',
                    'data_pengumuman',
                    'data_riwayat_login',
                    'sekolah',
                    'tapel',
                    'jumlah_kelas_diampu',
                    'jumlah_mapel_diampu',
                    'jumlah_siswa_diampu',
                    'jumlah_ekskul_diampu',
                    'data_capaian_penilaian',
                ));
            } elseif (session()->get('akses_sebagai') == 'Wali Kelas') {
                $id_kelas_diampu = Kelas::where('tapel_id', $tapel->id)->where('guru_id', $guru->id)->get('id');
                $jumlah_anggota_kelas = count(AnggotaKelas::whereIn('kelas_id', $id_kelas_diampu)->get());

                $id_pembelajaran_kelas = Pembelajaran::whereIn('kelas_id', $id_kelas_diampu)->where('status', 1)->get('id');
                if (session()->get('kurikulum') == 'Merdeka') {
                    $jumlah_kirim_nilai = count(NilaiAkhirRaport::whereIn('pembelajaran_id', $id_pembelajaran_kelas)->groupBy('pembelajaran_id')->get());
                    $jumlah_proses_deskripsi = count(DeskripsiNilaiSiswa::whereIn('pembelajaran_id', $id_pembelajaran_kelas)->groupBy('pembelajaran_id')->get());
                }

                return view('dashboard.walikelas', compact(
                    'title',
                    'data_pengumuman',
                    'data_riwayat_login',
                    'sekolah',
                    'tapel',
                    'jumlah_anggota_kelas',
                    'jumlah_kirim_nilai',
                    'jumlah_proses_deskripsi',
                ));
            }
        }
    }
}
