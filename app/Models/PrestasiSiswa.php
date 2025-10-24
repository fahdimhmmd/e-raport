<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PrestasiSiswa extends Model
{
    protected $table = 'prestasi_siswa';
    protected $fillable = [
        'anggota_kelas_id',
        'jenis_prestasi',
        'deskripsi'
    ];

    public function anggota_kelas()
    {
        return $this->belongsTo('App\AnggotaKelas');
    }
}
