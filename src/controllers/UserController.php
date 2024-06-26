<?php

namespace App\Controllers;

use App\Repositories\UserRepository;

class UserController
{
    private $userRepository;

    public function __construct()
    {
        $this->userRepository = new UserRepository();
    }

    public function login()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $login = $_POST['login'];
            $password = $_POST['password'];
            $user = $this->userRepository->login($login, $password);

            if ($user) {
                // Set session or token
                $_SESSION['user_id'] = $user['id'];
                header('Location: /dashboard');
                exit();
            } else {
                echo "Invalid login or password";
            }
        } else {
            include 'public/views/login.php';
        }
    }

    public function register()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $email = $_POST['email'];
            $login = $_POST['login'];
            $password = $_POST['password'];
            $confirmPassword = $_POST['confirm-password'];

            if ($password === $confirmPassword) {
                $this->userRepository->register($email, $login, $password);
                header('Location: /login');
                exit();
            } else {
                echo "Passwords do not match";
            }
        } else {
            include 'public/views/register.php';
        }
    }

    public function profile()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // Handle profile update logic
        } else {
            include 'public/views/profile.php';
        }
    }
}
