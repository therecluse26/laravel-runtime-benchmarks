<?php

namespace Database\Seeders;

use App\Models\Comment;
use Illuminate\Database\Seeder;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        Comment::factory(1000)->create();
    }
}
