<?php

namespace App\Http\Controllers;

use App\Models\Guru;
use App\Models\Pengumuman;
use App\Models\RiwayatLogin;
use App\Models\Sekolah;
use App\Models\Tapel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function index()
    {
        $title = 'Dasboard';
        $sekolah = Sekolah::first();
        $tapel = Tapel::findorfail(session()->get('tapel_id'));
        $data_pengumuman = Pengumuman::all();
        $data_riwayat_login = RiwayatLogin::where('user_id', '!=', Auth::user()->id)->where('update_at', '>=', Carbon::today())->orderBy('status_login', 'DESC')->orderBy('update_at', 'DESC')->get();

        if (Auth::user()->role == 1) {
            $jumlah_guru = Guru::all()->count();
        }
    }
}
