<?php

/**
 * Configuration for database connection
 *
 */

$host       = "127.0.0.1";
$username   = "root";
$password   = "R31nsta11@";
$dbname     = "test";
$dsn        = "mysql:host=$host;port=5000;dbname=$dbname";
$options    = array(
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
              );
