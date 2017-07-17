<html>
    <body>
        <h1>Startseite des Blogs</h1>

        <?php

            include("../init.php");

            $postsController = $container->make('postsController');
            /*var_dump($postsController);*/
            $postsController->index();

        ?>
    </body>
</html>
