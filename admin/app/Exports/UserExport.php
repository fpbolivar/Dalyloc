<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use App\Models\User;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class UserExport implements FromCollection,WithHeadings,WithMapping

{
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        return User::where('is_deleted', '0')->get();
 
    }
    public function headings(): array
    { 
        $columns = [
            'id',
            'Name',
            
        ];
        return $columns;
    }

    public function map($user): array
    {
        $row = [
            $user->id,
            ($user->name)?$user->name:'',
            // ($pin->created_at ? date('m/d/Y',strtotime($pin->created_at)): ''),
            // ($pin->updated_at ? date('m/d/Y',strtotime($pin->updated_at)) : ''),
        ];
        return $row;
    }

}
