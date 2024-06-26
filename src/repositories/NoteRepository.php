<?php

namespace App\Repositories;

use PDO;

class NoteRepository
{
    private $pdo;

    public function __construct()
    {
        $dsn = 'pgsql:host=db;port=5432;dbname=notatki_db;';
        $username = 'user';
        $password = 'password';
        $this->pdo = new PDO($dsn, $username, $password);
    }

    public function addNote($userId, $title, $content)
    {
        $stmt = $this->pdo->prepare('INSERT INTO notes (user_id, title, content) VALUES (:user_id, :title, :content)');
        $stmt->execute(['user_id' => $userId, 'title' => $title, 'content' => $content]);
    }

    public function getNotesByUserId($userId)
    {
        $stmt = $this->pdo->prepare('SELECT * FROM notes WHERE user_id = :user_id');
        $stmt->execute(['user_id' => $userId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function shareNoteWithUser($noteId, $sharedWithUserId)
    {
        $stmt = $this->pdo->prepare('INSERT INTO shared_notes (note_id, shared_with_user_id) VALUES (:note_id, :shared_with_user_id)');
        $stmt->execute(['note_id' => $noteId, 'shared_with_user_id' => $sharedWithUserId]);
    }

    public function getSharedNotesByUserId($userId)
    {
        $stmt = $this->pdo->prepare('
            SELECT notes.* 
            FROM notes 
            JOIN shared_notes ON notes.id = shared_notes.note_id 
            WHERE shared_notes.shared_with_user_id = :user_id
        ');
        $stmt->execute(['user_id' => $userId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
