<html>
    <body>
        <h1>Startseite des Blogs</h1>

        <?php

            include("../database.php");

            $result = fetch_posts();


        ?>

        <ul>
            <?php foreach ($result AS $row): ?>
                <li>
                    <a href="post.php?title=<?php echo $row["title"]; ?>">
                        <?php echo $row["title"]; ?>
                    </a>
                </li>
            <?php endforeach; ?>
        </ul>
    </body>
</html>
