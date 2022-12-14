<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Database\Seeders\PrayerSeeder;
use Database\Seeders\AdminSeeder;
use Database\Seeders\SubscriptionPlansSeeder;
use Database\Seeders\SubscriptionSubPlansSeeder;


class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call([
            PrayerSeeder::class,
            AdminSeeder::class,
            SubscriptionPlansSeeder::class,
            SubscriptionSubPlansSeeder::class
        ]);
    }
}
