<?php

namespace app\Post;

class PostsController
{
    public function __construct(PostsRepository $postsRepository)
    {
        $this->postsRepository = $postsRepository;
    }

    public function index()
    {
        $posts = $this->postsRepository->fetchPosts();

        include __DIR__ . "/../../views/post/index.php";

    }

    public function show($id)
    {
        $post = $this->postsRepository->fetchPost($id);

        include __DIR__ . "/../../views/post/show.php";
    }
}
 ?>
