<?php

namespace App\Http\Controllers\Admin;

use App\Models\AnggotaEkskul;
use App\Models\AnggotaKelas;
use App\Models\CatatanWaliKelas;
use App\Models\Ekskul;
use App\Http\Controllers\Controller;
use App\Models\DeskripsiSikapSiswa;
use App\Models\MappingMapel;
use App\Models\NilaiAkhirRaport;
use App\Models\TglRaport;
use App\Models\KehadiranSiswa;
use App\Models\Kelas;
use App\Models\Mapel;
use App\Models\NilaiEkskul;
use App\Models\Pembelajaran;
use App\Models\PrestasiSiswa;
use App\Models\Sekolah;
use Illuminate\Http\Request;
use PDF;

class CetakRaportSemesterController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $title = 'Cetak Raport Semester';
        $data_kelas = Kelas::where('tapel_id', session()->get('tapel_id'))->get();
        return view('admin.raportsemester.setpaper', compact('title', 'data_kelas'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $title = 'Cetak Raport Semester';
        $kelas = Kelas::findorfail($request->kelas_id);
        $data_kelas = Kelas::where('tapel_id', session()->get('tapel_id'))->get();
        $data_anggota_kelas = AnggotaKelas::where('kelas_id', $kelas->id)->get();

        $paper_size = $request->paper_size;
        $orientation = $request->orientation;

        return view('admin.raportsemester.index', compact('title', 'kelas', 'data_kelas', 'data_anggota_kelas', 'paper_size', 'orientation'));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request, $id)
    {
        $sekolah = Sekolah::first();
        $anggota_kelas = AnggotaKelas::findorfail($id);

        if ($request->data_type == 1) {
            $title = 'Kelengkapan Raport';
            // $kelengkapan_raport = PDF::loadview('walikelas.raportsemester.kelengkapanraport', compact('title', 'sekolah', 'anggota_kelas'))->setPaper($request->paper_size, $request->orientation);
            // return $kelengkapan_raport->stream('KELENGKAPAN RAPORT ' . $anggota_kelas->siswa->nama_lengkap . ' (' . $anggota_kelas->kelas->nama_kelas . ').pdf');
        } elseif ($request->data_type == 2) {
            $title = 'Cetak Raport';
            // $deskripsi_sikap = DeskripsiSikapSiswa::where('anggota_kelas_id', $anggota_kelas->id)->first();

            $data_id_mapel_semester_ini = Mapel::where('tapel_id', session()->get('tapel_id'))->get('id');
            $data_id_mapel_kelompok_a = MappingMapel::whereIn('mapel_id', $data_id_mapel_semester_ini)->where('kelompok', 'A')->get('mapel_id');
            $data_id_mapel_kelompok_b = MappingMapel::whereIn('mapel_id', $data_id_mapel_semester_ini)->where('kelompok', 'B')->get('mapel_id');
            $data_id_pembelajaran_a = Pembelajaran::where('kelas_id', $anggota_kelas->kelas_id)->whereIn('mapel_id', $data_id_mapel_kelompok_a)->get('id');
            $data_id_pembelajaran_b = Pembelajaran::where('kelas_id', $anggota_kelas->kelas_id)->whereIn('mapel_id', $data_id_mapel_kelompok_b)->get('id');

            $data_nilai_kelompok_a = NilaiAkhirRaport::whereIn('pembelajaran_id', $data_id_pembelajaran_a)->where('anggota_kelas_id', $anggota_kelas->id)->get();
            $data_nilai_kelompok_b = NilaiAkhirRaport::whereIn('pembelajaran_id', $data_id_pembelajaran_b)->where('anggota_kelas_id', $anggota_kelas->id)->get();

            $data_id_ekskul = Ekskul::where('tapel_id', session()->get('tapel_id'))->get('id');

            $data_anggota_ekskul = AnggotaEkskul::whereIn('ekskul_id', $data_id_ekskul)->where('anggota_kelas_id', $anggota_kelas->id)->get();
            foreach ($data_anggota_ekskul as $anggota_ekskul) {
                $cek_nilai_ekstra = NilaiEkskul::where('anggota_ekskul_id', $anggota_ekskul->id)->first();
                if (is_null($cek_nilai_ekstra)) {
                    $anggota_ekskul->nilai = null;
                    $anggota_ekskul->deskripsi = null;
                } else {
                    $anggota_ekskul->nilai = $cek_nilai_ekstra->nilai;
                    $anggota_ekskul->deskripsi = $cek_nilai_ekstra->deskripsi;
                }
            }

            $data_prestasi_siswa = PrestasiSiswa::where('anggota_kelas_id', $anggota_kelas->id)->get();
            $kehadiran_siswa = KehadiranSiswa::where('anggota_kelas_id', $anggota_kelas->id)->first();
            $catatan_wali_kelas = CatatanWaliKelas::where('anggota_kelas_id', $anggota_kelas->id)->first();

            $cek_tanggal_raport = TglRaport::where('tapel_id', session()->get('tapel_id'))->first();
            if (is_null($cek_tanggal_raport)) {
                return back()->with('toast_warning', 'Tanggal raport belum disetting oleh admin');
            } else {
                // $raport = PDF::loadview('walikelas.raportsemester.raport', compact('title', 'sekolah', 'anggota_kelas', 'deskripsi_sikap', 'data_nilai_kelompok_a', 'data_nilai_kelompok_b', 'data_anggota_Ekskul', 'data_prestasi_siswa', 'kehadiran_siswa', 'catatan_wali_kelas'))->setPaper($request->paper_size, $request->orientation);
                // return $raport->stream('RAPORT ' . $anggota_kelas->siswa->nama_lengkap . ' (' . $anggota_kelas->kelas->nama_kelas . ').pdf');
            }
        }
    }
}
