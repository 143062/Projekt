<?php

namespace App\Controllers;

use App\Repositories\NoteRepository;
use App\Repositories\FriendRepository;

class NoteController
{
    private $noteRepository;
    private $friendRepository;

    public function __construct()
    {
        $this->noteRepository = new NoteRepository();
        $this->friendRepository = new FriendRepository();
    }

    public function addNote()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $data = json_decode(file_get_contents('php://input'), true);
            $title = $data['title'];
            $content = $data['content'];
            $userId = $_SESSION['user_id'];

            $noteId = $this->noteRepository->addNote($userId, $title, $content);

            if ($noteId) {
                echo json_encode(['success' => true]);
            } else {
                echo json_encode(['success' => false]);
            }

            exit();
        }
    }

    public function dashboard()
    {
        $userId = $_SESSION['user_id'];
        $notes = $this->noteRepository->getNotesByUserId($userId);
        $sharedNotes = $this->noteRepository->getSharedNotesByUserId($userId);
        include 'public/views/dashboard.php';
    }
}
