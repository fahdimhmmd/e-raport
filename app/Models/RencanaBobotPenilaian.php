<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RencanaBobotPenilaian extends Model
{
    protected $table = 'rencana_bobot_penilaian';
    protected $fillable = [
        'pembelajaran_id',
        'bobot_ph',
        'bobot_pts',
        'bobot_pas',
    ];

    public function pembelajaran()
    {
        return $this->belongsTo('App\Pembelajaran');
    }
}
