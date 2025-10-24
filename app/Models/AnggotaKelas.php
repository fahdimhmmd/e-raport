<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AnggotaKelas extends Model
{
    protected $table = 'anggota_kelas';
    protected $fillable = [
        'siswa_id',
        'kelas_id',
        'pendaftaran',
    ];

    public function siswa()
    {
        return $this->belongsTo('App\Siswa');
    }

    public function kelas()
    {
        return $this->belongsTo('App\Kelas');
    }

    public function anggota_Ekskul()
    {
        return $this->hasMany('App\AnggotaEkskul');
    }

    public function kehadiran_siswa()
    {
        return $this->hasOne('App\KehadiranSiswa');
    }

    public function prestasi_siswa()
    {
        return $this->hasMany('App\PrestasiSiswa');
    }

    public function catatan_wali_kelas()
    {
        return $this->hasOne('App\CatatanWaliKelas');
    }

    public function kenaikan_kelas()
    {
        return $this->hasOne('App\KenaikanKelas');
    }


    // Relasi 
    public function nilai_pengetahuan()
    {
        return $this->hasOne('App\NilaiPengetahuan');
    }

    public function nilai_keterampilan()
    {
        return $this->hasOne('App\NilaiKeterampilan');
    }

    public function nilai_spiritual()
    {
        return $this->hasOne('App\NilaiSpiritual');
    }

    public function nilai_sosial()
    {
        return $this->hasOne('App\NilaiSosial');
    }

    public function nilai_pts_pas()
    {
        return $this->hasOne('App\NilaiPtsPas');
    }

    public function nilai_akhir_raport()
    {
        return $this->hasMany('App\NilaiAkhirRaport');
    }

    public function deskripsi_sikap_siswa()
    {
        return $this->hasOne('App\DeskripsiSikapSiswa');
    }
}
