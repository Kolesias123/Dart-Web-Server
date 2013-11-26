import 'dart:io';
import 'dart:convert';

import './utils/convar.dart';

class Server
{
	static HttpServer Handler;

	/**
	 * Arranca el servidor.
	 */
	static Start()
	{
		print('>> Comenzando servidor...');
		HttpServer.bind('127.0.0.1', 8080).then(OnStart);
	}

	/**
	 * Devuelve si el servidor esta listo.
	 */
	static bool IsReady()
	{
		return ( Handler != null );
	}

	/**
	 * Para el servidor.
	 */
	static Stop()
	{
		// Aún no esta listo.
		if ( !IsReady() )
			return;

		Handler.close();
		print('>> Servidor apagado.');
	}

	/**
	 * Al completarse de iniciar el servidor.
	 */
	static OnStart(HttpServer pServer)
	{
		// Ajustamos el recurso y empezamos a escuchar conexiones.
		Handler = pServer;
		Handler.listen(OnRequest);

		print('>> Servidor encendido...');
		print('');
	}

	/**
	 * Al recibir una conexión.
	 */
	static OnRequest(HttpRequest pRequest)
	{
		pRequest.response.close();

		String From = pRequest.uri.toString();
		print('>> Conexion a: ' + From);
	}

	static InitHosts()
	{
		File HostsFile 	= new File('./conf/hosts.json');
		var Hosts 		= JSON.decode( HostsFile.readAsStringSync() );
	}
}