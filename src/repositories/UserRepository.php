<?php

namespace App\Repositories;

use PDO;

class UserRepository
{
    private $pdo;

    public function __construct()
    {
        $dsn = 'pgsql:host=db;port=5432;dbname=notatki_db;';
        $username = 'user';
        $password = 'password';
        $this->pdo = new PDO($dsn, $username, $password);
    }

    public function login($login, $password)
    {
        $stmt = $this->pdo->prepare('SELECT * FROM users WHERE login = :login');
        $stmt->execute(['login' => $login]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($password, $user['password'])) {
            return $user;
        }

        return false;
    }

    public function register($email, $login, $password)
    {
        $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
        $stmt = $this->pdo->prepare('INSERT INTO users (email, login, password, role) VALUES (:email, :login, :password, :role)');
        $stmt->execute(['email' => $email, 'login' => $login, 'password' => $hashedPassword, 'role' => 'user']);
    }

    public function getAllUsersExcept($userId)
    {
        $stmt = $this->pdo->prepare('SELECT * FROM users WHERE id != :user_id');
        $stmt->execute(['user_id' => $userId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
