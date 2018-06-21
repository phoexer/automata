<?php
/**
* This just tests if my system can connect to SAP.
* I created a test RFC in SAP that takes an optional input
* and responds based on that input.
* Nothing special.
**/

use SAPNWRFC\Connection as SapConnection;
use SAPNWRFC\Exception as SapException;

echo "<h1>SAPNWRFC Test</h1>";
$parameters = [
    'ashost' => '', //Hostname or address
    'sysnr'  => '', // System Number
    'client' => '', //Client Number
    'user' => '', //User Name
    'passwd' => '', //Password
    'SAPROUTER' => '', //Router String
];

/* echo "<h3>Connection parameters</h3>";
var_dump($parameters);*/

try {
    $connection = new SapConnection($parameters);

    $remoteFunction = $connection->getFunction('Z_MIM_TEST');
    echo "<h3>Input Variables</h3>";
    $input = [
        'INP' => 'Freedom'
    ];
    var_dump($input);

    $result = $remoteFunction->invoke($input);

    echo "<h3>Return Values</h3>";
    var_dump($result);
    
    $connection->close();
} catch(SapException $ex) {
    echo 'Exception: ' . $ex->getMessage() . PHP_EOL;
} 