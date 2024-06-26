<?php

namespace App\Models;

class User
{
    private $id;
    private $email;
    private $login;
    private $password;
    private $role;

    public function __construct($id, $email, $login, $password, $role = 'user')
    {
        $this->id = $id;
        $this->email = $email;
        $this->login = $login;
        $this->password = $password;
        $this->role = $role;
    }

    public function getId()
    {
        return $this->id;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function getLogin()
    {
        return $this->login;
    }

    public function getPassword()
    {
        return $this->password;
    }

    public function getRole()
    {
        return $this->role;
    }

    public function setPassword($password)
    {
        $this->password = password_hash($password, PASSWORD_BCRYPT);
    }

    public function setEmail($email)
    {
        $this->email = $email;
    }

    public function setLogin($login)
    {
        $this->login = $login;
    }

    public function setRole($role)
    {
        $this->role = $role;
    }
}
