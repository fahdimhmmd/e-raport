<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\Sekolah;
use Illuminate\Database\Seeder;

class SekolahTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Sekolah::create([
            'nama_sekolah' => 'PKBM Tahfizh Ibnu Katsir',
            'npsn' => 'P9984804',
            'kode_pos' => '13870',
            'alamat' => 'Jl. Asy-Syafiiyah, Gg. Taman Melati',
            'logo' => 'default.png',
            'kepala_sekolah' => 'RUDY HARYADI, S.Ei, M.Pd',
        ]);
    }
}
