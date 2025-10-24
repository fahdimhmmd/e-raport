<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pembelajaran extends Model
{
    protected $table = 'pembelajaran';
    protected $fillable = [
        'kelas_id',
        'mapel_id',
        'guru_id',
        'status'
    ];

    public function kelas()
    {
        return $this->belongsTo('App\Kelas');
    }

    public function mapel()
    {
        return $this->belongsTo('App\Mapel');
    }

    public function guru()
    {
        return $this->belongsTo('App\Guru');
    }

    // Relasi  
    public function rencana_nilai_pengetahuan()
    {
        return $this->hasMany('App\RencanaNilaiPengetahuan');
    }

    public function rencana_nilai_keterampilan()
    {
        return $this->hasMany('App\RencanaNilaiKeterampilan');
    }

    public function rencana_bobot_penilaian()
    {
        return $this->hasOne('App\RencanaBobotPenilaian');
    }

    public function nilai_pts_pas()
    {
        return $this->hasMany('App\NilaiPtsPas');
    }

    public function nilai_akhir_raport()
    {
        return $this->hasMany('App\NilaiAkhirRaport');
    }

    public function deskripsi_nilai_siswa()
    {
        return $this->hasMany('App\DeskripsiNilaiSiswa');
    }
}
