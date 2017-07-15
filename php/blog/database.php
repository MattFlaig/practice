<?php

    $pdo = new PDO(
        'mysql:host=localhost;
        dbname=blog;
        charset=utf8',
        'blog',
        '2VUtDpnudh82YNmC'
    );

    $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

    
?>
