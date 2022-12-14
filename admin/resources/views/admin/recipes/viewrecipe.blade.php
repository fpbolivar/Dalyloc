@extends('admin.layouts.main')
@section('contents')
<style type="text/css">
    .custom-switch {
        padding-left: unset !important;
    }

    .text-muted {
        color: black !important;
        font-weight: 800;
    }

    #ingredientsList li {
        background: url('../../images/recipes/meal-ingredients.png') no-repeat left center;
        padding: 5px 10px 5px 35px;
        vertical-align: middle;
        margin: 0;
    }

    #instructionsList li {
        line-height: 35px;
    }

    #instructionsList span.step {
        padding: 5px 10px;
        background-color: wheat;
        border-radius: 50%;
        margin: 0 10px 0 0;
    }
</style>
<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Recipe Detail</h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{env('BACK_URL').'recipes'}}"> <i class="fa fa-arrow-left "></i>
                        Go
                        Back</a></li>
            </ol>
        </div>

        <h6 class="page-title" style="font-weight:600">Recipe Detail</h6>
        <div class="card">
            <div class="card-body">
                <div class="body">
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12">
                            <table style="width:100%">
                                <tr>
                                    <td class="text-muted" style="width:20%">Name:</td>
                                    <td>
                                        {{($recipe['meal_name'])?ucfirst($recipe['meal_name']):'N/A'}}
                                    </td>
                                    <td rowspan="7"><img
                                            src="{{($recipe['meal_image'])? asset($recipe['meal_image']):asset('/images/business/download.png')}}"
                                            style="width: 50%;float: right;"></td>
                                </tr>
                                <tr>
                                    <td class="text-muted" style="width:20%">Description:</td>
                                    <td>{{($recipe['description'])?$recipe['description']:'N/A'}}
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-muted" style="width:20%">Meal Categories:</td>
                                    <td>
                                        {{($recipe['meal_category_id'])?$recipe['meal_category_id']:'N/A'}}
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-muted" style="width:20%">Menu Types:</td>
                                    <td>
                                        {{($recipe['menu_type_id'])?$recipe['menu_type_id']:'N/A'}}
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-muted" style="width:20%">Meal Cookware:</td>
                                    <td>
                                        {{($recipe['meal_cookware_id'])?$recipe['meal_cookware_id']:'N/A'}}
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-muted" style="width:20%">Cooking Time:</td>
                                    <td>
                                        {{($recipe['meal_cooking_timing'])?$recipe['meal_cooking_timing']:'N/A'}}
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-muted" style="width:20%">Calorie Count:</td>
                                    <td>
                                        {{($recipe['meal_calories'])?$recipe['meal_calories']:'N/A'}}
                                    </td>
                                </tr>
                            </table>
                            <hr>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h6 class="page-title" style="font-weight:600">Meal Ingredients</h6>

        <div class="card">
            <div class="card-body">
                <ul id="ingredientsList">
                    @foreach($recipe['ingredients'] as $meal_ingredient)
                    @if($meal_ingredient['is_deleted'] == '0')
                    <li>{{$meal_ingredient['quantity']}} of {{$meal_ingredient['ingredient']}}</li>
                    @endif
                    @endforeach
                </ul>
            </div>
        </div>

        <h6 class="page-title" style="font-weight:600">Meal Instructions</h6>

        <div class="card">
            <div class="card-body">
                <ul id="instructionsList">
                    @foreach($recipe['instructions'] as $meal_instruction)
                    @if($meal_instruction['is_deleted'] == '0')
                    <li><span class="step">{{$meal_instruction['step_no']}}</span> {{$meal_instruction['description']}}
                    </li>
                    @endif
                    @endforeach
                </ul>
            </div>
        </div>

    </div>

</div>
@endsection

@section('js')
<script type="text/javascript">
    $('#usersTable').DataTable({
    // dom: 'Bfrtip',
    dom: 'frtip',
    // buttons: [{
    //         extend: 'excelHtml5',
    //         exportOptions: {
    //             columns: ':not(.notexport)'
    //         }
    //     },
    //     {
    //         extend: 'csvHtml5',
    //         exportOptions: {
    //             columns: ':not(.notexport)'
    //         }
    //     }
    // ]
});
</script>
@endsection