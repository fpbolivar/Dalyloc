<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Model\AdminSetting;

class AdminCommissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [ ['id' => 1, 'option_name' => 'admin_commissions', 'option_value' => '10'],
                  ['id' => 2, 'option_name' => 'exercise_terms', 'option_value' => 'dkjcsd'],
                ];
        foreach ($data as $enty) {
            AdminSetting::create($enty);
        }
        $this->command->info('Admin commission table seeded!');
    }
}
