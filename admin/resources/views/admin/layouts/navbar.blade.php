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

    </ul>
</aside>
{{-- 				 /Sidebar menu --}}