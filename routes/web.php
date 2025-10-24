<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\ProfileUserController;
use Illuminate\Support\Facades\Route;
use Symfony\Component\CssSelector\Node\FunctionNode;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/unauthorized', function () {
    $title = 'Unauthorized';
    return view('errorpage.401', compact('title'));
});

Route::get('/', [AuthController::class, 'index'])->name('login');
Route::post('/', [AuthController::class, 'store'])->name('login');
Route::post('/settingtapel', [AuthController::class, 'setting_tapel'])->name('setting.tapel');

Route::group(['middlewate' => ['auth']], function () {

    Route::get('/logout', [AuthController::class, 'logout'])->name('logout');
    Route::get('/password', [AuthController::class, 'view_ganti_password'])->name('gantipassword');
    Route::post('/password', [AuthController::class, 'ganti_password'])->name('gantipassword');

    Route::get('/profile', [ProfileUserController::class, 'index'])->name('profile');

    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

    //Route User Admin
    Route::group(['middleware' => 'checkRole:1'], function () {
        Route::group(['prefix' => 'admin'], function () {
            Route::resource('profileadmin', 'Admin\ProfileController', [
                'uses' => ['update']
            ]);
            Route::resource('pengumuman', 'Admin\PengumumanController', [
                'uses' => ['index', 'store', 'update']
            ]);
            Route::resource('user', 'Admin\UserController', [
                'uses' => ['index', 'store', 'update']
            ]);
            Route::resource('sekolah', 'Admin\SekolahController', [
                'uses' => ['index', 'update']
            ]);
            Route::resource('guru', 'Admin\GuruController', [
                'uses' => ['index', 'store', 'update', 'destroy']
            ]);
            Route::resource('tapel', 'Admin\TapelController', [
                'uses' => ['index', 'store']
            ]);
            Route::resource('mapel', 'Admin\MapelController', [
                'uses' => ['index', 'store', 'update', 'destroy']
            ]);
            Route::resource('kelas', 'Admin\KelasController', [
                'uses' => ['index', 'store', 'show', 'destroy']
            ]);
            Route::resource('siswa', 'Admin\SiswaController', [
                'uses' => ['index', 'store', 'update', 'destroy']
            ]);
            Route::resource('pembelajaran', 'Admin\PembelajaranController', [
                'uses' => ['index', 'store']
            ]);
            Route::resource('ekskul', 'Admin\EkskulController', [
                'uses' => ['index', 'store', 'show', 'destroy']
            ]);
            Route::resource('rekapkehadiran', 'Admin\RekapKehadiranController', [
                'uses' => ['index', 'store']
            ]);

            Route::group(['middleware' => 'checkKurikulum:Merdeka'], function () {

                Route::resource('kkm', 'Admin\KkmMapelController', [
                    'uses' => ['index', 'store', 'update', 'destroy']
                ]);
                Route::resource('interval', 'Admin\IntervalPredikatController', [
                    'uses' => ['index']
                ]);
                Route::resource('kd', 'Admin\KdMapelController', [
                    'uses' => ['index', 'create', 'store', 'update', 'destroy']
                ]);
                Route::resource('tglraport', 'Admin\TglRaportController', [
                    'uses' => ['index', 'store', 'update', 'destroy']
                ]);
                Route::resource('validasi', 'Admin\ValidasiController', [
                    'uses' => ['index']
                ]);
            });
        });
    });
});
