<html>
    <body>
        <h1>Post</h1>

        <?php
            include("../init.php");

            $postsController = $container->make('postsController');
            var_dump($postsController);
            $id = $_GET['id'];
            $postsController->show($id);
        ?>

    </body>
</html>
