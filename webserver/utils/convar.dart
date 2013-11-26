import 'dart:collection';

/**
 * Clase base para la creación de comandos.
 */
class ConVar
{
	String Command 		= '';
	var Value 			= '';
	String Description	= '';
	Function Callback 	= null;

	static HashMap ConList = {};

	/**
	 * Constructor.
	 */
	ConVar(String pCommand, pValue, [String pDescription='', Function pCallback=null])
	{
		// Establecemos la información del comando.
		Command 	= pCommand;
		Description = pDescription;
		Value 		= pValue;
		Callback 	= pCallback;

		// Lo agregamos a la lista de comandos registrados.
		ConList[pCommand] = this;
	}

	/**
	 * Devuelve si es un comando que ejecutará una función en vez de guardar un valor.
	 */
	bool IsCallback()
	{
		return ( Value is Function );
	}

	/**
	 * Ejecuta un comando enfocado en ejecutar una función o si tiene un callback establecido.
	 */
	Execute([List<String> pArgs=null])
	{
		// No ejecutara una función ni tiene un callback definido.
		if ( !IsCallback() && Callback == null )
			return;

		try
		{
			// Ejecutamos la función.
			if ( IsCallback() )
			{
				if ( pArgs != null )
					Value(pArgs);
				else
					Value();
			}

			// Ejecutamos el callback.
			if ( Callback != null )
				Callback();
		}
		catch (e)
		{
			print('');
			print('>> Error al ejecutar un comando: ' + e.toString());
			print('');
		}
	}

	/**
	 * Establece el valor del comando.
	 */
	SetValue(pValue)
	{
		// No es un comando que guarde un valor.
		if ( IsCallback() )
			return;

		// Establecemos.
		Value = pValue.toString();

		// Ejecutamos el callback (Si tiene)
		Execute();
	}

	/**
	 * Devuelve el valor del comando en String.
	 */
	String GetString()
	{
		// No es un comando que guarde un valor.
		if ( IsCallback() )
			return '';

		return Value.toString();
	}

	/**
	 * Devuelve el valor del comando en Int.
	 */
	int GetInt()
	{
		// No es un comando que guarde un valor.
		if ( IsCallback() )
			return 0;

		return int.parse(Value, radix: null, onError: (String source) { return 0; });
	}

	/**
	 * Devuelve el valor del comando en double.
	 */
	double GetDouble()
	{
		// No es un comando que guarde un valor.
		if ( IsCallback() )
			return 0.0;

		return double.parse(Value, (String source) { return 0.0; });
	}

	/**
	 * Devuelve el valor del comando en bool.
	 */
	bool GetBool()
	{
		// No es un comando que guarde un valor.
		if ( IsCallback() )
			return false;

		return ( Value.toString() == 'true' || Value.toString() == '1' ) ? true : false;
	}

	/**
	 * Imprime información del comando.
	 */
	PrintInfo()
	{
		print('');
		print('>> ' + Command + ': ' + Description);
		print('>> Valor: ' + GetString());
		print('');
	}

	/**
	 * Devuelve un comando.
	 */
	static ConVar Get(String pCommand)
	{
		// Al parecer el comando no existe.
		if ( ConList[pCommand] is! ConVar )
			return null;

		return ConList[pCommand];
	}
}