<?php

namespace app\Post;

class PostsController
{
    public function __construct(PostsRepository $postsRepository)
    {

    }

    public function index()
    {
        $postsRepository = $container->make('postsRepository');
        $result = $postsRepository->fetchPosts();
    }
}
 ?>
