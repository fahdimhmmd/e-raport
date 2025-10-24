<?php

namespace App\Http\Controllers\Admin;

use App\Models\AnggotaEkskul;
use App\Models\AnggotaKelas;
use App\Models\Guru;
use App\Http\Controllers\Controller;
use App\Models\Ekskul;
use App\Siswa;
use App\Models\Tapel;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class EkskulController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $title = 'Data Ekskul';
        $tapel = Tapel::findorfail(session()->get('tapel_id'));
        $data_ekskul = Ekskul::where('tapel_id', $tapel->id)->orderBy('nama_ekskul', 'ASC')->get();
        foreach ($data_ekskul as $ekskul) {
            $jumlah_anggota = AnggotaEkskul::where('ekskul_id', $ekskul->id)->count();
            $ekskul->jumlah_anggota = $jumlah_anggota;
        }
        $data_guru = Guru::orderBy('nama_lengkap', 'ASC')->get();
        return view('admin.ekskul.index', compact('title', 'data_ekskul', 'tapel', 'data_guru'));
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nama_ekskul' => 'required|min:3|max:50',
            'pembina_id' => 'required',
        ]);
        if ($validator->fails()) {
            return back()->with('toast_error', $validator->messages()->all()[0])->withInput();
        } else {
            $tapel = Tapel::findorfail(session()->get('tapel_id'));
            $ekskul = new Ekskul([
                'tapel_id' => $tapel->id,
                'nama_ekskul' => $request->nama_ekskul,
                'pembina_id' => $request->pembina_id,
            ]);
            $ekskul->save();
            return back()->with('toast_success', 'Ekskul berhasil ditambahkan');
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $title = 'Anggota Ekskul';
        $ekskul = Ekskul::findorfail($id);
        $anggota_ekskul = AnggotaEkskul::where('ekskul_id', $id)->get();

        $id_anggota_ekskul = AnggotaEkskul::where('ekskul_id', $id)->get('anggota_kelas_id');
        $siswa_belum_masuk_ekskul = AnggotaKelas::whereNotIn('id', $id_anggota_ekskul)->get();

        return view('admin.ekskul.show', compact('title', 'ekskul', 'anggota_ekskul', 'siswa_belum_masuk_ekskul'));
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'pembina_id' => 'required',
        ]);
        if ($validator->fails()) {
            return back()->with('toast_error', $validator->messages()->all()[0])->withInput();
        } else {
            $ekskul = Ekskul::findorfail($id);
            $data_ekskul = [
                'pembina_id' => $request->pembina_id,
            ];
            $ekskul->update($data_ekskul);
            return back()->with('toast_success', 'Ekskul berhasil diedit');
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $ekskul = Ekskul::findorfail($id);
        try {
            $ekskul->delete();
            return back()->with('toast_success', 'Ekskul berhasil dihapus');
        } catch (\Throwable $th) {
            return back()->with('toast_warning', 'Kosongkan anggota Ekskul terlebih dahulu');
        }
    }

    public function store_anggota(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'anggota_kelas_id' => 'required',
        ]);
        if ($validator->fails()) {
            return back()->with('toast_warning', 'Tidak ada siswa yang dipilih');
        } else {
            $anggota_kelas_id = $request->input('anggota_kelas_id');
            for ($count = 0; $count < count($anggota_kelas_id); $count++) {
                $data = array(
                    'anggota_kelas_id' => $anggota_kelas_id[$count],
                    'ekskul_id'  => $request->ekskul_id,
                    'created_at'  => Carbon::now(),
                    'updated_at'  => Carbon::now(),
                );
                $insert_data[] = $data;
            }

            AnggotaEkskul::insert($insert_data);
            return back()->with('toast_success', 'Anggota Ekskul berhasil ditambahkan');
        }
    }

    public function delete_anggota($id)
    {
        try {
            $anggota_ekskul = AnggotaEkskul::findorfail($id);
            $anggota_ekskul->delete();
            return back()->with('toast_success', 'Anggota Ekskul berhasil dihapus');
        } catch (\Throwable $th) {
            return back()->with('toast_error', 'Anggota Ekskul tidak dapat dihapus');
        }
    }
}
