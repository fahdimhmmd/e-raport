<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NilaiPengetahuan extends Model
{
    protected $table = 'nilai_pengetahuan';
    protected $fillable = [
        'rencana_nilai_pengetahuan_id',
        'anggota_kelas_id',
        'nilai',
    ];

    public function rencana_nilai_pengetahuan()
    {
        return $this->belongsTo('App\RencanaNilaiPengetahuan');
    }

    public function anggota_kelas()
    {
        return $this->belongsTo('App\AnggotaKelas');
    }
}
