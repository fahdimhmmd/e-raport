<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NilaiAkhirRaport extends Model
{
    protected $table = 'nilai_akhir_raport';
    protected $fillable = [
        'pembelajaran_id',
        'anggota_kelas_id',
        'kkm',
        'nilai_pengetahuan',
        'predikat_pengetahuan',
        'nilai_keterampilan',
        'predikat_keterampilan',
    ];

    public function pembelajaran()
    {
        return $this->belongsTo('App\Pembelajaran');
    }

    public function anggota_kelas()
    {
        return $this->belongsTo('App\AnggotaKelas');
    }

    public function deskripsi_nilai_siswa()
    {
        return $this->hasOne('App\DeskripsiNilaiSiswa');
    }
}
