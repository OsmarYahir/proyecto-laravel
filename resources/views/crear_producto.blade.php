<form action="{{ route('productos.store') }}" method="POST">
    @csrf
    <input type="text" name="nombre" placeholder="Nombre del producto">
    <button type="submit">Guardar</button>
</form>
@if(session('success')) <p style="color:green">{{ session('success') }}</p> @endif