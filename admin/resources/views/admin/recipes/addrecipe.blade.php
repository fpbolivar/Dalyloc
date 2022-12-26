@extends('admin.layouts.main')
@section('contents')
@section('title') {{'Add Recipe' }} @endsection
<style>
    .chosen-container {
        font-size: 15px;
        font-family: 'Nunito', sans-serif;
        height: 35px;
        display: block;
    }

    .chosen-container-multi .chosen-choices li.search-field input[type=text] {
        font-family: 'Nunito', sans-serif;
        height: 35px;
    }

    .chosen-container-multi .chosen-choices li.search-choice {
        margin: 8px 5px 8px 0;
    }

    .chosen-container-multi .chosen-choices {
        border: 1px solid #e0e8f3;
        background-image: none;
        border-radius: 3px
    }

    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        margin: 0;
    }
</style>
<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Add Recipe</h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="{{env('BACK_URL').'recipes'}}">
                        <i class="fa fa-arrow-left "></i>Go Back
                    </a>
                </li>
            </ol>
        </div>
        <!--Page-Header-->

        <div class="row ">
            <div class="col-lg-12">
                <form class="card" method="post" action="" enctype="multipart/form-data">
                    @csrf
                    <div class="card-header">
                        <h3 class="card-title">Add Recipe</h3>
                    </div>
                    <div class="card-body">
                        @include('admin.layouts.message')
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Recipe Name *</label>
                                    <input type="text" class="form-control" placeholder="Enter recipe name"
                                        name="meal_name">
                                    @error("meal_name")
                                    <span class="help-block text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Meal Category *</label>
                                    <select data-placeholder="Choose Meal Category" class="form-control chosen-select"
                                        multiple tabindex="4" id="meal_category">
                                        <option value=""></option>
                                        @foreach($meal_categories as $meal_category)
                                        <option value="{{$meal_category['id']}}">{{$meal_category['name']}}</option>
                                        @endforeach
                                    </select>
                                    @error("meal_category")
                                    <span class="help-block text text-danger">{{$message}}</span>
                                    @enderror
                                    <input type="hidden" name="meal_category">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Menu Type *</label>
                                    <select data-placeholder="Choose Menu Type" class="form-control chosen-select"
                                        multiple tabindex="4" id="menu_type">
                                        <option value=""></option>
                                        @foreach($menu_types as $menu_type)
                                        <option value="{{$menu_type['id']}}">{{$menu_type['name']}}</option>
                                        @endforeach
                                    </select>
                                    @error("menu_type")
                                    <span class="help-block text text-danger">{{$message}}</span>
                                    @enderror
                                    <input type="hidden" name="menu_type">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Meal Cookware *</label>
                                    <select data-placeholder="Choose Meal Cookware" class="form-control chosen-select"
                                        multiple tabindex="4" id="meal_cookware">
                                        <option value=""></option>
                                        @foreach($meal_cookware as $cookware)
                                        <option value="{{$cookware['id']}}">{{$cookware['name']}}</option>
                                        @endforeach
                                    </select>
                                    @error("meal_cookware")
                                    <span class="help-block text text-danger">{{$message}}</span>
                                    @enderror
                                    <input type="hidden" name="meal_cookware">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Cooking Time *</label>
                                    <input type="text" class="form-control" placeholder="Enter cooking time"
                                        name="cooking_time">
                                    @error("cooking_time")
                                    <span class="help-block text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Calorie Count *</label>
                                    <input type="number" class="form-control" placeholder="Enter calorie count"
                                        name="calorie_count">
                                    @error("calorie_count")
                                    <span class="help-block text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="body">
                                        <label class="form-label">Recipe Description *</label>
                                        <textarea name="description" rows="9" cols="63"></textarea>
                                    </div>
                                    @error("description")
                                    <span class="help-block text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="body">
                                        <label class="form-label">Image *</label>
                                        <input name="meal_image" type="file" class="dropify-event" data-default-file=""
                                            data-allowed-file-extensions="jpeg jpg png">
                                    </div>
                                    @error("meal_image")
                                    <span class="help-block text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                        </div>
                        <div class="card-header">
                            <h4 class="card-title">Meal Ingredients</h4>
                        </div>
                        <div class="card-body">
                            @include('admin.layouts.message')
                            <div>
                                <a onclick="addField('ingredients');"><i
                                        class="zmdi zmdi-plus-circle-o zmdi-hc-fw"></i></a>
                                <a onclick="deleteField('ingredients');"><i
                                        class="zmdi zmdi-minus-circle-outline zmdi-hc-fw"></i></a>
                            </div>
                            <table id="ingredientsTable" style="width:100%;">
                                <th></th>
                                <th>Ingredient *</th>
                                <th>Quantity *</th>
                                <tr> @php $i=1;
                                    @endphp
                                    <td><label class="labeld"></label></td>
                                    <td>
                                        <select name="ingredients[]" id="ingredient_1" class="form-control" required>
                                            <option value="">Select Ingredient</option>
                                            @foreach($ingredients as $ingredient)
                                            <option value="{{$ingredient['id']}}">{{$ingredient['name']}}</option>
                                            @endforeach
                                        </select>

                                    </td>
                                    <td>
                                        <input type="text" class="form-control" placeholder="Enter Quantity"
                                            name="quantity[]" id="quantity_1">
                                        @error("quantity")
                                        <span class="help-block text text-danger">{{$message}}</span>
                                        @enderror

                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="card-header">
                            <h4 class="card-title">Meal Instructions</h4>
                        </div>
                        <div class="card-body">
                            @include('admin.layouts.message')
                            <div>
                                <a onclick="addField('instructions');"><i
                                        class="zmdi zmdi-plus-circle-o zmdi-hc-fw"></i></a>
                                <a onclick="deleteField('instructions');"><i
                                        class="zmdi zmdi-minus-circle-outline zmdi-hc-fw"></i></a>
                            </div>
                            <table id="instructionsTable" style="width:100%;">
                                <th></th>
                                <th>Step No. *</th>
                                <th>Instruction *</th>
                                <tr> @php $i=1;
                                    @endphp
                                    <td><label class="labeld"></label></td>
                                    <td style="width: 20%">
                                        <input type="number" class="form-control" placeholder="Step No." name="step[]"
                                            id="step_1" required>

                                    </td>
                                    <td>
                                        <input type="text" class="form-control" placeholder="Instruction"
                                            name="instruction[]" id="instruction_1" required>

                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer text-right">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection
