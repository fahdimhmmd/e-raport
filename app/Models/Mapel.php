<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mapel extends Model
{
    protected $table = 'mapel';
    protected $fillable = [
        'tapel_id',
        'nama_mapel',
        'ringkasan_mapel'
    ];

    public function tapel()
    {
        return $this->belongsTo('App\Tapel');
    }

    public function pembelajaran()
    {
        return $this->hasMany('App\Pembelajaran');
    }

    // Relasi  
    public function mapping_mapel()
    {
        return $this->hasOne('App\MappingMapel');
    }

    public function kkm_mapel()
    {
        return $this->hasOne('App\KkmMapel');
    }

    public function kd_mapel()
    {
        return $this->hasMany('App\KdMapel');
    }
}
