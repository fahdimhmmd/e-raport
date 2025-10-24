<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AnggotaEkskul extends Model
{
    protected $table = 'anggota_Ekskul';
    protected $fillable = [
        'anggota_kelas_id',
        'Ekskul_id',
    ];

    public function anggota_kelas()
    {
        return $this->belongsTo('App\AnggotaKelas');
    }

    public function ekskul()
    {
        return $this->belongsTo('App\Ekskul');
    }

    public function nilai_ekskul()
    {
        return $this->hasOne('App\NilaiEkskul');
    }
}
