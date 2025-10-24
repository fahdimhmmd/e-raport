<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NilaiEkskul extends Model
{
    protected $table = 'nilai_ekskul';
    protected $fillable = [
        'ekskul_id',
        'anggota_ekskul_id',
        'nilai',
        'deskripsi'
    ];

    public function ekskul()
    {
        return $this->belongsTo('App\Ekskul');
    }

    public function anggota_ekskul()
    {
        return $this->belongsTo('App\AnggotaEkskul');
    }
}
