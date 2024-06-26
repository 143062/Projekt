<?php

namespace App\Controllers;

use App\Repositories\UserRepository;

class AdminController
{
    private $userRepository;

    public function __construct()
    {
        $this->userRepository = new UserRepository();
    }

    public function adminPanel()
    {
        // Tymczasowe dane użytkowników
        $users = [
            ['id' => 1, 'username' => 'user1', 'email' => 'user1@example.com'],
            ['id' => 2, 'username' => 'user2', 'email' => 'user2@example.com'],
        ];
        
        // Przekazanie danych do widoku
        include 'public/views/admin_panel.php';
    }
}
