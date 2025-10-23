<?php

namespace App\Http\Controllers;

use App\Models\RiwayatLogin;
use App\Models\Tapel;
use App\Models\User;
use Illuminate\Auth\Events\Login;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function index()
    {
        $data_tapel = Tapel::orderBy('id', 'DESC')->get();
        if (count($data_tapel) == 0) {
            $title = 'Setting Tahun Pelajaran';
            return view('auth.setting_tapel', compact('title'));
        } else {
            $title = 'Login';
            return view('auth.login', compact('title', 'data_tapel'));
        }
    }

    public function setting_tapel(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'tahun_pelajaran' => 'required|min:9|max:9',
            'semester' => 'required',
        ]);
        if ($validator->fails()) {
            return back()->with('toast_error', $validator->errors()->all()[0])->withInput();
        } else {
            $tapel = new Tapel([
                'tahun_pelajaran' => $request->tahun_pelajaran,
                'semester' => $request->semester,
            ]);
            $tapel->save();
            return back()->with('toast_success', 'Registrasi berhasil');
        }
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'username' => 'required|exists:user',
            'password' => 'required|min:6',
            'kurikulum' => 'required',
            'tahun_pelajaran' => 'required',
        ]);
        if ($validator->fails()) {
            return back()->with('toast_error', $validator->errors()->all()[0])->withInput();
        } else {
            $user_login = User::where('username', $request->username)->first();
            if (!Auth::attempt(['username' => $request->username, 'password' => $request->password])) {
                return back()->with('toast_error', 'password salah.');
            } elseif ($user_login->status == false) {
                return back()->with('toast_error', 'User ' . $user_login->username . ' telah dinonaktifkan');
            } else {
                $cek_riwayat = RiwayatLogin::where('user_id', Auth::id())->first();
                if (is_null($cek_riwayat)) {
                    $riwayat_login = new RiwayatLogin([
                        'user_id' => Auth::id(),
                        'status_login' => true,
                    ]);
                    $riwayat_login->save();
                } else {
                    $cek_riwayat->update(['status_login' => true]);
                }
                session([
                    'kurikulum' => $request->kurikulum,
                    'tapel_id' => $request->tahun_pelajaran,
                ]);

                if (Auth::user()->role == 2) {
                    session([
                        'akses_sebagai' => 'Guru Mapel',
                    ]);
                }
                return redirect('/dashboar')->with('toast_success', 'Login Berhasil');
            }
        }
    }
}
