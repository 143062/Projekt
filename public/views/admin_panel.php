<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="/public/css/common.css">
    <link rel="stylesheet" href="/public/css/admin_panel.css">
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <a href="/logout" class="profile-button">
                <img src="/public/img/logout.svg" alt="Logout" class="profile-icon">
            </a>
            <h1 class="admin-title">Panel Administratora</h1>
            <img src="/public/img/logo.svg" alt="Logo" class="logo">
        </div>
        <div class="content">
            <div class="table-container">
                <h2>Aktualni użytkownicy</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nazwa Użytkownika</th>
                            <th>Email</th>
                            <th>Akcje</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>user1</td>
                            <td>user1@example.com</td>
                            <td>
                                <button class="delete-button">Usuń</button>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>user2</td>
                            <td>user2@example.com</td>
                            <td>
                                <button class="delete-button">Usuń</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="form-container">
                <h2>Dodaj Nowego Użytkownika</h2>
                <form>
                    <div class="form-group">
                        <label for="username">Nazwa Użytkownika:</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Hasło:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <button type="submit" class="add-button">Dodaj Użytkownika</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
