<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\DeskripsiNilaiSiswa;
use App\Models\NilaiAkhirRaport;
use App\Models\NilaiKeterampilan;
use App\Models\NilaiPengetahuan;
use App\Models\NilaiPtsPas;
use App\Models\RencanaBobotPenilaian;
use App\Models\RencanaNilaiKeterampilan;
use App\Models\RencanaNilaiPengetahuan;
use App\Models\Kelas;
use App\Models\Pembelajaran;
use App\Models\Tapel;
use Illuminate\Http\Request;

class StatusPenilaianController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $title = 'Status Penilaian';
        $data_kelas = Kelas::where('tapel_id', session()->get('tapel_id'))->get();
        return view('admin.statuspenilaian.pilihkelas', compact('title', 'data_kelas'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $title = 'Hasil Pengelolaan Nilai';
        $tapel = Tapel::findorfail(session()->get('tapel_id'));
        $data_kelas = Kelas::where('tapel_id', $tapel->id)->get();

        $kelas = Kelas::findorfail($request->kelas_id);

        $data_pembelajaran_kelas = Pembelajaran::where('kelas_id', $kelas->id)->where('status', 1)->get();
        foreach ($data_pembelajaran_kelas as $pembelajaran) {

            $rencana_pengetahuan = RencanaNilaiPengetahuan::where('pembelajaran_id', $pembelajaran->id)->first();
            if (is_null($rencana_pengetahuan)) {
                $pembelajaran->rencana_pengetahuan = 0;
                $pembelajaran->nilai_pengetahuan = 0;
            } else {
                $pembelajaran->rencana_pengetahuan = 1;
                $nilai_pengetahuan = NilaiPengetahuan::where('rencana_nilai_pengetahuan_id', $rencana_pengetahuan->id)->first();
                if (is_null($nilai_pengetahuan)) {
                    $pembelajaran->nilai_pengetahuan = 0;
                } else {
                    $pembelajaran->nilai_pengetahuan = 1;
                }
            }

            $rencana_keterampilan = RencanaNilaiKeterampilan::where('pembelajaran_id', $pembelajaran->id)->first();
            if (is_null($rencana_keterampilan)) {
                $pembelajaran->rencana_keterampilan = 0;
                $pembelajaran->nilai_keterampilan = 0;
            } else {
                $pembelajaran->rencana_keterampilan = 1;
                $nilai_keterampilan = NilaiKeterampilan::where('rencana_nilai_keterampilan_id', $rencana_keterampilan->id)->first();
                if (is_null($nilai_keterampilan)) {
                    $pembelajaran->nilai_keterampilan = 0;
                } else {
                    $pembelajaran->nilai_keterampilan = 1;
                }
            }

            $rencana_bobot = RencanaBobotPenilaian::where('pembelajaran_id', $pembelajaran->id)->first();
            if (is_null($rencana_bobot)) {
                $pembelajaran->rencana_bobot = 0;
            } else {
                $pembelajaran->rencana_bobot = 1;
            }

            $pts_pas = NilaiPtsPas::where('pembelajaran_id', $pembelajaran->id)->first();
            if (is_null($pts_pas)) {
                $pembelajaran->pts_pas = 0;
            } else {
                $pembelajaran->pts_pas = 1;
            }

            $nilai_akhir = NilaiAkhirRaport::where('pembelajaran_id', $pembelajaran->id)->first();
            if (is_null($nilai_akhir)) {
                $pembelajaran->nilai_akhir = 0;
            } else {
                $pembelajaran->nilai_akhir = 1;
            }

            $deskripsi = DeskripsiNilaiSiswa::where('pembelajaran_id', $pembelajaran->id)->first();
            if (is_null($deskripsi)) {
                $pembelajaran->deskripsi = 0;
            } else {
                $pembelajaran->deskripsi = 1;
            }
        }
        return view('admin.statuspenilaian.index', compact('title', 'kelas', 'data_kelas', 'data_pembelajaran_kelas'));
    }
}
