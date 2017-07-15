<html>
    <body>
        <h1>Post</h1>

        <?php

            include("../init.php");

            $postsRepository = $container->make('postsRepository');

            $id = $_GET['id'];
            $post = $postsRepository->fetchPost($id);

        ?>
        <h3><?php echo $post['title']; ?></h3>
        <p><?php echo nl2br($post['content']); ?></p>


    </body>
</html>
