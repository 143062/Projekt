<?php

namespace App\Controllers;

use App\Repositories\FriendRepository;
use App\Repositories\UserRepository;

class FriendController
{
    private $friendRepository;
    private $userRepository;

    public function __construct()
    {
        $this->friendRepository = new FriendRepository();
        $this->userRepository = new UserRepository();
    }

    public function friends()
    {
        $userId = $_SESSION['user_id'];
        $friends = $this->friendRepository->getFriendsByUserId($userId);
        $users = $this->userRepository->getAllUsersExcept($userId);
        include 'public/views/friends.php';
    }

    public function addFriend()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $userId = $_SESSION['user_id'];
            $friendId = $_POST['friend_id'];
            $this->friendRepository->addFriend($userId, $friendId);
            header('Location: /friends');
            exit();
        }
    }
}
