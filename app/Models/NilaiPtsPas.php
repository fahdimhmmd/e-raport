<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NilaiPtsPas extends Model
{
    protected $table = 'nilai_pts_pas';
    protected $fillable = [
        'pembelajaran_id',
        'anggota_kelas_id',
        'nilai_pts',
        'nilai_pas',
    ];

    public function pembelajaran()
    {
        return $this->belongsTo('App\Pembelajaran');
    }

    public function anggota_kelas()
    {
        return $this->belongsTo('App\AnggotaKelas');
    }
}
