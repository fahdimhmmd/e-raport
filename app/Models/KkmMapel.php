<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KkmMapel extends Model
{
    protected $table = 'kkm_mapel';
    protected $fillable = [
        'mapel_id',
        'kelas_id',
        'kkm',
    ];

    public function mapel()
    {
        return $this->belongsTo('App\Mapel');
    }

    public function kelas()
    {
        return $this->belongsTo('App\Kelas');
    }
}
