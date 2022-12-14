<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class SendSchedulePushNotificationCron extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'SendSchedule:PushNotification';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Send push notifications the are schedule every 10 min';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        return 0;
    }
}
