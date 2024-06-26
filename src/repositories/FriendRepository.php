<?php

namespace App\Repositories;

use PDO;

class FriendRepository
{
    private $pdo;

    public function __construct()
    {
        $dsn = 'pgsql:host=db;port=5432;dbname=notatki_db;';
        $username = 'user';
        $password = 'password';
        $this->pdo = new PDO($dsn, $username, $password);
    }

    public function addFriend($userId, $friendId)
    {
        $stmt = $this->pdo->prepare('INSERT INTO friends (user_id, friend_id) VALUES (:user_id, :friend_id)');
        $stmt->execute(['user_id' => $userId, 'friend_id' => $friendId]);
    }

    public function getFriendsByUserId($userId)
    {
        $stmt = $this->pdo->prepare('
            SELECT users.* 
            FROM users 
            JOIN friends ON users.id = friends.friend_id 
            WHERE friends.user_id = :user_id
        ');
        $stmt->execute(['user_id' => $userId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
