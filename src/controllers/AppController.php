<?php

namespace App\Controllers;

class AppController
{
    public function run()
    {
        $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

        if ($uri === '/' || $uri === '/login') {
            $controller = new UserController();
            $controller->login();
        } elseif ($uri === '/register') {
            $controller = new UserController();
            $controller->register();
        } elseif ($uri === '/add-note') {
            $controller = new NoteController();
            $controller->addNote();
        } elseif ($uri === '/profile') {
            $controller = new UserController();
            $controller->profile();
        } elseif ($uri === '/admin') {
            $controller = new AdminController();
            $controller->adminPanel();
        } else {
            // Default action or 404
            echo "Page not found.";
        }
    }
}
