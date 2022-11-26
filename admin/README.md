# DalyDoc

## STEPS TO SETUP PANEL
1. Clone the repo on your local system
2. You will get the env.example file which includes all the variables that are used in the project.
3. Copy the env.example file in the same location and rename to .env
4. In .env file please update the values for the relevant variables / services mentioned including the database configuration details.
5. Open the cmd in the project location and run command ```composer install``` (Note: If there will be any error then use command = composer update) .
6. After the composer installation, run another command ```php artisan migrate``` for the database migration.
7. Now all configuration setup done, to run the project on the local browser, run command ```php artisan serve```.

## API SETUP
We are uding the JWL package for the authentication process for the apis. PLease follow the steps below for the JWT setup

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


2. change the token timing so 
JWT_TTL=1440    add it at the end of env file
3. run   ```php artisan vendor:publish```
then select 10 and hit enter
4. run  ```php artisan jwt:secret```
jwt-auth secret [K2WA9GGpEnJ4UjWMpTYgx469mItbdoMteu0SljuJZBrIEysrkXL5Yc5y8Y69kH1E] set successfully.
when we hit this cmd it create and add token automastically in env file.

## ADMIN LOGIN DETAILS

## FEATURES IN THE PANEL

-   Dashboard
-   Admin Profile
    -   Update Profile
    -   Change Password
    -   Logout
-   Users
    -   List of Registered Users
    -   Change User's Status (block/restore)
    -   Show User's all subscription if has
-   Business Category
-   Add a new Business Category
-   Change Business Category's Status(block/restore)
-   Update Business Category
- Allergies
    -   Add a new Allergies
    -   Update Allergies
    -   Allergies Status(block)
    -   Edit Allergies
-   User Business
    -   Show all User Business
-   Workout Levels
    -   Add a new Workout Levels
    -   Show Workout Levels list
-   Exercise
    -   Add a new Exercise
    -   Show Exercise list
-   Workout
    -   Add a new Workout
    -   Show Workout list
-   Workout Exercise
    -   Add a new Workout Exercise
    -   Show Workout Exercise list
-   Menu Type
    -   List of Menu Types
    -   Add new Menu Type
    -   Edit Menu Type
    -   Delete Menu Type
-   Ingredients
    -   List of Ingredients
    -   Add new Ingredient
    -   Edit Ingredient
    -   Delete Ingredient
-   Meal Categories
    -   List of Meal Categories
    -   Add new Meal Category
    -   Edit Meal Category
    -   Delete Meal Category
-   Meal Cookware
    -   List of Meal Cookware
    -   Add new Meal Cookware
    -   Edit Meal Cookware
    -   Delete Meal Cookware
-   Recipes
    -   List of Recipes
    -   Add new Recipe
    -   Edit Recipe
    -   Delete Recipe
    -   View specific Recipe

## COMMIT DETAILS