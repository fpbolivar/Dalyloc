# DalyDoc

## STEPS TO SETUP PANEL
1. Clone the repo on your local system
2. You will get the env.example file which includes all the variables that are used in the project.
3. Copy the env.example file in the same location and rename to .env
4. In .env file please update the values for the relevant variables / services mentioned including the database configuration details.
5. Open the cmd in the project location and run command ```composer install``` (Note: If there will be any error then use command = composer update) .
6. After the composer installation, run another command ```php artisan migrate``` for the database migration.
7. When database migrated successfully, hit again a command ```php artisan db:seed``` for getting admin login details.
8. Now all configuration setup done, to run the project on the local browser, run command ```php artisan serve```.

## ADMIN LOGIN DETAILS
email = admin@gmail.com
password = 123456
(Note:Admin Credentials can be changed after login in admin panel)

## API SETUP
We are using the JWL package for the authentication process for the apis. Please follow the steps below for the JWT setup

1. if laravel 8 then
```cmd composer require tymon/jwt-auth --ignore-platform-reqs```
2. add provides and aliases in config->app.php
provider =  Tymon\JWTAuth\Providers\LaravelServiceProvider::class,

'aliases' => [
    ...
    'JWTAuth' => Tymon\JWTAuth\Facades\JWTAuth::class,
     'JWTFactory' => Tymon\JWTAuth\Facades\JWTFactory::class,
],

3. run  php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider"


..if want to change the token timing so 
JWT_TTL=1440    add it at the end of env file(1440 means token for logged in user will be active for 24 hrs.or minutes can be changed ar per requirement.)
4. run   ```php artisan vendor:publish```
then select 10 and hit enter
5. run  ```php artisan jwt:secret```
jwt-auth secret [K2WA9GGpEnJ4UjWMpTYgx469mItbdoMteu0SljuJZBrIEysrkXL5Yc5y8Y69kH1E] set successfully.
when we hit this cmd it create and add this key automatically in env file.

## FEATURES IN THE PANEL

-  Dashboard
   -   Count of Active Users
   -   Count of Business Categories
   -   Count of User Business
   -   Count of Workout Level
   -   Count of Meal Category
-  Admin Profile
    -   View Profile
    -   Edit Profile
    -   Change Password
    -   Logout
-  Subscription Plan
    -   View Main Plan
    -   Change Main Plan Status(active/Inactive) Note:If main plan status changed from active to inactive then its' related sub plans(monthly/annually/free) will be inactive and vice versa
    -   Edit Main Plan
    -   View Subscription Type(Sub Plans)
        -   View Sub Plans/Types
        -   Change Sub Plans/Types Status(active/Inactive) Note:If main plan is Inactive then sub plan will not be actived anyhow.
        -   Edit Sub Plan
-  Users
    -   Active Users
        -   View a User
        -   Change User's Status (block)
        -   Show User's all subscription if has
    -   Block Users
        -   View a User
        -   Change User's Status (restore)
        -   Show User's all subscription if has
-  Business 
    -   Business Category
        -   Add a new Business Category
        -   Change Business Category's Status(block/restore)
        -   Edit Business Category
    - User Business
       - View User's Business List
       - View User's Business Time
       - View User's Business Services
-  Meal
    -   Menu Type
        -   List of Menu Types
        -   Add a new Menu Type
        -   Edit Menu Type
        -   Delete Menu Type
    -    Allergies
        -   List of Allergies
        -   Add a new Allergies
        -   Delete Allergy
        -   Edit Allergies
    -    Meal Size
        -   List of Meal Size
        -   Add a new Meal Size
        -   Edit Meal Size
        -   Delete Meal Size
     -   Meal Categories
        -   List of Meal Categories
        -   Add a new Meal Category
        -   Edit Meal Category
        -   Delete Meal Category
    -   Meal Cookware
        -   List of Meal Cookware
        -   Add a new Meal Cookware
        -   Edit Meal Cookware
        -   Delete Meal Cookware
    -   Ingredients
        -   List of Ingredients
        -   Add a new Ingredient
        -   Edit Ingredient
        -   Delete Ingredient
    -   Recipes
        -   List of Recipes
        -   Add a new Recipe
        -   Edit Recipe
        -   Delete Recipe
        -   View a Recipe
- Workout
    -   Workout Level
        -   List of Workout Levels
        -   Add a new Workout Levels
    -   Exercise
        -   List of Exercises
        -   Add a new Exercise
    -   Workout
        -   List of Workouts
        -   Add a new Workout
    -   Workout Exercise
        -   List of Workout Exercises
        -   Add a new Workout Exercise
-   Devotional
    -   Prayer Category
        -   View Prayer Category
        -   Add a new Prayer Category
        -   Change Prayer Category's Status(block/restore)
        -   Edit Prayer Category
    -   Admin Prayer
        -   View Admin Prayer
    -  User Prayer
       -   List of User's Prayers
       -   Admin Response the Prayer by Edit
       -   View All The Response Againest A User's Prayer
-   Notification
    -  Push Notification 
       -   List of Scheduled Notifications
       -   Create a new Notification
    -  Notification Log
       -   List of sent Notifications  


## COMMIT DETAILS