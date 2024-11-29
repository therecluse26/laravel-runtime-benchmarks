<?php

use App\Http\Controllers\CommentController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return response()->json(['message' => 'Hello, World!']);
});

Route::get('/posts', [PostController::class, 'index']);

Route::get("/users", [UserController::class, 'index']);

Route::get('/comments', [CommentController::class, 'index']);
