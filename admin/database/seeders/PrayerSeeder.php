<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Model\Prayer;

class PrayerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Prayer::updateOrCreate(['id' => 1], [
            "written_by" => "Admin",
            "prayer_description" => "It is better in prayer to have a heart without words than words without heart",
        ]);
        $this->command->info('Prayer table seeded!');
    }
}
