<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */

    protected $commands = [
        Commands\SendSchedulePushNotificationCron::class,
        Commands\PrayerCorn::class,
        Commands\UserMealCorn::class,
    ];

    protected function schedule(Schedule $schedule)
    {
        $schedule->command('SendSchedule:PushNotification')->cron('*/10 * * * *')->withoutOverlapping();
        $schedule->command('WeeklyWorkout:ThisWeek')->cron('01 0 * * *')->withoutOverlapping();
        $schedule->command('devotional:prayer')->withoutOverlapping();
        $schedule->command('user:meal')->withoutOverlapping();
        
        // $schedule->command('inspire')->hourly();
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
