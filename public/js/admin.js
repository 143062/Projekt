document.addEventListener('DOMContentLoaded', function() {
    const deleteButtons = document.querySelectorAll('.delete-button');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            const userId = this.getAttribute('data-id');
            if (confirm('Czy na pewno chcesz usunąć tego użytkownika?')) {
                fetch(`/delete_user.php?id=${userId}`, {
                    method: 'GET'
                })
                .then(response => response.text())
                .then(data => {
                    if (data === 'success') {
                        this.parentElement.parentElement.remove();
                    } else {
                        alert('Wystąpił błąd podczas usuwania użytkownika.');
                    }
                });
            }
        });
    });
});
