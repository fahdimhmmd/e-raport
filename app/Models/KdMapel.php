<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KdMapel extends Model
{
    protected $table = 'kd_mapel';
    protected $fillable = [
        'mapel_id',
        'tingkatan_kelas',
        'jenis_kompetensi',
        'semester',
        'kode_kd',
        'kompetensi_dasar',
        'ringkasan_kompetensi',
    ];

    public function mapel()
    {
        return $this->belongsTo('App\Mapel');
    }

    public function rencana_nilai_pengetahuan()
    {
        return $this->hasMany('App\RencanaNilaiPengetahuan');
    }

    public function rencana_nilai_keterampilan()
    {
        return $this->hasMany('App\RencanaNilaiKeterampilan');
    }
}
