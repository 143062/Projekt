<?php

session_start();

require 'Routing.php';
require 'src/controllers/AppController.php';
require 'src/controllers/UserController.php';
require 'src/controllers/NoteController.php';
require 'src/controllers/AdminController.php';
require 'src/controllers/FriendController.php';
require 'src/repositories/UserRepository.php';
require 'src/repositories/NoteRepository.php';
require 'src/repositories/FriendRepository.php';

use App\Controllers\UserController;
use App\Controllers\NoteController;
use App\Controllers\AdminController;
use App\Controllers\FriendController;

$path = trim($_SERVER['REQUEST_URI'], '/');
$path = parse_url($path, PHP_URL_PATH);

Router::get('', [UserController::class, 'login']);
Router::get('login', [UserController::class, 'login']);
Router::post('login', [UserController::class, 'login']);
Router::get('register', [UserController::class, 'register']);
Router::post('register', [UserController::class, 'register']);
Router::get('add_note', [NoteController::class, 'addNote']);
Router::post('add_note', [NoteController::class, 'addNote']);
Router::get('profile', [UserController::class, 'profile']);
Router::get('admin_panel', [AdminController::class, 'adminPanel']);
Router::get('admin_panel', [AdminController::class, 'adminPanel']);
Router::post('admin/delete_user', [AdminController::class, 'deleteUser']); // Dodana nowa trasa
Router::get('dashboard', [NoteController::class, 'dashboard']);
Router::get('friends', [FriendController::class, 'friends']);
Router::post('add-friend', [FriendController::class, 'addFriend']);

Router::run($path);
