<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductoController;

// Cambiamos la ruta raíz para que llame al método 'create' del controlador
Route::get('/', [ProductoController::class, 'create'])->name('productos.create');

// Mantenemos la ruta de guardado
Route::post('/productos', [ProductoController::class, 'store'])->name('productos.store');

// Ruta de error
Route::get('/error', function () {
    return view('error_page');
})->name('error.view');