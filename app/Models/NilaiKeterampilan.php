<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NilaiKeterampilan extends Model
{
    protected $table = 'nilai_keterampilan';
    protected $fillable = [
        'rencana_nilai_keterampilan_id',
        'anggota_kelas_id',
        'nilai',
    ];

    public function rencana_nilai_keterampilan()
    {
        return $this->belongsTo('App\RencanaNilaiKeterampilan');
    }

    public function anggota_kelas()
    {
        return $this->belongsTo('App\AnggotaKelas');
    }
}
