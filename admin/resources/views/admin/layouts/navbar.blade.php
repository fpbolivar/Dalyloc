{{--  Sidebar menu
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
            <a class="side-menu__item {{ (request()->is('admin/users')) ? 'active' : '' }}"
                href="{{ url('admin/users') }}"><i class="side-menu__icon fe fe-users"></i><span
                    class="side-menu__label">Users</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/business-category')) ? 'active' : '' }}"
                href="{{ url('admin/business-category') }}"><i class="side-menu__icon fe fe-award"></i><span
                    class="side-menu__label">Business Category</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/menu-type')) ? 'active' : '' }}"
                href="{{ url('admin/menu-type') }}"><i class="side-menu__icon fe fe-clipboard"></i><span
                    class="side-menu__label">Menu Type</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/allergies')) || (request()->is('admin/add-allergies')) ? 'active' : '' }}"
                href="{{ url('admin/allergies') }}"><i class="side-menu__icon fe fe-aperture"></i><span
                    class="side-menu__label">Allergies</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/mealsize')) ? 'active' : '' }}"
                href="{{ url('admin/mealsize') }}"><i class="side-menu__icon fe fe-command"></i><span
                    class="side-menu__label">Meal Size</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/user-business')) ? 'active' : '' }}"
                href="{{ url('admin/user-business') }}"><i class="side-menu__icon fe fe-bar-chart"></i><span
                    class="side-menu__label">User Business</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/workout-level')) ? 'active' : '' }}"
                href="{{ url('admin/workout-level') }}"><i class="side-menu__icon fe fe-chevrons-up"></i><span
                    class="side-menu__label">Workout Levels</span></a>
        </li>

        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/exercise')) || (request()->is('admin/add-exercise')) ? 'active' : '' }}"
                href="{{ url('admin/exercise') }}"><i class="side-menu__icon fe fe-git-merge"></i><span
                    class="side-menu__label">Exercise</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/ingredients')) ? 'active' : '' }}"
                href="{{ url('admin/ingredients') }}"><i class="side-menu__icon fe fe-package"></i><span
                    class="side-menu__label">Ingredients</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/meal-categories')) ? 'active' : '' }}"
                href="{{ url('admin/meal-categories') }}"><i class="side-menu__icon fe fe-menu"></i><span
                    class="side-menu__label">Meal Categories</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/meal-cookware')) ? 'active' : '' }}"
                href="{{ url('admin/meal-cookware') }}"><i class="side-menu__icon fe fe-box"></i><span
                    class="side-menu__label">Meal Cookware</span></a>
        </li>
        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/recipes')) ? 'active' : '' }}"
                href="{{ url('admin/recipes') }}"><i class="side-menu__icon fe fe-book-open"></i><span
                    class="side-menu__label">Recipes</span></a>

        </li>

        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/workout')) ? 'active' : '' }}"
                href="{{ url('admin/workout') }}"><i class="side-menu__icon fe fe-crosshair"></i><span
                    class="side-menu__label">Workout</span></a>
        </li>

        <li class="slide">
            <a class="side-menu__item {{ (request()->is('admin/workout-exercise')) ? 'active' : '' }}"
                href="{{ url('admin/workout-exercise') }}"><i class="side-menu__icon fe fe-globe"></i><span
                    class="side-menu__label">Workout Exercise</span></a>
        </li>


    </ul>
</aside>
{{-- 				 /Sidebar menu --}}