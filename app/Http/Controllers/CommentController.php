<?php

namespace App\Http\Controllers;

use App\Http\Resources\CommentResource;
use App\Models\Comment;

class CommentController extends Controller
{
    public function index()
    {
        return CommentResource::collection(
            Comment::paginate(
                request()->input('limit', 10)
            )
        );
    }
}
