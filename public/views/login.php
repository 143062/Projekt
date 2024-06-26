<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logowanie</title>
    <link rel="stylesheet" href="/public/css/common.css">
    <link rel="stylesheet" href="/public/css/auth_common.css">
    <link rel="stylesheet" href="/public/css/login.css">
</head>
<body>
    <div class="container">
        <div class="auth-container">
            <div class="logo">
                <img src="/public/img/logo.svg" alt="Logo" class="logo__image">
            </div>
            <div class="login-form">
                <form action="/login" method="post" class="form-column">
                    <input type="text" id="login" name="login" placeholder="Login" required>
                    <input type="password" id="password" name="password" placeholder="Hasło" required>
                    <div class="buttons-container">
                        <button type="submit" class="form__submit">Zaloguj</button>
                        <a href="/register" class="form_redirect">Rejestracja</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