@section('js')
<script type="text/javascript">
    $('.dropify-event').dropify();

$('.chosen-select').chosen({

}).change(function(obj, result) {
    console.log(obj.target.id);
    console.log(result);
    var ids = $('input[name='+obj.target.id+']').val();
    if(ids == null || ids == '') {
        $('input[name='+obj.target.id+']').val(result.selected);
    }
    else {
        $('input[name='+obj.target.id+']').val(ids+','+result.selected);
    }
});
$('<li><i class="fa fa-angle-down" /></li>').css({position: "absolute", right: "10px", top: "9px" }).appendTo('ul.chosen-choices');
</script>

<script type="text/javascript">
    function addField(argument) {
        if(argument == 'ingredients') {
            var myTable = document.getElementById("ingredientsTable");
            var currentIndex = myTable.rows.length;
            var currentRow = myTable.insertRow(-1);

            var sNoLabel = currentIndex;
            var CheckBox = document.createElement("label");
            CheckBox.setAttribute("name", "particulars[] " + currentIndex);
            CheckBox.setAttribute("type", "text");
            CheckBox.setAttribute("required", "");

            var ingredient = document.createElement('select');
            ingredient.setAttribute('name', "ingredients[]" + currentIndex);
            ingredient.setAttribute('class', "form-control");
            ingredient.setAttribute('id', "ingredient_" + currentIndex);
            ingredient.setAttribute("required", "");
            var ingredientid = $("#ingredient_1 option");
            let selectedoption = [];
            let value = [];

            $("#ingredient_1 option").each(function() {
                selectedoption.push(this.innerHTML);
                value.push(this.index)
            });

            //  var array = ["Select Variable Category", "gm", "ml"];
            var array = selectedoption
            var val = value
            // var val = ["", "gm", "ml"];
            for (var i = 0; i < array.length; i++) {

                var option = document.createElement("option");
                if (i == 0) {
                    option.disabled = true;
                    option.selected = true;
                }
                option.value = val[i];
                option.text = array[i];
                ingredient.appendChild(option);
            }

            var quantity = document.createElement("input");
            quantity.setAttribute("name", "quantity[] " + currentIndex);
            quantity.setAttribute("class", "form-control");
            quantity.setAttribute('id', "quantity_" + currentIndex);
            quantity.setAttribute("placeholder", "Enter Quantity");
            quantity.setAttribute("required", "");
            quantity.setAttribute("type", "text");

            var currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(CheckBox);

            var currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(ingredient);

            var currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(quantity);
        }
        else {
            var myTable = document.getElementById("instructionsTable");
            var currentIndex = myTable.rows.length;
            var currentRow = myTable.insertRow(-1);

            var sNoLabel = currentIndex;
            var CheckBox = document.createElement("label");
            CheckBox.setAttribute("name", "particulars[] " + currentIndex);
            CheckBox.setAttribute("type", "text");
            CheckBox.setAttribute("required", "");

            var step = document.createElement('input');
            step.setAttribute('name', "step[]" + currentIndex);
            step.setAttribute('class', "form-control");
            step.setAttribute('id', "step_" + currentIndex);
            step.setAttribute("placeholder", "Step No.");
            step.setAttribute("required", "");
            step.setAttribute("type", "number");

            var instruction = document.createElement("input");
            instruction.setAttribute("name", "instruction[] " + currentIndex);
            instruction.setAttribute("class", "form-control");
            instruction.setAttribute("placeholder", "Instruction");
            instruction.setAttribute("required", "");
            instruction.setAttribute("type", "text");

            var currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(CheckBox);

            var currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(step);

            var currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(instruction);
        }
    }

    function deleteField(argument) {
        if(argument == 'ingredients') {
            var myTable = document.getElementById("ingredientsTable");
            var currentIndex = myTable.rows.length;
            if (currentIndex == 2) {} else {
                var Table = document.getElementById("ingredientsTable").deleteRow(-1);
            }
        }
        else {
            var myTable = document.getElementById("instructionsTable");
            var currentIndex = myTable.rows.length;
            if (currentIndex == 2) {} else {
                var Table = document.getElementById("instructionsTable").deleteRow(-1);
            }
        }
    }
</script>

<script src="{{ asset('admin/plugins/ckeditor/ckeditor.js') }}"></script> <!-- Ckeditor -->
<script src="{{ asset('admin/js/pages/forms/editors.js') }}"></script>
@endsection