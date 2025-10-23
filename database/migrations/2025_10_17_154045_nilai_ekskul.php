<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('nilai_ekskul', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('ekskul_id')->unsigned();
            $table->unsignedBigInteger('anggota_ekskul_id')->unsigned();
            $table->enum('nilai', ['4', '3', '2', '1']);
            $table->string('deskripsi', 200);

            $table->timestamps();

            $table->foreign('ekskul_id')->references('id')->on('ekskul');
            $table->foreign('anggota_ekskul_id')->references('id')->on('anggota_ekskul');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('nilai_ekskul');
    }
};
