<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RencanaNilaiKeterampilan extends Model
{
    protected $table = 'rencana_nilai_keterampilan';
    protected $fillable = [
        'pembelajaran_id',
        'kg_mapel_id',
        'kode_penilaian',
        'teknik_penilaian',
    ];

    public function pembelajaran()
    {
        return $this->belongsTo('App\Pembelajaran');
    }

    public function kd_mapel()
    {
        return $this->belongsTo('App\KdMapel');
    }

    public function nilai_keterampilan()
    {
        return $this->hasMany('App\NilaiKeterampilan');
    }
}
