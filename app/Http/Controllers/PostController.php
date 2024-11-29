<?php

namespace App\Http\Controllers;

use App\Http\Resources\PostResource;
use App\Models\Post;

class PostController extends Controller
{
    public function index()
    {
        return PostResource::collection(
            Post::paginate(
                request()->input('limit', 10)
            )
        );
    }
}
