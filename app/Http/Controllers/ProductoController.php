<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Producto;
use Exception;

class ProductoController extends Controller
{
    public function create() {
        return view('crear_producto');
    }

    public function store(Request $request) {
        try {
            // Validar que el nombre no llegue vacío
            $request->validate(['nombre' => 'required|max:255']);

            // Intentar guardar en la DB de Render
            Producto::create($request->all());

            return redirect()->route('productos.create')->with('success', '¡Dato guardado en la nube!');
            
        } catch (Exception $e) {
            // Si hay error de red o de SQL, te manda a la vista de error
            return redirect()->route('error.view');
        }
    }
}