import 'dart:io';
import 'dart:async';
import 'dart:convert';
//import 'dart:collection';

import 'server.dart';
import './utils/convar.dart';

class Console
{
	static Stream CmdRead;
	//static HashMap Commands = {};

	/**
	 * Empieza a escuchar nuevos comandos desde la consola.
	 */
	static Start()
	{
		CmdRead = stdin.transform(UTF8.decoder).transform( new LineSplitter() );
		CmdRead.listen(Process);

		RegisterCommands();
	}

	/**
	 * Registra los comandos principales.
	 */
	static RegisterCommands()
	{
		new ConVar('stop', Server.Stop, 'Apaga el servidor');
		new ConVar('developer', '0', 'Establece el nivel de depuración.');
		new ConVar('welcome_message', 'Hola!');
	}

	/**
	 * Procesa una línea introducida en la consola.
	 */
	static Process(String pLine)
	{
		List<String> Args 	= pLine.split(' ');
		String pCommand 	= Args[0];
		ConVar Command 		= ConVar.Get(pCommand);

		// El comando introducido no existe.
		if ( Command == null )
		{
			print('>> Comando invalido.');
			return;
		}

		// Un callback con varios argumentos.
		if ( Args.length > 2 )
		{
			Command.Execute(Args);
		}

		// Estamos estableciendo un valor.
		if ( Args.length == 2 )
		{
			Command.SetValue(Args[1]);
		}

		// Estamos ejecutando u obteniendo su valor actual.
		if ( Args.length == 1 )
		{
			if ( Command.IsCallback() )
			{
				Command.Execute();
				return;
			}

			Command.PrintInfo();
		}
	}
}