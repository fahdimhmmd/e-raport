<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RencanaNilaiPengetahuan extends Model
{
    protected $table = 'rencana_nilai_pengetahuan';
    protected $fillable = [
        'pembelajaran_id',
        'kd_mapel_id',
        'kode_penilaian',
        'teknik_penilaian',
        'bobot_teknik_penilaian',
    ];

    public function pembelajaran()
    {
        return $this->belongsTo('App\Pembelajaran');
    }

    public function kd_mapel()
    {
        return $this->belongsTo('App\KdMapel');
    }

    public function nilai_pengetahuan()
    {
        return $this->hasMany('App\NilaiPengetahuan');
    }
}
