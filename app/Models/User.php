<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use Notifiable;


    protected $table = 'user';
    protected $fillable = [
        'username',
        'password',
        'role',
        'status',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function admin()
    {
        return $this->hasOne('App\Admin');
    }
    public function guru()
    {
        return $this->hasOne('App\Guru');
    }
    public function siswa()
    {
        return $this->hasOne('App\Siswa');
    }
    public function pengumuman()
    {
        return $this->hasMany('App\Pengumuman');
    }
}
