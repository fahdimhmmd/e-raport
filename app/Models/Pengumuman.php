<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pengumuman extends Model
{
    protected $table = 'pengumuman';
    protected $fillable = [
        'User_id',
        'judul',
        'isi',
    ];

    public function user()
    {
        return $this->belongsTo('App\User');
    }
}
