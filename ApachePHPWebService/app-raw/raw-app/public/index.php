<?php
# require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../src/controller.php';

use App\Controller;

$controller = new Controller();
$controller->home();
?>
