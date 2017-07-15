<html>
    <body>
        <h1>Startseite des Blogs</h1>

        <?php

            include("../init.php");

            $postsController = $container->make('postsController');
            $postsController->index();

            /*$postsRepository = $container->make('postsRepository');
            $result = $postsRepository->fetchPosts();*/


        ?>

        <ul>
            <?php foreach ($result AS $row): ?>
                <li>
                    <a href="post.php?id=<?php echo $row->id; ?>">
                        <?php echo $row->title; ?>
                    </a>
                </li>
            <?php endforeach; ?>
        </ul>
    </body>
</html>
