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
        session_start();
        $userId = $_SESSION['user_id'];
        $friends = $this->friendRepository->getFriendsByUserId($userId);
        header('Content-Type: application/json');
        echo json_encode($friends);
        exit();
    }

    public function addFriend()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            session_start();
            $userId = $_SESSION['user_id'];
            $friendLogin = trim($_POST['friend_login']);

            header('Content-Type: application/json');

            if (empty($friendLogin)) {
                echo json_encode(['success' => false, 'message' => 'Proszę wpisać login znajomego']);
                exit();
            }

            $friend = $this->userRepository->getUserByLogin($friendLogin);

            if ($friend) {
                if ($this->userRepository->isAdmin($friend['id'])) {
                    echo json_encode(['success' => false, 'message' => 'Nie możesz dodać admina']);
                    exit();
                }

                $friendId = $friend['id'];
                $result = $this->friendRepository->addFriend($userId, $friendId);

                if ($result) {
                    echo json_encode(['success' => true]);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Znajomy już istnieje na Twojej liście']);
                }
            } else {
                echo json_encode(['success' => false, 'message' => 'Nie znaleziono użytkownika']);
            }
            exit();
        }
    }

    public function deleteFriend()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            session_start();
            $userId = $_SESSION['user_id'];
            $friendLogin = trim($_POST['friend_login']);
    
            header('Content-Type: application/json');
    
            if (empty($friendLogin)) {
                echo json_encode(['success' => false, 'message' => 'ID znajomego jest wymagane', 'log' => 'Brak podanego loginu znajomego']);
                exit();
            }
    
            $friendId = $this->userRepository->getUserIdByLogin($friendLogin);
            if (!$friendId) {
                echo json_encode(['success' => false, 'message' => 'Nie znaleziono znajomego', 'log' => "Login $friendLogin nie istnieje w bazie"]);
                exit();
            }
    
            $result = $this->friendRepository->deleteFriend($userId, $friendId);
    
            if ($result) {
                echo json_encode(['success' => true, 'message' => 'Znajomy został usunięty', 'log' => "Znajomy o loginie $friendLogin został usunięty dla użytkownika $userId"]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Nie udało się usunąć znajomego', 'log' => "Błąd podczas usuwania znajomego $friendLogin dla użytkownika $userId"]);
            }
            exit();
        } else {
            // W przypadku innej metody niż POST, zwróć błąd w formacie JSON
            echo json_encode(['success' => false, 'message' => 'Niewłaściwa metoda HTTP', 'log' => 'Metoda nie jest POST']);
            exit();
        }
    }
    
    
    
}
