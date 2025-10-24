<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ekskul extends Model
{
    protected $table = 'ekskul';
    protected $fillable = [
        'tapel_id',
        'pembina_id',
        'nama_ekskul',
    ];

    public function tapel()
    {
        return $this->belongsTo('App\Tapel');
    }

    public function pembina()
    {
        return $this->belongsTo('App\Guru');
    }

    public function anggota_ekskul()
    {
        return $this->hasMany('App\AnggotaEkskul');
    }

    public function nilai_ekskul()
    {
        return $this->hasMany('App\NilaiEkskul');
    }
}
