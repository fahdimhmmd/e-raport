<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeskripsiNilaiSiswa extends Model
{
    protected $table = 'deskripsi_nilai_siswa';
    protected $fillable = [
        'pembelajaran_id',
        'nilai_akhir_raport_id',
        'deskripsi_pengetahuan',
        'deskripsi_keterampilan'
    ];

    public function pembelajaran()
    {
        return $this->belongsTo('App\Pembelajaran');
    }

    public function nilai_akhir_raport()
    {
        return $this->belongsTo('App\NilaiAkhirRaport');
    }
}
