<html>
    <body>
        <h1>Post</h1>

        <?php

            include("../database.php");

            $title = $_GET['title'];
            $post = fetch_post($title);

        ?>
        <h3><?php echo $post["title"]; ?></h3>
        <p><?php echo $post["content"]; ?></p>


    </body>
</html>
