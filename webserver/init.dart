import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'server.dart';
import 'console.dart';


/**
 * Constructor
 */
main()
{
	Server.Start();
	Console.Start();
}