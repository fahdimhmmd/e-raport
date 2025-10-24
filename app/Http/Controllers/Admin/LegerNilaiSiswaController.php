<?php

namespace App\Http\Controllers\Admin;

use App\Models\AnggotaEkskul;
use App\Models\AnggotaKelas;
use App\Models\Ekskul;
use App\Exports\AdminLegerNilaiExport;
use App\Http\Controllers\Controller;
use App\DeskripsiSikapSiswa;
use App\Models\MappingMapel;
use App\Models\NilaiAkhirRaport;
use App\Models\Kelas;
use App\Models\Mapel;
use App\Models\NilaiEkskul;
use App\Models\Pembelajaran;
use App\Models\Tapel;
use Illuminate\Http\Request;
use Excel;

class LegerNilaiSiswaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $title = 'Leger Nilai Siswa';
        $data_kelas = Kelas::where('tapel_id', session()->get('tapel_id'))->get();
        return view('admin.leger.pilihkelas', compact('title', 'data_kelas'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $title = 'Leger Nilai Siswa';
        $tapel = Tapel::findorfail(session()->get('tapel_id'));
        $kelas = Kelas::findorfail($request->kelas_id);
        $data_kelas = Kelas::where('tapel_id', session()->get('tapel_id'))->get();

        $data_id_mapel_semester_ini = Mapel::where('tapel_id', $tapel->id)->get('id');

        $data_id_mapel_kelompok_a = MappingMapel::whereIn('mapel_id', $data_id_mapel_semester_ini)->where('kelompok', 'A')->get('mapel_id');
        $data_id_mapel_kelompok_b = MappingMapel::whereIn('mapel_id', $data_id_mapel_semester_ini)->where('kelompok', 'B')->get('mapel_id');

        $data_id_pembelajaran_all = Pembelajaran::where('kelas_id', $kelas->id)->get('id');
        $data_id_pembelajaran_a = Pembelajaran::where('kelas_id', $kelas->id)->whereIn('mapel_id', $data_id_mapel_kelompok_a)->get('id');
        $data_id_pembelajaran_b = Pembelajaran::where('kelas_id', $kelas->id)->whereIn('mapel_id', $data_id_mapel_kelompok_b)->get('id');

        $data_mapel_kelompok_a = NilaiAkhirRaport::whereIn('pembelajaran_id', $data_id_pembelajaran_a)->groupBy('pembelajaran_id')->get();
        $data_mapel_kelompok_b = NilaiAkhirRaport::whereIn('pembelajaran_id', $data_id_pembelajaran_b)->groupBy('pembelajaran_id')->get();

        $data_ekskul = Ekskul::where('tapel_id', $tapel->id)->get();
        $count_ekskul = count($data_ekskul);

        $data_anggota_kelas = AnggotaKelas::where('kelas_id', $kelas->id)->get();
        foreach ($data_anggota_kelas as $anggota_kelas) {

            $data_nilai_kelompok_a = NilaiAkhirRaport::whereIn('pembelajaran_id', $data_id_pembelajaran_a)->where('anggota_kelas_id', $anggota_kelas->id)->get();
            $data_nilai_kelompok_b = NilaiAkhirRaport::whereIn('pembelajaran_id', $data_id_pembelajaran_b)->where('anggota_kelas_id', $anggota_kelas->id)->get();

            $anggota_kelas->data_nilai_kelompok_a = $data_nilai_kelompok_a;
            $anggota_kelas->data_nilai_kelompok_b = $data_nilai_kelompok_b;

            $rt_pengetahuan = NilaiAkhirRaport::whereIn('pembelajaran_id', $data_id_pembelajaran_all)->where('anggota_kelas_id', $anggota_kelas->id)->avg('nilai_pengetahuan');
            $rt_keterampilan = NilaiAkhirRaport::whereIn('pembelajaran_id', $data_id_pembelajaran_all)->where('anggota_kelas_id', $anggota_kelas->id)->avg('nilai_keterampilan');

            $anggota_kelas->rata_rata_pengetahuan = round($rt_pengetahuan, 0);
            $anggota_kelas->rata_rata_keterampilan = round($rt_keterampilan, 0);

            $anggota_kelas->data_nilai_ekskul = Ekskul::where('tapel_id', $tapel->id)->get();

            foreach ($anggota_kelas->data_nilai_ekskul as $data_nilai_ekskul) {
                $cek_anggota_ekstra = AnggotaEkskul::where('ekskul_id', $data_nilai_ekskul->id)->where('anggota_kelas_id', $anggota_kelas->id)->first();
                if (is_null($cek_anggota_ekstra)) {
                    $data_nilai_ekskul->nilai = '-';
                } else {
                    $cek_nilai_ekstra = NilaiEkskul::where('ekskul_id', $data_nilai_ekskul->id)->where('anggota_ekskul_id', $cek_anggota_ekstra->id)->first();
                    if (is_null($cek_nilai_ekstra)) {
                        $data_nilai_ekskul->nilai = '-';
                    } else {
                        $data_nilai_ekskul->nilai = $cek_nilai_ekstra->nilai;
                    }
                }
            }
        }
        return view('admin.leger.index', compact('title', 'kelas', 'data_kelas', 'data_mapel_kelompok_a', 'data_mapel_kelompok_b', 'data_ekskul', 'count_ekskul', 'data_anggota_kelas'));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $kelas = Kelas::findorfail($id);
        $filename = 'leger_nilai_siswa_kelas ' . $kelas->nama_kelas . ' ' . date('Y-m-d H_i_s') . '.xls';
        // return Excel::download(new AdminLegerNilaiExport($id), $filename);
    }
}
