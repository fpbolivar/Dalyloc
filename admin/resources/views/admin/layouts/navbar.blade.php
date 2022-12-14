{{-- Sidebar menu
--}}
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar doc-sidebar">
    <div class="app-sidebar__user clearfix">
        <div class="dropdown user-pro-body">
            <div>
                <img src="{{asset('admin/assets/images//25.png')}}" alt="user-img" class="avatar avatar-lg brround">
                <a href="{{ url('admin/update-profile') }}" class="profile-img">
                    <span class="fa fa-pencil" aria-hidden="true"></span>
                </a>
            </div>
            <div class="user-info">
                <h2>{{auth()->guard('admin')->user()->name}}</h2>
            </div>
        </div>
    </div>
    <ul class="side-menu">
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/dashboard')) ? 'active' : '' }}"
                href="{{ url('admin/dashboard') }}"><i class="side-menu__icon fe fe-home"></i><span
                    class="side-menu__label">Dashboard</span></a>
        </li>

        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/subscription-plan')) ? 'active' : '' }}"
                href="{{ url('admin/subscription-plan') }}"><i class="side-menu__icon fe fe-clock"></i><span
                    class="side-menu__label">Subscription Plan</span></a>
        </li>

        <li class="slide ">
            <a class="side-menu__item {{ (request()->is('admin/users')) || (request()->is('admin/block-user')) ? 'active' : '' }}"
                data-toggle="slide" href="#">
                <i class="side-menu__icon fe fe-user"></i>
                <span class="side-menu__label">Users</span>
                <i class="angle fa fa-angle-right"></i></a>
            <ul class="slide-menu">
                <li class=" {{ (request()->is('admin/users'))  ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/users')) ? 'active' : '' }}"
                        href="{{ url('admin/users') }}">Active Users</a>
                </li>
                <li class=" {{ (request()->is('admin/block-user')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/block-user')) }}"
                        href="{{ url('admin/block-user') }}">Block
                        Users</a>
                </li>


            </ul>
        </li>

        <li class="slide {{ (request()->is('admin/add-business-category')) ? 'is-expanded' : ''}} ">
            <a class="side-menu__item {{ (request()->is('admin/business-category'))  || (request()->is('admin/user-business')) ? 'active' : '' }}"
                data-toggle="slide" href="#">
                <i class="side-menu__icon fe fe-award"></i>
                <span class="side-menu__label">Business</span>
                <i class="angle fa fa-angle-right"></i></a>
            <ul class="slide-menu">
                <li
                    class=" {{ (request()->is('admin/business-category')) ||(request()->is('admin/add-business-category')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/business-category'))||(request()->is('admin/add-business-category'))? 'active' : '' }}"
                        href="{{ url('admin/business-category') }}">Business Category</a>
                </li>
                <li class=" {{ (request()->is('admin/user-business')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/user-business')) ? 'active' : '' }}"
                        href="{{ url('admin/user-business') }}">User
                        Business
                    </a>
                </li>


            </ul>
        </li>

        <li class="slide {{ (request()->is('admin/add-menu-type')) ||
                            (request()->is('admin/add-allergies')) ||
                            (request()->is('admin/add-mealsize'))  ||
                            (request()->is('admin/add-meal-category'))||
                            (request()->is('admin/add-meal-cookware'))||
                            (request()->is('admin/add-recipe'))||
                            (request()->is('admin/add-ingredient'))
                             ? 'is-expanded' : '' }}">
            <a class=" side-menu__item {{ (request()->is('admin/menu-type')) || 
                                        (request()->is('admin/add-menu-type')) ||
                                        (request()->is('admin/user-business')) ||
                                        (request()->is('admin/mealsize'))||
                                        (request()->is('admin/add-mealsize')) ||
                                        (request()->is('admin/meal-categories'))||
                                        (request()->is('admin/add-meal-category'))||
                                        (request()->is('admin/meal-cookware'))||
                                        (request()->is('admin/add-meal-cookware'))||
                                        (request()->is('admin/recipes'))||
                                        (request()->is('admin/add-recipe'))||
                                        (request()->is('admin/add-ingredient'))||
                                        (request()->is('admin/ingredients'))
                                        
                                        ? 'active' : '' }}" data-toggle="slide" href="#">
                <i class="side-menu__icon fe fe-clipboard"></i>
                <span class="side-menu__label">Meals</span>
                <i class="angle fa fa-angle-right"></i></a>
            <ul class="slide-menu">
                <li
                    class=" {{ (request()->is('admin/menu-type')) || (request()->is('admin/add-menu-type'))? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/menu-type')) || (request()->is('admin/add-menu-type')) ? 'active' : '' }}"
                        href="{{ url('admin/menu-type') }}">Menu Type</a>
                </li>
                <li
                    class=" {{ (request()->is('admin/allergies')) || (request()->is('admin/add-allergies')) ? 'active' : '' }}">
                    <a class=" slide-item {{ (request()->is('admin/allergies')) || (request()->is('admin/add-allergies'))  ? 'active' : ''}}"
                        href="{{ url('admin/allergies')}}">
                        Allergies
                    </a>
                </li>

                <li
                    class=" {{ (request()->is('admin/mealsize')) || (request()->is('admin/add-mealsize')) ? 'active' : '' }}">
                    <a class=" slide-item {{ (request()->is('admin/mealsize')) || (request()->is('admin/add-mealsize'))  ? 'active' : ''}}"
                        href="{{ url('admin/mealsize')}}">
                        Meal Size
                    </a>
                </li>
                <li
                    class=" {{ (request()->is('admin/meal-categories')) || (request()->is('admin/add-meal-category')) ? 'active' : '' }}">
                    <a class=" slide-item {{ (request()->is('admin/meal-categories')) || (request()->is('admin/add-meal-category'))  ? 'active' : ''}}"
                        href="{{ url('admin/meal-categories')}}">
                        Meal Categories
                    </a>
                </li>
                <li
                    class=" {{ (request()->is('admin/meal-cookware')) || (request()->is('admin/add-meal-cookware')) ? 'active' : '' }}">
                    <a class=" slide-item {{ (request()->is('admin/meal-cookware')) || (request()->is('admin/add-meal-cookware'))  ? 'active' : ''}}"
                        href="{{ url('admin/meal-cookware')}}">
                        Meal Cookware
                    </a>
                </li>

                <li
                    class=" {{(request()->is('admin/ingredients')) || (request()->is('admin/add-ingredient')) ? 'active' : '' }}">
                    <a class=" slide-item {{ (request()->is('admin/ingredients')) || (request()->is('admin/add-ingredient'))  ? 'active' : ''}}"
                        href="{{ url('admin/ingredients')}}">
                        Ingredients
                    </a>
                </li>
                <li
                    class=" {{(request()->is('admin/recipes')) || (request()->is('admin/add-recipe')) ? 'active' : '' }}">
                    <a class=" slide-item {{ (request()->is('admin/recipes')) || (request()->is('admin/add-recipe'))  ? 'active' : ''}}"
                        href="{{ url('admin/recipes')}}">
                        Recipes
                    </a>
                </li>


            </ul>
        </li>


        <li class="slide {{(request()->is('admin/add-workout-level')) ||
                            (request()->is('admin/add-exercise')) ||
                            (request()->is('admin/add-workout'))||
                            (request()->is('admin/add-workout-exercise'))

                            ? 'is-expanded' : '' }}">
            <a class="side-menu__item {{ (request()->is('admin/workout-level'))  ||
                                         (request()->is('admin/add-workout-level'))||
                                         (request()->is('admin/exercise')) || 
                                         (request()->is('admin/add-exercise')) ||
                                         (request()->is('admin/workout')) || 
                                         (request()->is('admin/add-workout'))||
                                         (request()->is('admin/workout-exercise')) ||
                                         (request()->is('admin/add-workout-exercise'))
                                         
                                          ? 'active' : '' }}" data-toggle="slide" href="#">
                <i class="side-menu__icon fe fe-compass"></i>
                <span class="side-menu__label">Workouts</span>
                <i class="angle fa fa-angle-right"></i></a>
            <ul class="slide-menu">
                <li
                    class=" {{ (request()->is('admin/workout-level'))  || (request()->is('admin/add-workout-level'))? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/workout-level')) ||(request()->is('admin/add-workout-level')) ? 'active' : '' }}"
                        href="{{ url('admin/workout-level') }}">Workout Levels</a>
                </li>
                <li
                    class=" {{ (request()->is('admin/exercise'))  || (request()->is('admin/add-exercise'))? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/exercise')) ||(request()->is('admin/add-exercise')) ? 'active' : '' }}"
                        href="{{ url('admin/exercise') }}">Exercise</a>
                </li>
                <li
                    class=" {{ (request()->is('admin/workout')) || (request()->is('admin/add-workout')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/workout')) ||(request()->is('admin/add-workout')) ? 'active' : '' }}"
                        href="{{ url('admin/workout') }}">Workout</a>
                </li>

                <li
                    class=" {{ (request()->is('admin/workout-exercise')) || (request()->is('admin/add-workout-exercise')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/workout-exercise')) ||(request()->is('admin/add-workout-exercise')) ? 'active' : '' }}"
                        href="{{ url('admin/workout-exercise') }}">Workout Exercise</a>
                </li>
            </ul>
        </li>








        <li class="slide ">
            <a class=" side-menu__item {{ (request()->is('admin/prayer')) || (request()->is('admin/user-prayer')) ? 'active'
            : '' }}" data-toggle="slide" href="#">
                <i class="side-menu__icon fe fe-award"></i>
                <span class="side-menu__label">Devotional</span>
                <i class="angle fa fa-angle-right"></i></a>
            <ul class="slide-menu">
                <li class=" {{ (request()->is('admin/prayer-category')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/prayer-category'))  ? 'active' : '' }}"
                        href="{{ url('admin/prayer-category') }}">Prayer Category</a>
                </li>
                <li class=" {{ (request()->is('admin/prayer')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/prayer')) ? 'active' : '' }}"
                        href="{{ url('admin/prayer') }}">Admin Prayer</a>
                </li>
                <li class=" {{ (request()->is('admin/user-prayer')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/user-prayer'))  ? 'active' : '' }}"
                        href="{{ url('admin/user-prayer') }}">User Prayer</a>
                </li>
            </ul>
        </li>


        <li class="slide {{ (request()->is('admin/create-notification')) 
            ? 'is-expanded': '' }}">
            <a class=" side-menu__item {{ (request()->is('admin/push-notification')) ||
                                          (request()->is('admin/create-notification')) || 
                                          (request()->is('admin/get-push-notification'))? 'active'
            : '' }}" data-toggle="slide" href="#">
                <i class="side-menu__icon fe fe-bell"></i>
                <span class="side-menu__label">Notification</span>
                <i class="angle fa fa-angle-right"></i></a>
            <ul class="slide-menu">
                <li
                    class=" {{ (request()->is('admin/push-notification'))|| (request()->is('admin/create-notification')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/push-notification')) || (request()->is('admin/create-notification')) ? 'active' : '' }}"
                        href="{{ url('admin/push-notification') }}">Push Notification</a>
                </li>
                <li class=" {{ (request()->is('admin/get-push-notification')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/get-push-notification'))  ? 'active' : '' }}"
                        href="{{ url('admin/get-push-notification') }}">Notification Log</a>
                </li>

            </ul>
        </li>

        <li class="slide {{ (request()->is('admin/add-commission')) 
            ? 'is-expanded': '' }}">
            <a class=" side-menu__item {{ (request()->is('admin/get-setting')) ||(request()->is('admin/admin/add-commission'))
            ? 'active'
            : '' }}" data-toggle="slide" href="#">
                <i class="side-menu__icon fe fe-book"></i>
                <span class="side-menu__label">Booking</span>
                <i class="angle fa fa-angle-right"></i></a>
            <ul class="slide-menu">
                {{-- <li
                    class=" {{ (request()->is('admin/push-notification'))|| (request()->is('admin/create-notification')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/push-notification')) || (request()->is('admin/create-notification')) ? 'active' : '' }}"
                        href="{{ url('admin/push-notification') }}">Push Notification</a>
                </li> --}}
                <li
                    class=" {{ (request()->is('admin/get-setting')) || (request()->is('admin/add-commission')) ? 'active' : '' }}">
                    <a class="slide-item {{ (request()->is('admin/get-setting'))   || (request()->is('admin/add-commission'))  ? 'active' : '' }}"
                        href="{{ url('admin/get-setting') }}">Admin Commission </a>
                </li>

            </ul>
        </li>










        {{-- <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/prayer')) ? 'active' : '' }}"
        href="{{ url('admin/prayer') }}"><i class="side-menu__icon fe fe-award"></i><span
            class="side-menu__label">Prayer</span></a>
        </li>

        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/user-prayer')) ? 'active' : '' }}"
                href="{{ url('admin/user-prayer') }}"><i class="side-menu__icon fe fe-award"></i><span
                    class="side-menu__label">User Prayer</span></a>
        </li> --}}

        {{-- <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/push-notification')) ? 'active' : '' }}"
        href="{{ url('admin/push-notification') }}"><i class="side-menu__icon fe fe-bell"></i><span
            class="side-menu__label">Push Notification</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/get-push-notification')) ? 'active' : '' }}"
                href="{{ url('admin/get-push-notification') }}"><i class="side-menu__icon fe fe-bell"></i><span
                    class="side-menu__label"> Notification Log</span></a>
        </li> --}}

    </ul>
</aside>
{{-- /Sidebar menu --}}